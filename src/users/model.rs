use regex::Regex;
use serde_derive::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize)]
pub struct User {
    pub id: i32,
    pub email: String,
    pub password: String,
    pub fullname: String,
    pub role: String
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UpsertUser {
    pub email: String,
    pub password: String,
    pub fullname: String,
    pub role: String,
}

impl UpsertUser {
    pub fn is_valid_email(&self) -> bool {
        let email_pattern = Regex::new(r"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$").unwrap();
        email_pattern.is_match(&self.email)
    }
}

pub fn validate_email(body: &UpsertUser) -> bool {
    body.is_valid_email()
}