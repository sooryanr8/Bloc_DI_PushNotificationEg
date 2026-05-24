import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/constants/url_constants.dart';

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
      print("LOGIN URL -> ${UrlConstants.keycloakToken}");

      final response = await client
          .post(
            Uri.parse(UrlConstants.keycloakToken),
            headers: {

              "Content-Type":
              "application/x-www-form-urlencoded",

            },
            body: {
              "grant_type": "password",

              "client_id": "flutter_client",

              "username": username,

              "password": password,
            },
          )
          .timeout(const Duration(seconds: 15));

      print("STATUS -> ${response.statusCode}");

      print("BODY -> ${response.body}");

      if (response.statusCode != 200) {
        throw Exception(response.body);
      }

      return TokenModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("LOGIN ERROR -> $e");

      rethrow;
    }
  }

  @override
  Future<TokenModel> refreshToken({required String refreshToken}) async {
    print("REFRESH URL -> ${UrlConstants.keycloakToken}");

    final response = await client.post(
      Uri.parse(UrlConstants.keycloakToken),

      headers: {

        "Content-Type":
        "application/x-www-form-urlencoded",

      },

      body: {
        "grant_type": "refresh_token",

        "client_id": "flutter_client",

        "refresh_token": refreshToken,
      },
    );

    print("STATUS -> ${response.statusCode}");

    print("BODY -> ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Refresh failed");
    }

    return TokenModel.fromJson(jsonDecode(response.body));
  }
}
