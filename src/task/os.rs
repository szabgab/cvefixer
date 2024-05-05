use crate::{errors::Error, helpers::exec};
use log::{info, warn};
use std::{
    fs::{self, File},
    io::{self, BufRead},
    process::Command,
};
use time::{format_description::well_known::Rfc2822, Duration, OffsetDateTime};

pub fn update() -> Result<(), Error> {
    info!("updating and cleaning OS packages");
    let os = get_os()?;
    match os {
        OS::RHELLike => {
            info!("detected RHEL-like OS");
            exec(Command::new("sudo").args(["dnf", "update", "-y"]))?;
            exec(Command::new("sudo").args(["dnf", "autoremove", "-y"]))?;
        }
        OS::Gentoo => {
            info!("detected Gentoo (you are hard-core)");
            let timestamp = fs::read_to_string("/var/db/repos/gentoo/metadata/timestamp.chk")?;
            let timestamp = OffsetDateTime::parse(&timestamp, &Rfc2822)?;
            let should_pull_packages =
                match OffsetDateTime::now_utc().checked_sub(Duration::days(1)) {
                    Some(one_day_ago) => timestamp < one_day_ago,
                    None => {
                        warn!("could not execute simple date math");
                        true
                    }
                };
            if should_pull_packages {
                exec(Command::new("sudo").args(["dnf", "autoremove", "-y"]))?;
            }
        }
        OS::Ubuntu => {
            info!("detected Ubuntu");
            exec(Command::new("sudo").args(["apt", "update"]))?;
            exec(Command::new("sudo").args(["apt", "upgrade", "-y"]))?;
            exec(Command::new("sudo").args(["apt", "autoremove", "-y"]))?;
        }
    }
    Ok(())
}

#[derive(Debug)]
enum OS {
    RHELLike,
    Gentoo,
    Ubuntu,
}

fn get_os() -> Result<OS, Error> {
    let file = File::open("/etc/os-release")?;
    let id = io::BufReader::new(file).lines().find(|line| match line {
        Ok(line) => line.starts_with("ID="),
        Err(_) => false,
    });
    match id {
        Some(id) => match id {
            Ok(id) => {
                if id.contains("rhel") || id.contains("rocky") || id.contains("fedora") {
                    Ok(OS::RHELLike)
                } else if id.contains("ubuntu") || id.contains("debian") {
                    Ok(OS::Ubuntu)
                } else if id.contains("gentoo") {
                    Ok(OS::Gentoo)
                } else {
                    Err(Error::UnsupportedOS)
                }
            }
            Err(e) => Err(e.into()),
        },
        None => Err(Error::CouldNotDetermineOS),
    }
}
