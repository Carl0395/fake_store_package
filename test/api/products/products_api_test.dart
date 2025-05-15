import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fake_store_package/fake_store_package.dart';
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

  group('ProductsApi.getProducts', () {
    test(
      'Retorna una lista de productos cuando la respuesta es exitosa y válida',
      () async {
        final jsonData = [
          {
            "id": 1,
            "title": "No. 1 Backpack, Fits 15 Laptops",
            "price": 109.95,
            "description":
                "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
            "category": "men's clothing",
            "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            "rating": {"rate": 3.9, "count": 120},
          },
        ];

        // Simula una respuesta HTTP válida
        final mockResponse = http.Response(jsonEncode(jsonData), 200);

        when(
          () => mockHttpHelper.get(any()),
        ).thenAnswer((_) async => Right(mockResponse));

        final result = await fakeStore.getProducts();

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

      final result = await fakeStore.getProducts();

      expect(result.isLeft(), true);

      result.fold(
        (failure) => expect(failure, isA<ParsingFailure>()),
        (data) => {},
      );
    });
  });

  group('ProductsApi.getProductsByCategory', () {
    test(
      'Retorna una lista de productos cuando la respuesta es exitosa y válida',
      () async {
        final jsonData = [
          {
            "id": 20,
            "title": "T Shirt Casual Cotton Short",
            "price": 12.99,
            "description":
                "95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. Season: Spring,Summer,Autumn,Winter.",
            "category": "women's clothing",
            "image": "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg",
            "rating": {"rate": 3.6, "count": 145},
          },
        ];

        // Simula una respuesta HTTP válida
        final mockResponse = http.Response(jsonEncode(jsonData), 200);

        when(
          () => mockHttpHelper.get(any()),
        ).thenAnswer((_) async => Right(mockResponse));

        final result = await fakeStore.getProductsByCategory(
          'women\'s clothing',
        );

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

      final result = await fakeStore.getProductsByCategory("women's clothing");

      expect(result.isLeft(), true);

      result.fold(
        (failure) => expect(failure, isA<ParsingFailure>()),
        (data) => {},
      );
    });
  });

  group('ProductsApi.getProductsByCategory', () {
    test('Retorna un producto cuando la respuesta es exitosa y válida', () async {
      final jsonData = [
        {
          "id": 1,
          "title": "No. 1 Backpack, Fits 15 Laptops",
          "price": 109.95,
          "description":
              "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
          "category": "men's clothing",
          "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
          "rating": {"rate": 3.9, "count": 120},
        },
      ];

      // Simula una respuesta HTTP válida
      final mockResponse = http.Response(jsonEncode(jsonData), 200);

      when(
        () => mockHttpHelper.get(any()),
      ).thenAnswer((_) async => Right(mockResponse));

      final result = await fakeStore.getProductsByCategory('1');

      expect(result.isRight(), true);
      result.fold(
        (failure) => expect(failure, isA<ParsingFailure>()),
        (c) => expect(c.length, 1),
      );
    });

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

  group('ProductsApi.getCategories', () {
    test(
      'Retorna un producto cuando la respuesta es exitosa y válida',
      () async {
        final jsonData = [
          "electronics",
          "jewelery",
          "men's clothing",
          "women's clothing",
        ];

        // Simula una respuesta HTTP válida
        final mockResponse = http.Response(jsonEncode(jsonData), 200);

        when(
          () => mockHttpHelper.get(any()),
        ).thenAnswer((_) async => Right(mockResponse));

        final result = await fakeStore.getCategories();

        expect(result.isRight(), true);
        result.fold(
          (failure) => expect(failure, isA<ParsingFailure>()),
          (c) => expect(c.length, 4),
        );
      },
    );

    test('Retorna error parsing failure', () async {
      // Simula una respuesta HTTP válida
      final mockResponse = http.Response(jsonEncode('malformed data'), 401);

      when(
        () => mockHttpHelper.get(any()),
      ).thenAnswer((_) async => Right(mockResponse));

      final result = await fakeStore.getCategories();

      expect(result.isLeft(), true);

      result.fold(
        (failure) => expect(failure, isA<ParsingFailure>()),
        (data) => {},
      );
    });
  });
}
