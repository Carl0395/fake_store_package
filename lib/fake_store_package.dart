import 'package:dartz/dartz.dart';
import 'package:fake_store_package/api/auth/auth_api.dart';
import 'package:fake_store_package/api/carts/carts_api.dart';
import 'package:fake_store_package/api/products/products_api.dart';
import 'package:fake_store_package/api/users/users_api.dart';
import 'package:fake_store_package/models/cart_model.dart';
import 'package:fake_store_package/models/product_model.dart';
import 'package:fake_store_package/models/user_model.dart';
import 'package:fake_store_package/util/failures.dart';
import 'package:fake_store_package/util/http_helper.dart';

class FakeStorePackage {
  final IHttpHelper httpHelper;
  late final AuthApi authApi;
  late final ProductsApi productsApi;
  late final CartsApi cartsApi;
  late final UsersApi usersApi;

  FakeStorePackage(this.httpHelper) {
    authApi = AuthApi(httpHelper);
    productsApi = ProductsApi(httpHelper);
    cartsApi = CartsApi(httpHelper);
    usersApi = UsersApi(httpHelper);
  }

  Future<Either<Failure, String>> login({required String username, required String password,}) => authApi.login(username: username, password: password);

  Future<Either<Failure, List<CartModel>>> getCarts() => cartsApi.getCarts();
  Future<Either<Failure, CartModel>> getCart(String id) => cartsApi.getCart(id);

  Future<Either<Failure, List<ProductModel>>> getProducts() => productsApi.getProducts();
  Future<Either<Failure, List<String>>> getCategories() => productsApi.getCategories();
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(String category) => productsApi.getProductsByCategory(category);

  Future<Either<Failure, UserModel>> getUser(String id) => usersApi.getUser(id);
  Future<Either<Failure, int>> createUser(UserModel user) => usersApi.createUser(user);
}
