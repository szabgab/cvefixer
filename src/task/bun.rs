use crate::{
    errors::Error,
    helpers::{cmd_exists, exec},
};
use log::info;
use std::process::Command;

pub fn update() -> Result<(), Error> {
    if cmd_exists("bun") {
        info!("updating bun");
        exec(Command::new("bun").arg("upgrade"))
    } else {
        info!("no bun found");
        Ok(())
    }
}
