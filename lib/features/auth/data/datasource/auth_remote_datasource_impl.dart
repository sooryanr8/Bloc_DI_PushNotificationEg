import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/constants/url_constants.dart';
import '../../../../core/logger/logger_helper.dart';

import '../datasource/auth_remote_datasource.dart';
import '../models/token_model.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Client client;

  AuthRemoteDatasourceImpl(this.client);

  @override
  Future<TokenModel> login({
    required String username,
    required String password,
  }) async {
    try {
      logInfo("LOGIN URL -> ${UrlConstants.keycloakToken}");

      final response = await client
          .post(
            Uri.parse(UrlConstants.keycloakToken),

            headers: {"Content-Type": "application/x-www-form-urlencoded"},

            body: {
              "grant_type": "password",
              "client_id": "flutter_client",
              "username": username,
              "password": password,
            },
          )
          .timeout(const Duration(seconds: 15));

      logInfo("LOGIN STATUS -> ${response.statusCode}");
      logDebug("LOGIN BODY -> ${response.body}");

      if (response.statusCode != 200) {
        logError("LOGIN FAILED -> ${response.body}");
        throw Exception(response.body);
      }

      logInfo("LOGIN SUCCESS");

      return TokenModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      logError("LOGIN ERROR -> $e");
      rethrow;
    }
  }

  @override
  Future<TokenModel> refreshToken({required String refreshToken}) async {
    try {
      logInfo("REFRESH URL -> ${UrlConstants.keycloakToken}");

      final response = await client.post(
        Uri.parse(UrlConstants.keycloakToken),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},

        body: {
          "grant_type": "refresh_token",
          "client_id": "flutter_client",
          "refresh_token": refreshToken,
        },
      );

      logInfo("REFRESH STATUS -> ${response.statusCode}");
      logDebug("REFRESH BODY -> ${response.body}");

      if (response.statusCode != 200) {
        logError("REFRESH FAILED");
        throw Exception("Refresh failed");
      }
      logInfo("REFRESH SUCCESS");
      return TokenModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      logError("REFRESH ERROR -> $e");

      rethrow;
    }
  }

  @override
  Future<void> logout({required String refreshToken}) async {
    try {
      logInfo("LOGOUT URL -> ${UrlConstants.keycloakLogout}");
      final response = await client.post(
        Uri.parse(UrlConstants.keycloakLogout),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"client_id": "flutter_client", "refresh_token": refreshToken},
      );

      logInfo("LOGOUT STATUS -> ${response.statusCode}");
      if (response.statusCode != 200 && response.statusCode != 204) {
        logError("LOGOUT FAILED -> ${response.body}");
        throw Exception("Logout failed");
      }

      logInfo("LOGOUT SUCCESS");
    } catch (e) {
      logError("LOGOUT ERROR -> $e");
      rethrow;
    }
  }
}
