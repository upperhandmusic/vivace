import 'package:vivace_core/src/helpers/_binary.dart';
import 'package:test/test.dart';

import 'matchers.dart';

void main() {
  group('BinaryHelpers extension', () {
    group('isBitEnabled', () {
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

      test('throws an assertion error when n is <= 0', () {
        expect(() => num.isBitEnabled(0), throwsAssertionError);
        expect(() => num.isBitEnabled(-1), throwsAssertionError);
      });
    });

    group('isFirstBitEnabled', () {
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
        expect(int.parse('101010110101', radix: 2).enabledBits,
            [0, 2, 4, 5, 7, 9, 11]);
      });
    });

    group('countBits', () {
      test('is 0 when number is <= 0', () {
        expect((-1).countBits(), 0);
        expect(0.countBits(), 0);
      });

      test("is count of total bits (1's and 0's) when number is > 0", () {
        expect(1.countBits(), 1);
        expect(2.countBits(), 2);
        expect(3.countBits(), 2);
        expect(5.countBits(), 3);
        expect(7.countBits(), 3);
      });
    });

    group('countEnabledBits', () {
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
      test(
          'rotates the binary digits to the left by the specified number of places',
          () {
        var n = int.parse('1001', radix: 2);
        expect(n.rotateLeft(0, bitWidth: 4), equals(n));
        expect(
            n.rotateLeft(1, bitWidth: 4), equals(int.parse('0011', radix: 2)));
        expect(
            n.rotateLeft(2, bitWidth: 4), equals(int.parse('0110', radix: 2)));
        expect(
            n.rotateLeft(3, bitWidth: 4), equals(int.parse('1100', radix: 2)));
        expect(
            n.rotateLeft(4, bitWidth: 4), equals(int.parse('1001', radix: 2)));
      });

      test('defaults to a bit width of 12 for the rotation', () {
        var n = int.parse('100110000010', radix: 2);
        expect(n.rotateLeft(4), equals(int.parse('100000101001', radix: 2)));
      });
    });

    group('rotateRight', () {
      test(
          'rotates the binary digits to the right by the specified number of places',
          () {
        var n = int.parse('1001', radix: 2);
        expect(n.rotateRight(0, bitWidth: 4), equals(n));
        expect(
            n.rotateRight(1, bitWidth: 4), equals(int.parse('1100', radix: 2)));
        expect(
            n.rotateRight(2, bitWidth: 4), equals(int.parse('0110', radix: 2)));
        expect(
            n.rotateRight(3, bitWidth: 4), equals(int.parse('0011', radix: 2)));
        expect(
            n.rotateRight(4, bitWidth: 4), equals(int.parse('1001', radix: 2)));
      });

      test('defaults to a bit width of 12 for the rotation', () {
        var n = int.parse('100110000010', radix: 2);
        expect(n.rotateRight(4), equals(int.parse('001010011000', radix: 2)));
      });
    });
  });

  group('BinaryListExtensions', () {
    group('toBinary', () {
      test("converts a list of 0's and 1's into a binary integer", () {
        expect([0].toBinary(), equals(0));
        expect([1].toBinary(), equals(1));
        expect([1, 0, 0].toBinary(), equals(4));
        expect([1, 0, 1, 0].toBinary(), equals(10));
        expect([1, 1, 1, 1].toBinary(), equals(15));
      });
    });
  });

  group('BinaryStringExtensions', () {
    group('toBinary', () {
      test("converts a string of 0's and 1's into a binary integer", () {
        //
      });
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
