import 'package:test/test.dart';
import 'package:vivace_core/src/helpers/_equivalence.dart';

void hasComparability<T extends Comparability<Object>>(T lower, T higher) {
  group('A < B', () {
    test('returns true if left value is less than right value', () {
      expect(lower < higher, isTrue);
    });

    test('returns false if left value is greater than right value', () {
      expect(higher < lower, isFalse);
    });

    test('returns false if compared values are equal', () {
      expect(lower < lower, isFalse);
    });
  });

  group('A <= B', () {
    test('returns true if left value is less than right value', () {
      expect(lower <= higher, isTrue);
    });

    test('returns false if left value is greater than right value', () {
      expect(higher <= lower, isFalse);
    });

    test('returns true if compared values are equal', () {
      expect(lower <= lower, isTrue);
    });
  });

  group('A > B', () {
    test('returns true if left value is greater than right value', () {
      expect(higher > lower, isTrue);
    });

    test('returns false if left value is less than right value', () {
      expect(lower > higher, isFalse);
    });

    test('returns false if compared values are equal', () {
      expect(lower > lower, isFalse);
    });
  });

  group('A >= B', () {
    test('returns true if left value is greater than right value', () {
      expect(higher >= lower, isTrue);
    });

    test('returns false if left value is less than right value', () {
      expect(lower >= higher, isFalse);
    });

    test('returns true if compared values are equal', () {
      expect(lower >= lower, isTrue);
    });
  });

  group('compareTo', () {
    test('returns -1 if left value is less than right value', () {
      expect(lower.compareTo(higher), equals(-1));
    });

    test('returns 0 if compared values are equal', () {
      expect(lower.compareTo(lower), equals(0));
    });

    test('returns 1 if left value is greater than right value', () {
      expect(higher.compareTo(lower), equals(1));
    });
  });
}
