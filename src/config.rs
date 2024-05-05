use crate::errors::Error;
use fastrand::shuffle;
use log::info;
use serde::Deserialize;
use std::{env, fs, path::Path};

#[derive(Clone, Deserialize)]
pub struct Config {
    pub hooks: Vec<String>,
}

pub fn read_config() -> Result<Option<Config>, Error> {
    let home = env::var("HOME")?;
    let mut config_paths = [
        ".config/cvefixer/cvefixer.json",
        ".config/cvefixer/config.json",
        ".config/cvefixer.json",
        "cvefixer.json",
        ".cvefixer.json",
    ]
    .to_vec();
    shuffle(&mut config_paths);
    let config_path = config_paths
        .into_iter()
        .find(|path| Path::new(&home).join(&path).is_file());
    match config_path {
        Some(config_path) => {
            let config_path = Path::new(&home).join(&config_path);
            info!(
                "reading configuration from {}",
                &config_path.to_str().unwrap_or_default()
            );
            let config = fs::read_to_string(&config_path)?;
            let config: Config = serde_json::from_str(&config)?;
            Ok(Some(config))
        }
        None => Ok(None),
    }
}
