import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fake_store_package/models/cart_model.dart';
import 'package:fake_store_package/util/failures.dart';
import 'package:fake_store_package/util/http_helper.dart';
import 'package:fake_store_package/util/routes.dart';

class CartsApi {
  final IHttpHelper httpHelper;

  CartsApi(this.httpHelper);

  Future<Either<Failure, List<CartModel>>> getCarts() async {
    final res = await httpHelper.get(Routes.carts);

    return res.fold((failure) => Left(failure), (data) {
      try {
        final List<dynamic> jsonData = json.decode(data.body);
        final List<CartModel> carts =
            jsonData.map((item) => CartModel.fromJson(item)).toList();
        return Right(carts);
      } catch (e) {
        return Left(ParsingFailure(e.toString()));
      }
    });
  }

  Future<Either<Failure, CartModel>> getCart(String id) async {
    final res = await httpHelper.get('${Routes.carts}/$id');

    return res.fold((failure) => Left(failure), (data) {
      try {
        final dynamic jsonData = json.decode(data.body);
        final CartModel cart = CartModel.fromJson(jsonData);
        return Right(cart);
      } catch (e) {
        return Left(ParsingFailure(e.toString()));
      }
    });
  }
}
