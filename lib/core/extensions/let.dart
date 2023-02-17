extension Let<T> on T {
  void let(Function(T it) block) {
    block(this);
  }
}
