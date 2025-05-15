import 'package:fake_store_package/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    final sampleJson = {
      "id": 1,
      "username": "testuser",
      "email": "test@example.com",
      "password": "123456",
    };

    test('fromJson crea una instancia válida', () {
      final user = UserModel.fromJson(sampleJson);

      expect(user.id, 1);
      expect(user.username, "testuser");
      expect(user.email, "test@example.com");
      expect(user.password, "123456");
    });

    test('toJson devuelve un mapa válido', () {
      final user = UserModel.fromJson(sampleJson);
      final json = user.toJson();

      expect(json['id'], 1);
      expect(json['username'], "testuser");
      expect(json['email'], "test@example.com");
      expect(json['password'], "123456");
    });

    test('copyWith sobrescribe correctamente los campos', () {
      final user = UserModel.fromJson(sampleJson);
      final updated = user.copyWith(username: "newuser");

      expect(updated.id, user.id);
      expect(updated.username, "newuser");
      expect(updated.email, user.email);
    });

    test('copyWith sin argumentos retorna la misma instancia', () {
      final user = UserModel.fromJson(sampleJson);
      final copy = user.copyWith();

      expect(copy.id, user.id);
      expect(copy.username, user.username);
      expect(copy.email, user.email);
      expect(copy.password, user.password);
    });

    test('toString devuelve un JSON legible con indentación', () {
      final user = UserModel.fromJson(sampleJson);
      final result = user.toString();

      expect(result, contains('"username": "testuser"'));
      expect(result, contains('\n  ')); // indentación
    });

    test('fromJson permite valores nulos sin lanzar error', () {
      final jsonWithNulls = {
        "id": null,
        "username": null,
        "email": null,
        "password": null,
      };

      final user = UserModel.fromJson(jsonWithNulls);

      expect(user.id, isNull);
      expect(user.username, isNull);
      expect(user.email, isNull);
      expect(user.password, isNull);
    });
  });
}
