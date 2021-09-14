class Config {
  static final production = true;
  static final backendBaseUrl = production
      ? "jey-inventory.herokuapp.com": "localhost:8000";
}