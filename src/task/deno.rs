use crate::{
    errors::Error,
    helpers::{cmd_exists, exec},
};
use log::info;
use std::process::Command;

pub fn update() -> Result<(), Error> {
    if cmd_exists("deno") {
        info!("updating deno");
        exec(Command::new("deno").arg("upgrade"))
    } else {
        info!("no deno found");
        Ok(())
    }
}
