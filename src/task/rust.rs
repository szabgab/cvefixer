use crate::{
    errors::Error,
    helpers::{cmd_exists, exec},
};
use log::{debug, info};
use std::process::Command;

fn rustup() -> Result<(), Error> {
    if cmd_exists("rustup") {
        info!("running `rustup update`");
        exec(Command::new("rustup").arg("update"))?;
    } else {
        info!("no rustup found");
    }
    Ok(())
}
fn cargo_update() -> Result<(), Error> {
    if cmd_exists("cargo") {
        info!("updating cargo packages");
        let output = Command::new("cargo").args(["install", "--list"]).output()?;
        let packages = output
            .stdout
            .split(|x| *x == b'\n')
            .map(|x| match x.get(0) {
                Some(_) => x.split(|c| *c == b' ').nth(0),
                None => None,
            })
            .filter(|x| match x {
                Some(x) => *x.get(0).unwrap_or(&b' ') != b' ',
                None => false,
            });
        for pkg in packages {
            match pkg {
                Some(pkg) => {
                    let pkg = String::from_utf8(pkg.to_vec())?;
                    debug!("updating cargo package {}", &pkg);
                    exec(Command::new("cargo").arg("install").arg(&pkg))?;
                }
                None => (),
            }
        }
    } else {
        info!("no cargo found");
    }
    Ok(())
}

pub fn update() -> Result<(), Error> {
    info!("updating rust components");
    rustup()?;
    cargo_update()
}
