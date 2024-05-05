/// Our generic error type
#[derive(Debug)]
pub enum Error {
    CouldNotDetermineOS,
    DateParse(time::error::Parse),
    EnvVar(std::env::VarError),
    IO(std::io::Error),
    JSON(serde_json::Error),
    NonZeroExitStatus,
    Utf8String(std::string::FromUtf8Error),
    UnsupportedOS,
}

impl From<std::io::Error> for Error {
    fn from(e: std::io::Error) -> Self {
        Error::IO(e)
    }
}

impl From<time::error::Parse> for Error {
    fn from(e: time::error::Parse) -> Self {
        Error::DateParse(e)
    }
}

impl From<std::string::FromUtf8Error> for Error {
    fn from(e: std::string::FromUtf8Error) -> Self {
        Error::Utf8String(e)
    }
}

impl From<std::env::VarError> for Error {
    fn from(e: std::env::VarError) -> Self {
        Error::EnvVar(e)
    }
}

impl From<serde_json::Error> for Error {
    fn from(e: serde_json::Error) -> Self {
        Error::JSON(e)
    }
}
