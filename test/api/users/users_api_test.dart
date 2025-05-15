import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fake_store_package/fake_store_package.dart';
import 'package:fake_store_package/models/user_model.dart';
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

  group('UsersApi.getUser', () {
    test(
      'Retorna un usuario cuando si la respuesta es exitosa y válida',
      () async {
        final jsonData = {
          "address": {
            "geolocation": {"lat": "-37.3159", "long": "81.1496"},
            "city": "kilcoole",
            "street": "new road",
            "number": 7682,
            "zipcode": "12926-3874",
          },
          "id": 1,
          "email": "john@gmail.com",
          "username": "johnd",
          "password": "m38rmF",
          "name": {"firstname": "john", "lastname": "doe"},
          "phone": "1-570-236-7033",
          "__v": 0,
        };

        // Simula una respuesta HTTP válida
        final mockResponse = http.Response(jsonEncode(jsonData), 200);

        when(
          () => mockHttpHelper.get(any()),
        ).thenAnswer((_) async => Right(mockResponse));

        final result = await fakeStore.getUser('1');

        expect(result.isRight(), true);

        result.fold((failure) => {}, (user) => expect(user, isA<UserModel>()));
      },
    );

    test('Retorna error parsing failure', () async {
      // Simula una respuesta HTTP válida
      final mockResponse = http.Response(jsonEncode('malformed data'), 401);

      when(
        () => mockHttpHelper.get(any()),
      ).thenAnswer((_) async => Right(mockResponse));

      final result = await fakeStore.getUser('1');

      expect(result.isLeft(), true);

      result.fold(
        (failure) => expect(failure, isA<ParsingFailure>()),
        (data) => {},
      );
    });
  });

  group('UsersApi.createUser', () {
    test(
      'Retorna el id del usuario creado si la respuesta es exitosa y válida',
      () async {
        final jsonData = {"id": 11};

        // Simula una respuesta HTTP válida
        final mockResponse = http.Response(jsonEncode(jsonData), 200);

        when(
          () => mockHttpHelper.post(any(), any()),
        ).thenAnswer((_) async => Right(mockResponse));

        final result = await fakeStore.createUser(
          UserModel(
            id: 1,
            email: 'john@gmail.com',
            username: 'johnd',
            password: 'm38rmF',
          ),
        );

        expect(result.isRight(), true);
        expect(result.getOrElse(() => 0), 11);
      },
    );

    test('Retorna error parsing failure', () async {
      // Simula una respuesta HTTP válida
      final mockResponse = http.Response(jsonEncode('malformed data'), 401);

      when(
        () => mockHttpHelper.post(any(), any()),
      ).thenAnswer((_) async => Right(mockResponse));

      final result = await fakeStore.createUser(UserModel());

      expect(result.isLeft(), true);

      result.fold(
        (failure) => expect(failure, isA<ParsingFailure>()),
        (data) => {},
      );
    });
  });
}
