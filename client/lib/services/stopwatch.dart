class TempoStopwatch extends Stopwatch {
  Duration _initialDuration = Duration();

  set initialDuration(Duration duration) => _initialDuration = duration;

  @override
  void reset() {
    super.reset();
    _initialDuration = Duration();
  }

  @override
  Duration get elapsed => _initialDuration + super.elapsed;

  /// Returns a properly-formatted duration string
  String get formattedDuration {
    if (elapsed == null) throw "The stopwatch hasn't been initialised! Make sure to start it at least once.";

    String twoDigits(int number) {
      if (number >= 10) return '$number';
      return '0$number';
    }

    return  '${twoDigits(elapsed.inHours)}:'
            '${twoDigits(elapsed.inMinutes.remainder(60))}:'
            '${twoDigits(elapsed.inSeconds.remainder(60))}';
  }
}