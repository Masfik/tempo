import 'package:Tempo/models/task.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  final String title;

  TaskTile({@required this.title});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  Task task = Task();
  // Stopwatch status (running or stopped/paused)
  bool started = false;
  // Initial starting time
  String subtitle = '00:00:00';
  // Required to disable the START button when the task is marked as completed
  bool canBeStarted = true;

  // Method triggered when the START button has been tapped
  void start() {
    setState(() {
      task.stopwatch.start();
      subtitle = '🚀 Started counting...';
    });
  }

  // Method triggered when the STOP/PAUSE button has been tapped
  void stop() {
    setState(() {
      task.stopwatch.stop();
      subtitle = task.formattedDuration;
    });
  }

  @override
  Widget build(BuildContext context) {
    task.name = widget.title;
    // Obtains the start status directly from the stopwatch
    started = task.stopwatch.isRunning;

    return ListTile(
      title: Text(task.name),
      subtitle: Text(subtitle),
      trailing: StartButton(
        started: started,
        onStart: () => start(),
        onStop: () => stop(),
        enabled: canBeStarted,
      ),
      leading: Checkbox(
        value: task.done,
        onChanged: (bool value) {
          // Stops the Stopwatch when the box gets checked
          if (started) stop();

          setState(() {
            if (value) canBeStarted = false; // When the checkbox is ticked off, mark the START button as disabled
            else canBeStarted = true;

            task.done = value ? true : false;
          });
        },
      ),
      onTap: () {
        print('Tile tapped');
        // TODO
      },
    );
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
        color: enabled ? Colors.blue : Colors.grey,
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
