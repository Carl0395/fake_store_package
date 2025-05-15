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

  group('AuthApi.login', () {
    test('Retorna token cuando la respuesta es exitosa y válida', () async {
      // Simula una respuesta HTTP válida
      final mockResponse = http.Response(jsonEncode({"token": "123abc"}), 200);

      when(
        () => mockHttpHelper.post(any(), any()),
      ).thenAnswer((_) async => Right(mockResponse));

      final result = await fakeStore.login(
        username: 'test',
        password: 'test123',
      );

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), equals('123abc'));
    });

    test('Retorna error credenciales incorrectas', () async {
      // Simula una respuesta HTTP válida
      final mockResponse = http.Response(
        jsonEncode('username or password is incorrect'),
        401,
      );

      when(
        () => mockHttpHelper.post(any(), any()),
      ).thenAnswer((_) async => Left(UnauthorizedFailure(mockResponse.body)));

      final result = await fakeStore.login(
        username: 'test',
        password: 'test123',
      );

      expect(result.isLeft(), true);

      result.fold(
        (failure) => expect(failure, isA<UnauthorizedFailure>()),
        (data) => {},
      );
    });

    test('Retorna error parsing failure', () async {
      // Simula una respuesta HTTP válida
      final mockResponse = http.Response(jsonEncode('malformed data'), 401);

      when(
        () => mockHttpHelper.post(any(), any()),
      ).thenAnswer((_) async => Right(mockResponse));

      final result = await fakeStore.login(
        username: 'test',
        password: 'test123',
      );

      expect(result.isLeft(), true);

      result.fold(
        (failure) => expect(failure, isA<ParsingFailure>()),
        (data) => {},
      );
    });
  });
}
