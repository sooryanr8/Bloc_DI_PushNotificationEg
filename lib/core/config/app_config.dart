import 'package:test1/core/config/environment.dart';

class AppConfig {
  static late Environment env;

  static void initialize(
      Environment environment,
      ) {
    env = environment;
  }

  static String get apiBaseUrl {
    switch (env) {
      case Environment.dev:
        return "http://192.168.1.33:8000";

      case Environment.qa:
        return "https://qa-api.myapp.com";

      case Environment.prod:
        return "https://api.myapp.com";
    }
  }

  static String get authBaseUrl {
    switch (env) {
      case Environment.dev:
        return "http://192.168.1.33:8080";

      case Environment.qa:
        return "https://qa-auth.myapp.com";

      case Environment.prod:
        return "https://auth.myapp.com";
    }
  }
}