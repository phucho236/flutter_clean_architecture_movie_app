extension ListExtension<T> on List<T> {
  List<T> addBetweenEvery(T value) {
    List<T> r = [];
    asMap().forEach((i, e) => i < length - 1 ? r.addAll([e, value]) : r.add(e));
    return r;
  }

  bool get isExistAndNotEmpty => isNotEmpty;
}
