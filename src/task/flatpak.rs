use crate::{
    errors::Error,
    helpers::{cmd_exists, exec},
};
use log::info;
use std::process::Command;

pub fn update() -> Result<(), Error> {
    if cmd_exists("flatpak") {
        info!("updating flatpak packages");
        exec(Command::new("sudo").args(["flatpak", "update", "-y"]))
    } else {
        info!("no flatpak found");
        Ok(())
    }
}
