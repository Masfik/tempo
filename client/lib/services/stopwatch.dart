class TempoStopwatch extends Stopwatch {
  Duration _initialDuration = Duration();

  set initialDuration(Duration duration) {
    if (duration != null) _initialDuration = duration;
  }

  @override
  void reset() {
    super.reset();
    _initialDuration = Duration();
  }

  @override
  Duration get elapsed => _initialDuration + super.elapsed;

  @override
  int get elapsedMilliseconds => elapsed.inMilliseconds;

  /// Returns a properly-formatted duration string
  String get formattedDuration {
    String twoDigits(int number) {
      if (number >= 10) return '$number';
      return '0$number';
    }

    return  '${twoDigits(elapsed.inHours)}:'
            '${twoDigits(elapsed.inMinutes.remainder(60))}:'
            '${twoDigits(elapsed.inSeconds.remainder(60))}';
  }
}