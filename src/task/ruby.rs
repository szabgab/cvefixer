use crate::{errors::Error, helpers::exec};
use log::info;
use std::{env, path::Path, process::Command};

pub fn update() -> Result<(), Error> {
    let home = env::var("HOME")?;
    let path = Path::new(&home).join(".rbenv");
    if path.is_dir() {
        info!("updating rbenv");
        exec(
            Command::new("git")
                .arg("-C")
                .arg(&path)
                .arg("pull")
                .arg("origin"),
        )?;
        exec(Command::new("gem").args(["update", "--system"]))?;
        exec(Command::new("gem").arg("update"))?;
    }
    Ok(())
}
