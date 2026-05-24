import '../config/app_config.dart';

class UrlConstants {

  static String get patientSearch =>
      "${AppConfig.apiBaseUrl}/patients";

  static String get keycloakToken =>
      "${AppConfig.authBaseUrl}/realms/test1/protocol/openid-connect/token";

}