import 'package:fake_store_package/models/cart_model.dart';
import 'package:fake_store_package/models/product_quantity_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartModel', () {
    final sampleJson = {
      "id": 1,
      "userId": 10,
      "date": "2023-12-01T00:00:00.000Z",
      "products": [
        {"productId": 5, "quantity": 2},
        {"productId": 7, "quantity": 3},
      ],
      "__v": 0,
    };

    test('fromJson crea una instancia válida', () {
      final cart = CartModel.fromJson(sampleJson);

      expect(cart.id, equals(1));
      expect(cart.userId, equals(10));
      expect(cart.date, DateTime.parse("2023-12-01T00:00:00.000Z"));
      expect(cart.products, isA<List<ProductQuantityModel>>());
      expect(cart.products!.length, equals(2));
      expect(cart.products![0].productId, equals(5));
      expect(cart.products![1].quantity, equals(3));
      expect(cart.v, equals(0));
    });

    test('toJson devuelve un mapa válido', () {
      final cart = CartModel.fromJson(sampleJson);
      final json = cart.toJson();

      expect(json['id'], equals(1));
      expect(json['userId'], equals(10));
      expect(json['date'], equals("2023-12-01T00:00:00.000Z"));
      expect(json['products'], isA<List>());
      expect(json['products'][0]['productId'], equals(5));
      expect(json['__v'], equals(0));
    });

    test('copyWith modifica solo los campos especificados', () {
      final original = CartModel.fromJson(sampleJson);
      final copy = original.copyWith(userId: 99);

      expect(copy.id, equals(original.id));
      expect(copy.userId, equals(99));
      expect(copy.date, equals(original.date));
      expect(copy.products, equals(original.products));
      expect(copy.v, equals(original.v));
    });

    test('toString devuelve un JSON con indentación', () {
      final cart = CartModel.fromJson(sampleJson);
      final result = cart.toString();

      expect(result, contains('"userId": 10'));
      expect(result, contains('"productId": 5'));
      expect(result, contains('\n  ')); // Verifica indentación
    });

    test('fromJson con null en productos devuelve lista vacía', () {
      final jsonWithNullProducts = {
        "id": 2,
        "userId": 11,
        "date": null,
        "products": null,
        "__v": 1,
      };

      final cart = CartModel.fromJson(jsonWithNullProducts);

      expect(cart.products, isEmpty);
      expect(cart.date, isNull);
    });
  });
}
