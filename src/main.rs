use clap::{Parser, Subcommand};
use config::{read_config, Config};
use errors::Error;
use log::{info, LevelFilter};
use std::{env, process::exit};
use task::{bun, deno, flatpak, hooks, os, ruby, rust};

mod config;
mod errors;
mod helpers;
mod task;

/// fix all vulnerabilities that are fixed
#[derive(Parser)]
#[command(author, version, about, long_about = None, arg_required_else_help = true)]
struct Args {
    #[command(subcommand)]
    command: Option<Commands>,
}

#[derive(Subcommand)]
enum Commands {
    /// Run all update tasks
    All {},
    /// Update Bun
    Bun {},
    /// Update Deno
    Deno {},
    /// Update Flatpak packages
    Flatpak {},
    /// Run configured hook scripts
    Hooks {},
    /// Update OS packages (supports RHEL-like, Gentoo, Ubuntu)
    OS {},
    /// Update Rust and Cargo packages
    Rust {},
    /// Update Ruby and Gems
    Ruby {},
    /// Test command for development
    Test {},
}

fn main() {
    match env::var("RUST_LOG") {
        Ok(_) => pretty_env_logger::init(),
        Err(_) => pretty_env_logger::formatted_builder()
            .filter(None, LevelFilter::Info)
            .init(),
    }
    // parse CLI args
    let args = Args::parse();
    let config = read_config().expect("there was an issue reading the configuration file");
    match main_aux(config, args.command) {
        Ok(_) => (),
        Err(e) => {
            eprintln!("quitting with error {:?}", e);
            exit(1);
        }
    }
}
fn main_aux(config: Option<Config>, cmd: Option<Commands>) -> Result<(), Error> {
    match cmd {
        Some(cmd) => match cmd {
            Commands::All {} => {
                rust::update()?;
                os::update()?;
                deno::update()?;
                bun::update()?;
                ruby::update()?;
                flatpak::update()?;
                Ok(())
            }
            Commands::Bun {} => {
                bun::update()?;
                Ok(())
            }
            Commands::Deno {} => {
                deno::update()?;
                Ok(())
            }
            Commands::Flatpak {} => {
                flatpak::update()?;
                Ok(())
            }
            Commands::Hooks {} => match config {
                Some(config) => {
                    hooks::update(config)?;
                    Ok(())
                }
                None => {
                    info!("no hooks configured");
                    Ok(())
                }
            },
            Commands::OS {} => {
                os::update()?;
                Ok(())
            }
            Commands::Ruby {} => {
                ruby::update()?;
                Ok(())
            }
            Commands::Rust {} => {
                rust::update()?;
                Ok(())
            }
            Commands::Test {} => {
                info!("testing...");
                Ok(())
            }
        },
        None => Ok(()),
    }
}
