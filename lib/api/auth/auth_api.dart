import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fake_store_package/models/user_model.dart';
import 'package:fake_store_package/util/failures.dart';
import 'package:fake_store_package/util/http_helper.dart';
import 'package:fake_store_package/util/routes.dart';

class AuthApi {
  static Future<Either<Failure, String>> login({
    required String email,
    required String password,
  }) async {
    final res = await HttpHelper.post(Routes.login, {
      "email": email,
      "password": password,
    });

    return res.fold((failure) => Left(failure), (data) {
      try {
        final dynamic jsonData = json.decode(data.body);
        final String token = jsonData["token"];
        return Right(token);
      } catch (e) {
        return Left(ParsingFailure(e.toString()));
      }
    });
  }
}
