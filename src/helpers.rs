use log::debug;

use crate::errors::Error;
use std::process::{Command, Stdio};

pub fn exec(cmd: &mut Command) -> Result<(), Error> {
    debug!("executing {:?}", &cmd);
    let res = cmd.status()?;
    if res.success() {
        Ok(())
    } else {
        Err(Error::NonZeroExitStatus)
    }
}

pub fn exec_silent(cmd: &mut Command) -> Result<(), Error> {
    debug!("executing {:?}", &cmd);
    let res = cmd
        .stdin(Stdio::null())
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .status()?;
    if res.success() {
        Ok(())
    } else {
        Err(Error::NonZeroExitStatus)
    }
}

pub fn cmd_exists(cmd: &str) -> bool {
    debug!("checking if {:?} exists", &cmd);
    match exec_silent(Command::new("command").arg("-v").arg(cmd)) {
        Ok(_) => true,
        Err(_) => false,
    }
}
