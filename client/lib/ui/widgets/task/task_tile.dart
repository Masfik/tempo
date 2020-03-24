import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/repositories/repository.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:Tempo/ui/pages/task_details.dart';
import 'package:Tempo/ui/widgets/task/start_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

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
  // TaskRepository
  Repository<Task> taskRepo;

  @override
  Widget build(BuildContext context) {
    task = widget.task;
    // Obtains the start status directly from the stopwatch
    started = task.stopwatch.isRunning;
    // TaskRepository
    taskRepo = Provider.of<Repository<Task>>(context, listen: false);

    return Card(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(kCurvedEdgedRadius)
          ),
          child: ListTile(
            title: Text(
              task.name,
              style: TextStyle(
                decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none
              ),
            ),
            subtitle: Wrap(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(
                    started ? '🚀 Started counting...' : '⏱️ ${task.stopwatch.formattedDuration}'
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).chipTheme.backgroundColor,
                    borderRadius: const BorderRadius.all(kCurvedEdgedRadius)
                  ),
                ),
              ],
            ),
            leading: Checkbox(
              value: task.isDone,
              onChanged: (bool value) async {
                // Stops the Stopwatch when the box gets checked
                if (started) _stop();

                setState(() => task.isDone = value ? true : false);
                await taskRepo.update(task);
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
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Theme.of(context).errorColor,
            icon: Icons.delete_forever,
            onTap: () async {
              Provider.of<Project>(context, listen: false).deleteTask(task);
              await taskRepo.delete(task);
            },
          )
        ],
      ),
    );
  }

  // Method triggered when the START button is tapped
  void _start() => setState(() => task.stopwatch.start());

  // Method triggered when the STOP/PAUSE button is tapped
  void _stop() async {
    setState(() => task.stopwatch.stop());
    await taskRepo.update(task);
  }
}
