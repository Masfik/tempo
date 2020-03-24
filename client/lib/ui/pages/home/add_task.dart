import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String value;
    Project project = Provider.of<Project>(context);

    return SingleChildScrollView(
      child: Container(
        // Adjusts padding whenever the the virtual keyboard is opened/closed
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'Name of the task',
                    counterText: '', // Disables characters counter label
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                  maxLines: 1,
                  maxLength: 30,
                  onChanged: (newValue) => value = newValue,
                  onSubmitted: (value) => submit(context, project, value),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.add_circle),
                color: Theme.of(context).accentColor,
                onPressed: () => submit(context, project, value),
              )
            ],
          ),
        ),
      ),
    );
  }

  void submit(BuildContext context, Project project, String value) async {
    if (value == null || value.isEmpty) return;

    Task task = await Provider.of<Repository<Task>>(context, listen: false).add(Task(name: value));
    project.addTask(task);

    // Closes BottomSheet (and keyboard)
    Navigator.pop(context);
  }
}
