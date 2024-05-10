use log::debug;

use crate::errors::Error;
use std::process::{Command, Stdio};
use which::which;

pub fn exec(cmd: &mut Command) -> Result<(), Error> {
    debug!("executing {:?}", &cmd);
    let res = cmd.status()?;
    if res.success() {
        Ok(())
    } else {
        Err(Error::NonZeroExitStatus)
    }
}

pub fn cmd_exists(cmd: &str) -> bool {
    match which(cmd) {
        Ok(_) => true,
        Err(_) => false,
    }
}
