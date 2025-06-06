import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fake_store_package/models/product_model.dart';
import 'package:fake_store_package/util/failures.dart';
import 'package:fake_store_package/util/http_helper.dart';
import 'package:fake_store_package/util/routes.dart';

class ProductsApi {
  final IHttpHelper httpHelper;

  ProductsApi(this.httpHelper);

  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    final res = await httpHelper.get(Routes.products);

    return res.fold((failure) => Left(failure), (data) {
      try {
        final List<dynamic> jsonData = json.decode(data.body);
        final List<ProductModel> products =
            jsonData.map((item) => ProductModel.fromJson(item)).toList();
        return Right(products);
      } catch (e) {
        return Left(ParsingFailure(e.toString()));
      }
    });
  }

  Future<Either<Failure, List<String>>> getCategories() async {
    final res = await httpHelper.get(Routes.categories);

    return res.fold((failure) => Left(failure), (data) {
      try {
        final List<String> categories =
            (json.decode(data.body) as List).map((item) => '$item').toList();
        return Right(categories);
      } catch (e) {
        return Left(ParsingFailure(e.toString()));
      }
    });
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
    String category,
  ) async {
    final res = await httpHelper.get(
      Routes.productsByCategory.replaceAll(':category', category),
    );

    return res.fold((failure) => Left(failure), (data) {
      try {
        final List<dynamic> jsonData = json.decode(data.body);
        final List<ProductModel> products =
            jsonData.map((item) => ProductModel.fromJson(item)).toList();
        return Right(products);
      } catch (e) {
        return Left(ParsingFailure(e.toString()));
      }
    });
  }
}
