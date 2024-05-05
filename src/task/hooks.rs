use log::info;

use crate::{config::Config, errors::Error, helpers::exec};
use std::process::Command;

pub fn update(config: Config) -> Result<(), Error> {
    info!("running configured hooks");
    for hook in config.hooks.into_iter() {
        exec(&mut Command::new(&hook))?;
    }
    Ok(())
}
