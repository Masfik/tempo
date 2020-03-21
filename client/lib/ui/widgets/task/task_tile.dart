import 'package:Tempo/models/task.dart';
import 'package:Tempo/ui/pages/task_details.dart';
import 'package:Tempo/ui/widgets/task/start_button.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  final Task task;

  TaskTile({Key key, @required this.task}) : super(key: key);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  Task task;
  // Stopwatch status (running or stopped/paused)
  bool started;
  // Required to disable the START button when the task is marked as completed
  bool canBeStarted = true;

  @override
  Widget build(BuildContext context) {
    task = widget.task;
    // Obtains the start status directly from the stopwatch
    started = task.stopwatch.isRunning;

    return Card(
      child: ListTile(
        title: Text(
          task.name,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none
          ),
        ),
        subtitle: Text(
          started ? '🚀 Started counting...' : '⏱️ ${task.stopwatch.formattedDuration}'
        ),
        leading: Checkbox(
          value: task.isDone,
          onChanged: (bool value) {
            // Stops the Stopwatch when the box gets checked
            if (started) _stop();

            setState(() => task.isDone = value ? true : false);
          },
        ),
        trailing: StartButton(
          started: started,
          onStart: _start,
          onStop: _stop,
          enabled: task.isDone ? false : true,
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskDetailsScreen(task: task))
        )
      ),
    );
  }

  // Method triggered when the START button is tapped
  void _start() => setState(() => task.stopwatch.start());

  // Method triggered when the STOP/PAUSE button is tapped
  void _stop() => setState(() => task.stopwatch.stop());
}
