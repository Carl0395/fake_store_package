import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fake_store_package/fake_store_package.dart';
import 'package:fake_store_package/models/cart_model.dart';
import 'package:fake_store_package/util/failures.dart';
import 'package:fake_store_package/util/http_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

// Mock personalizado
class MockHttpHelper extends Mock implements HttpHelper {}

void main() {
  late MockHttpHelper mockHttpHelper;
  late FakeStorePackage fakeStore;

  setUpAll(() {
    mockHttpHelper = MockHttpHelper();
    fakeStore = FakeStorePackage(mockHttpHelper);
  });

  group('CartsApi.getCarts', () {
    test(
      'Retorna los carritos de compras cuando la respuesta es exitosa y válida',
      () async {
        final jsonData = [
          {
            "id": 1,
            "userId": 1,
            "date": "2020-03-02T00:00:00.000Z",
            "products": [
              {"productId": 1, "quantity": 4},
              {"productId": 2, "quantity": 1},
              {"productId": 3, "quantity": 6},
            ],
            "__v": 0,
          },
        ];

        // Simula una respuesta HTTP válida
        final mockResponse = http.Response(jsonEncode(jsonData), 200);

        when(
          () => mockHttpHelper.get(any()),
        ).thenAnswer((_) async => Right(mockResponse));

        final result = await fakeStore.getCarts();

        expect(result.isRight(), true);
        expect(result.getOrElse(() => []).length, 1);
      },
    );

    test('Retorna error parsing failure', () async {
      // Simula una respuesta HTTP válida
      final mockResponse = http.Response(jsonEncode('malformed data'), 401);

      when(
        () => mockHttpHelper.get(any()),
      ).thenAnswer((_) async => Right(mockResponse));

      final result = await fakeStore.getCarts();

      expect(result.isLeft(), true);

      result.fold(
        (failure) => expect(failure, isA<ParsingFailure>()),
        (data) => {},
      );
    });
  });

  group('CartsApi.getCart', () {
    test(
      'Retorna un carrito de compras cuando la respuesta es exitosa y válida',
      () async {
        final jsonData = {
          "id": 1,
          "userId": 1,
          "date": "2020-03-02T00:00:00.000Z",
          "products": [
            {"productId": 1, "quantity": 4},
            {"productId": 2, "quantity": 1},
            {"productId": 3, "quantity": 6},
          ],
          "__v": 0,
        };

        // Simula una respuesta HTTP válida
        final mockResponse = http.Response(jsonEncode(jsonData), 200);

        when(
          () => mockHttpHelper.get(any()),
        ).thenAnswer((_) async => Right(mockResponse));

        final result = await fakeStore.getCart('1');

        expect(result.isRight(), true);
        result.fold(
          (failure) => expect(failure, isA<ParsingFailure>()),
          (c) => expect(c, isA<CartModel>()),
        );
      },
    );

    test('Retorna error parsing failure', () async {
      // Simula una respuesta HTTP válida
      final mockResponse = http.Response(jsonEncode('malformed data'), 401);

      when(
        () => mockHttpHelper.get(any()),
      ).thenAnswer((_) async => Right(mockResponse));

      final result = await fakeStore.getCart('1');

      expect(result.isLeft(), true);

      result.fold(
        (failure) => expect(failure, isA<ParsingFailure>()),
        (data) => {},
      );
    });
  });
}
