import 'package:fake_store_package/models/product_model.dart';
import 'package:fake_store_package/models/rating_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductModel', () {
    final sampleJson = {
      "id": 1,
      "title": "Test Product",
      "price": 29.99,
      "description": "A test product description.",
      "category": "electronics",
      "image": "https://example.com/image.png",
      "rating": {"rate": 4.5, "count": 120},
    };

    test('fromJson crea una instancia válida', () {
      final product = ProductModel.fromJson(sampleJson);

      expect(product.id, 1);
      expect(product.title, "Test Product");
      expect(product.price, 29.99);
      expect(product.description, "A test product description.");
      expect(product.category, "electronics");
      expect(product.image, "https://example.com/image.png");
      expect(product.rating, isA<RatingModel>());
      expect(product.rating!.rate, 4.5);
      expect(product.rating!.count, 120);
    });

    test('toJson devuelve un mapa válido', () {
      final product = ProductModel.fromJson(sampleJson);
      final json = product.toJson();

      expect(json['id'], 1);
      expect(json['title'], "Test Product");
      expect(json['price'], 29.99);
      expect(json['description'], isA<String>());
      expect(json['category'], "electronics");
      expect(json['image'], startsWith("https://"));
      expect(json['rating'], isA<Map>());
      expect(json['rating']['rate'], 4.5);
    });

    test('copyWith sobrescribe correctamente los campos indicados', () {
      final original = ProductModel.fromJson(sampleJson);
      final copy = original.copyWith(title: "Modified");

      expect(copy.id, original.id);
      expect(copy.title, "Modified");
      expect(copy.price, original.price);
      expect(copy.rating, original.rating);
    });

    test('toString devuelve un JSON legible con indentación', () {
      final product = ProductModel.fromJson(sampleJson);
      final result = product.toString();

      expect(result, contains('"title": "Test Product"'));
      expect(result, contains('\n  ')); // Verifica indentación
    });

    test('fromJson con rating null no lanza error', () {
      final jsonWithNullRating = {...sampleJson, "rating": null};

      final product = ProductModel.fromJson(jsonWithNullRating);

      expect(product.rating, isNull);
    });
  });
}
