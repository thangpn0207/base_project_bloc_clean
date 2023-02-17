extension MyIterable<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;

  T? get lastOrNull => isEmpty ? null : last;

  T? firstWhereOrNull(bool Function(T element) test) {
    final list = where(test);
    return list.isEmpty ? null : list.first;
  }
}

extension MyList<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;

  T? get lastOrNull => isEmpty ? null : last;

  T? firstWhereOrNull(bool Function(T element) test) {
    final list = where(test);
    return list.isEmpty ? null : list.first;
  }
}
