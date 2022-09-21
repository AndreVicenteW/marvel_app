import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:test/test.dart';

void main() {
  group('DataResult', () {
    test('gets the data when it is Success result', () {
      const data = 'hello';
      final dataResult = DataResult.success(data);
      expect(dataResult.data, data);
    });

    test('data returns null when it is Failure result', () {
      final dataResult = DataResult.failure(GenericFailure('Test error'));
      expect(dataResult.data, null);
    });

    test('`isSuccess` returns true for Success result', () {
      const data = 'hello';
      final dataResult = DataResult.success(data);
      expect(dataResult.isSuccess, true);
    });

    test('`isSuccess` returns false for Failure result', () {
      final dataResult = DataResult.failure(GenericFailure('Test error'));
      expect(dataResult.isSuccess, false);
    });

    test('isFailure returns true for Failure result', () {
      final dataResult = DataResult.failure(APIFailure('Test error'));
      expect(dataResult.isFailure, true);
    });

    test('isFailure returns false for Success result', () {
      final dataResult = DataResult.success('something');
      expect(dataResult.isFailure, false);
    });

    test('gets error when it is Failure result', () {
      final dataResult = DataResult.failure(APIFailure('Test error'));
      expect(dataResult.error, isA<APIFailure>());
    });

    test('failure returns null when it is Success result', () {
      final dataResult = DataResult.success('something');
      expect(dataResult.error, null);
    });
  });

  group('DataResult', () {
    test('should be equal when two success objects have equal data', () {
      const data = 'hello';
      final dataResult = DataResult.success(data);
      const data2 = 'hello';
      final dataResult2 = DataResult.success(data2);
      expect(dataResult == dataResult2, true);
    });

    test('should not be equal when two success objects have different data',
        () {
      const data = 'hello';
      final dataResult = DataResult.success(data);
      const data2 = 'hello2';
      final dataResult2 = DataResult.success(data2);
      expect(dataResult == dataResult2, false);
    });

    test('should be equal when two failure objects have equal error', () {
      final dataResult = DataResult.failure(APIFailure('Test error'));
      final dataResult2 = DataResult.failure(APIFailure('Test error'));
      expect(dataResult == dataResult2, true);
    });

    test('should not be equal when two failure objects have different error',
        () {
      final dataResult = DataResult.failure(GenericFailure('Test error'));
      final dataResult2 = DataResult.failure(APIFailure('Test error'));
      expect(dataResult == dataResult2, false);
    });
  });

  group('DataResult fold', () {
    test('transforms failure into a false bool', () {
      final result = DataResult.failure<String>(GenericFailure('Test error'))
          .fold<bool>((failure) => false, (data) => true);

      expect(result, false);
    });

    test('transforms data into a true bool', () {
      final result = DataResult.success('yo')
          .fold<bool>((failure) => false, (data) => true);

      expect(result, true);
    });
  });
}
