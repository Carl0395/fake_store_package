import 'package:fake_store_package/util/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Failure subclasses', () {
    test('BadRequestFailure contiene el mensaje y tipo correctos', () {
      final failure = BadRequestFailure('Invalid request');
      expect(failure.message, 'Invalid request');
      expect(failure.toString(), 'BadRequestFailure: Invalid request');
      expect(failure, isA<Failure>());
    });

    test('UnauthorizedFailure contiene el mensaje y tipo correctos', () {
      final failure = UnauthorizedFailure('Unauthorized');
      expect(failure.message, 'Unauthorized');
      expect(failure.toString(), 'UnauthorizedFailure: Unauthorized');
      expect(failure, isA<Failure>());
    });

    test('ServerFailure contiene el mensaje y tipo correctos', () {
      final failure = ServerFailure('Server error');
      expect(failure.message, 'Server error');
      expect(failure.toString(), 'ServerFailure: Server error');
      expect(failure, isA<Failure>());
    });

    test('ParsingFailure contiene el mensaje y tipo correctos', () {
      final failure = ParsingFailure('Parsing failed');
      expect(failure.message, 'Parsing failed');
      expect(failure.toString(), 'ParsingFailure: Parsing failed');
      expect(failure, isA<Failure>());
    });

    test('ConnectionFailure contiene el mensaje y tipo correctos', () {
      final failure = ConnectionFailure('No internet');
      expect(failure.message, 'No internet');
      expect(failure.toString(), 'ConnectionFailure: No internet');
      expect(failure, isA<Failure>());
    });

    test('UnknownFailure contiene el mensaje y tipo correctos', () {
      final failure = UnknownFailure('Something went wrong');
      expect(failure.message, 'Something went wrong');
      expect(failure.toString(), 'UnknownFailure: Something went wrong');
      expect(failure, isA<Failure>());
    });
  });
}
