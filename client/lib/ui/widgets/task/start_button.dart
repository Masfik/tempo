import 'package:Tempo/ui/style.dart';
import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final bool started;
  final Function onStart;
  final Function onStop;
  final enabled;

  StartButton({
    @required this.started,
    @required this.onStart,
    @required this.onStop,
    @required this.enabled
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: kTempoThemeData.accentColor,
      disabledColor: kTempoThemeData.disabledColor,
      icon: Icon(started ? Icons.pause : Icons.play_arrow),
      onPressed: enabled
          ? () {
              if (!started) onStart();
              else onStop();
            }
          : null
    );
  }
}
