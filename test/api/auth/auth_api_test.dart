import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fake_store_package/fake_store_package.dart';
import 'package:fake_store_package/util/http_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

// Mock personalizado
class MockHttpHelper extends Mock implements HttpHelper {}

void main() {
  late MockHttpHelper mockHttpHelper;
  late FakeStorePackage fakeStore;

  setUp(() {
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
      print(result);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), equals('123abc'));
    });
  });
}
