import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fake_store_package/models/user_model.dart';
import 'package:fake_store_package/util/failures.dart';
import 'package:fake_store_package/util/http_helper.dart';
import 'package:fake_store_package/util/routes.dart';

class UsersApi {
  final IHttpHelper httpHelper;

  UsersApi(this.httpHelper);

  Future<Either<Failure, UserModel>> getUser(String id) async {
    final res = await httpHelper.get('${Routes.users}/$id');

    return res.fold((failure) => Left(failure), (data) {
      try {
        final dynamic jsonData = json.decode(data.body);
        UserModel user = UserModel.fromJson(jsonData);
        return Right(user);
      } catch (e) {
        return Left(ParsingFailure(e.toString()));
      }
    });
  }

  Future<Either<Failure, int>> createUser(UserModel user) async {
    final res = await httpHelper.post(Routes.users, user.toJson());

    return res.fold((failure) => Left(failure), (data) {
      try {
        final dynamic jsonData = json.decode(data.body);
        final int id = jsonData["id"];
        return Right(id);
      } catch (e) {
        return Left(ParsingFailure(e.toString()));
      }
    });
  }
}
