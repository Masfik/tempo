import 'dart:ui';

import 'package:Tempo/models/task.dart';
import 'package:Tempo/ui/style.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  final Task task;

  TaskTile({@required this.task});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  Task task;
  // Stopwatch status (running or stopped/paused)
  bool started = false;
  // Initial starting time
  String subtitle = 'Not started yet';
  // Required to disable the START button when the task is marked as completed
  bool canBeStarted = true;

  @override
  Widget build(BuildContext context) {
    task = widget.task;
    // Obtains the start status directly from the stopwatch
    started = task.stopwatch.isRunning;

    return ListTile(
      title: Text(
        task.name,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none
        ),
      ),
      subtitle: Text(subtitle),
      leading: Checkbox(
        value: task.isDone,
        onChanged: (bool value) {
          // Stops the Stopwatch when the box gets checked
          if (started) _stop();

          setState(() {
            if (value) canBeStarted = false; // When the checkbox is ticked off, mark the START button as disabled
            else canBeStarted = true;

            task.isDone = value ? true : false;
          });
        },
      ),
      trailing: StartButton(
        started: started,
        onStart: () => _start(),
        onStop: () => _stop(),
        enabled: canBeStarted,
      ),
      onTap: () {
        print('Tile tapped');
        // TODO
      },
    );
  }

  // Method triggered when the START button has been tapped
  void _start() {
    setState(() {
      task.stopwatch.start();
      subtitle = '🚀 Started counting...';
    });
  }

  // Method triggered when the STOP/PAUSE button has been tapped
  void _stop() {
    setState(() {
      task.stopwatch.stop();
      subtitle = '⏱️ ' + task.formattedDuration;
    });
  }
}

class StartButton extends StatelessWidget {
  final bool started;
  final Function onStart;
  final Function onStop;
  final enabled;

  StartButton({@required this.started, @required this.onStart, @required this.onStop, @required this.enabled});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        started ? Icons.pause : Icons.play_arrow,
        color: enabled ? kTempoThemeData.accentColor : Colors.grey,
      ),
      onPressed: enabled
          ? () {
              if (!started) onStart();
              else onStop();
            }
          : null
    );
  }
}
