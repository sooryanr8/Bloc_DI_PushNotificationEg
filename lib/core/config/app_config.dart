import 'package:test1/core/config/environment.dart';

class AppConfig {
  static late Environment env;

  static void initialize(Environment environment) {
    env = environment;
  }

  static String get baseUrl {
    switch (env) {
      case Environment.dev:
        return "http://192.168.1.10:8000"; // local FastAPI
      case Environment.qa:
        return "https://qa-api.myapp.com";
      case Environment.prod:
        return "https://api.myapp.com";
    }
  }

  static bool get enableLogs {
    return env != Environment.prod;
  }
}
