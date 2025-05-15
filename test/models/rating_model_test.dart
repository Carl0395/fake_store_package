import 'package:fake_store_package/models/rating_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RatingModel', () {
    final sampleJson = {"rate": 4.7, "count": 99};

    test('fromJson crea una instancia válida', () {
      final rating = RatingModel.fromJson(sampleJson);

      expect(rating.rate, 4.7);
      expect(rating.count, 99);
    });

    test('toJson devuelve un mapa válido', () {
      final rating = RatingModel(rate: 4.7, count: 99);
      final json = rating.toJson();

      expect(json['rate'], 4.7);
      expect(json['count'], 99);
    });

    test('copyWith sobrescribe correctamente los campos', () {
      final original = RatingModel(rate: 4.0, count: 50);
      final copy = original.copyWith(count: 60);

      expect(copy.rate, 4.0);
      expect(copy.count, 60);
    });

    test('copyWith sin argumentos retorna una copia idéntica', () {
      final original = RatingModel(rate: 4.0, count: 50);
      final copy = original.copyWith();

      expect(copy.rate, original.rate);
      expect(copy.count, original.count);
    });

    test('fromJson convierte correctamente números enteros a double', () {
      final jsonWithIntRate = {
        "rate": 5, // int
        "count": 10,
      };

      final rating = RatingModel.fromJson(jsonWithIntRate);

      expect(rating.rate, 5.0); // debe convertir a double
      expect(rating.count, 10);
    });
  });
}
