class Paths {
  factory Paths() {
    return _instance;
  }

  Paths._();

  static final Paths _instance = Paths._();

  static String loader = "assets/loader/loader.json";

  static String errorImage = "assets/images/error.svg";
  static String locationImage = "assets/images/location.svg";
}
Paths paths = Paths();