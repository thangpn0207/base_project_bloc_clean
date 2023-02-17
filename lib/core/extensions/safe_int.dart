extension SafeInt on int? {
  int get safeInt {
    return this ?? 0;
  }
}
