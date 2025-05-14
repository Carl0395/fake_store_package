import 'package:dartz/dartz.dart';
import 'package:fake_store_package/api/auth/auth_api.dart';
import 'package:fake_store_package/api/carts/carts_api.dart';
import 'package:fake_store_package/api/products/products_api.dart';
import 'package:fake_store_package/api/users/users_api.dart';
import 'package:fake_store_package/models/cart_model.dart';
import 'package:fake_store_package/models/product_model.dart';
import 'package:fake_store_package/models/user_model.dart';
import 'package:fake_store_package/util/failures.dart';

class FakeStorePackage {
  FakeStorePackage._();

  static Future<Either<Failure, String>> login({
    required String username,
    required String password,
  }) => AuthApi.login(username: username, password: password);

  static Future<Either<Failure, List<CartModel>>> getCarts() =>
      CartsApi.getCarts();
  static Future<Either<Failure, CartModel>> getCart(String id) =>
      CartsApi.getCart(id);

  static Future<Either<Failure, List<ProductModel>>> getProducts() =>
      ProductsApi.getProducts();
  static Future<Either<Failure, List<String>>> getCategories() =>
      ProductsApi.getCategories();
  static Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
    String category,
  ) => ProductsApi.getProductsByCategory(category);

  static Future<Either<Failure, UserModel>> getUser(String id) =>
      UsersApi.getUser(id);
  static Future<Either<Failure, int>> createUser(UserModel user) =>
      UsersApi.createUser(user);
}
