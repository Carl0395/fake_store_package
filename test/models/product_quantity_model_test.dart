import 'package:fake_store_package/models/product_quantity_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductQuantityModel', () {
    final sampleJson = {"productId": 42, "quantity": 3};

    test('fromJson crea una instancia válida', () {
      final model = ProductQuantityModel.fromJson(sampleJson);

      expect(model.productId, 42);
      expect(model.quantity, 3);
    });

    test('toJson devuelve un mapa válido', () {
      final model = ProductQuantityModel(productId: 42, quantity: 3);
      final json = model.toJson();

      expect(json['productId'], 42);
      expect(json['quantity'], 3);
    });

    test('copyWith sobrescribe correctamente los campos', () {
      final original = ProductQuantityModel(productId: 1, quantity: 2);
      final copy = original.copyWith(quantity: 5);

      expect(copy.productId, 1);
      expect(copy.quantity, 5);
    });

    test('copyWith sin argumentos retorna una copia idéntica', () {
      final original = ProductQuantityModel(productId: 1, quantity: 2);
      final copy = original.copyWith();

      expect(copy.productId, original.productId);
      expect(copy.quantity, original.quantity);
    });
  });
}
