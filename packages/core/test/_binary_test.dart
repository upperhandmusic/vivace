import 'package:vivace_core/src/_binary.dart';
import 'package:test/test.dart';

void main() {
  group('BinaryHelpers', () {
    group('isBitEnabled(n)', () {
      var num = int.parse('1001', radix: 2);

      test('is true when nth bit from right is enabled (1)', () {
        expect((-1).isBitEnabled(1), true);
        expect(1.isBitEnabled(1), true);
        expect(num.isBitEnabled(1), true);
        expect(num.isBitEnabled(4), true);
      });

      test('is false when nth bit from right is disabled (0)', () {
        expect((-2).isBitEnabled(1), false);
        expect(0.isBitEnabled(1), false);
        expect(num.isBitEnabled(2), false);
        expect(num.isBitEnabled(3), false);
      });

      test('throws an exception when n is <= 0', () {
        expect(() => num.isBitEnabled(0), throwsFormatException);
        expect(() => num.isBitEnabled(-1), throwsFormatException);
      });
    });

    group('isFirstBitEnabled()', () {
      test('is true when first bit from right is enabled (1)', () {
        expect((-1).isFirstBitEnabled(), true);
        expect(1.isFirstBitEnabled(), true);
        expect(int.parse('1001', radix: 2).isFirstBitEnabled(), true);
      });

      test('is false when first bit from right is disabled (0)', () {
        expect((-2).isFirstBitEnabled(), false);
        expect(0.isFirstBitEnabled(), false);
        expect(2.isFirstBitEnabled(), false);
        expect(int.parse('1000', radix: 2).isFirstBitEnabled(), false);
      });
    });

    group('enabledBits', () {
      test("returns a list of indices for the enabled bits (1's)", () {
        expect(0.enabledBits, []);
        expect(1.enabledBits, [0]);
        expect(int.parse('11010', radix: 2).enabledBits, [1, 3, 4]);
        expect(int.parse('11111', radix: 2).enabledBits, [0, 1, 2, 3, 4]);
      });
    });

    group('countEnabledBits()', () {
      test('is 0 when number is <= 0', () {
        expect((-1).countEnabledBits(), 0);
        expect(0.countEnabledBits(), 0);
      });

      test("is count of enabled bits (1's) when number is > 0", () {
        expect(1.countEnabledBits(), 1);
        expect(2.countEnabledBits(), 1);
        expect(3.countEnabledBits(), 2);
        expect(5.countEnabledBits(), 2);
        expect(7.countEnabledBits(), 3);
      });
    });

    group('rotateLeft', () {
      //
    });

    group('rotateRight', () {
      //
    });
  });

  group('createBitMask', () {
    test('creates a bit mask where the nth bit is enabled (1)', () {
      expect(createBitMask(-1), 1);
      expect(createBitMask(0), 1);
      expect(createBitMask(1), int.parse('1', radix: 2));
      expect(createBitMask(2), int.parse('10', radix: 2));
      expect(createBitMask(3), int.parse('100', radix: 2));
    });
  });
}
