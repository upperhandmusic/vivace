import 'dart:math';

/// Extends [int] with additional methods for conveniently working with
/// its binary representation.
extension BinaryHelpers on int {
  /// Check if the [n]th bit of an [int] is set (1).
  bool isBitEnabled(int n) {
    assert(n > 0, 'n must be greater than 0');
    return (this & createBitMask(n)) > 0;
  }

  bool isFirstBitEnabled() => isBitEnabled(1);

  /// Get a [List] of ordinal numbers (1, 2, 3, etc.) indicating which bits are
  /// set from right to left in the binary representation of this [int].
  List<int> get enabledBits {
    var bits = <int>[];
    var index = 0;
    var next = this;

    while (next > 0) {
      if (next.isFirstBitEnabled()) bits.add(index);
      next = next >>> 1;
      index += 1;
    }

    return bits;
  }

  /// Rotate the binary represetnation of [int] to the left by [steps] number of digits.
  int rotateLeft(steps, {bitWidth = 12}) {
    var bitMask = pow(2, bitWidth) - 1 as int;
    return ((this << steps) & bitMask) | (this >>> (bitWidth - steps));
  }

  /// Rotate the binary representation of [int] to the right by [steps] number of digits.
  int rotateRight(steps, {bitWidth = 12}) {
    var bitMask = pow(2, bitWidth) - 1 as int;
    return (this >>> steps) | ((this << (bitWidth - steps)) & bitMask);
  }

  /// Counts the number of enabled bits (1's) in a [int]'s binary
  /// representation.
  int countEnabledBits() {
    var count = 0;
    var next = this;

    while (next > 0) {
      count += next & 1;
      next = next >>> 1;
    }

    return count;
  }
}

/// Creates a bit mask with the [i]th bit from the right set to 1 (on).
int createBitMask(int i) => i <= 1 ? 1 : 1 << (i - 1);
