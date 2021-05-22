Stream<DateTime> dateStream() async* {
  while (true) {
    yield DateTime.now();
    await Future.delayed(const Duration(minutes: 1));
  }
}
