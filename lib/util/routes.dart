class Routes {
  Routes._(); // coverage:ignore-line
  static const _domain = 'https://fakestoreapi.com';

  static const login = '$_domain/auth/login';

  static const products = '$_domain/products';
  static const categories = '$_domain/products/categories';
  static const productsByCategory = '$_domain/products/category/:category';

  static const carts = '$_domain/carts';
  static const users = '$_domain/users';
}
