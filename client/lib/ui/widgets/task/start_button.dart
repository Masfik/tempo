import 'package:flutter/material.dart';

class StartButton extends StatefulWidget {
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
  _StartButtonState createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    // When a new entry is added, the running tasks will move the animation forward (show the pause button instead)
    if (widget.started) controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // If the widget is disabled, reverse the animation for eventual previously-running tasks
    if (!widget.enabled) controller.reverse();
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: controller,
      ),
      color: Theme.of(context).accentColor,
      disabledColor: Theme.of(context).disabledColor,
      onPressed: widget.enabled
          ? () {
              if (!widget.started) {
                widget.onStart();
                controller.forward();
              } else {
                widget.onStop();
                controller.reverse();
              }
            }
          : null
    );
  }
}
