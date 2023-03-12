mixin Comparability<T> implements Comparable<T> {
  bool operator <(T other);

  bool operator <=(T other);

  bool operator >(T other);

  bool operator >=(T other);

  @override
  int compareTo(T other) {
    if (this > other) return 1;
    if (this < other) return -1;
    return 0;
  }
}
