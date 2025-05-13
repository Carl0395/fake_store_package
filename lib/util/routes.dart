class Routes {
  Routes._();
  static const _domain = 'https://fakestoreapi.com';

  static const login = '$_domain/auth/login';

  static const products = '$_domain/products';
  static const carts = '$_domain/carts';
  static const users = '$_domain/users';
}
