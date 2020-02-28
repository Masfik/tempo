import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AddTask extends StatelessWidget {
  final Project project;
  final Function onSubmit;

  AddTask({@required this.project, @required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    String value;

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
                  decoration: InputDecoration(
                    labelText: 'Name of the task',
                    counterText: '', // Disables characters counter label
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                  ),
                  maxLines: 1,
                  maxLength: 30,
                  onChanged: (newValue) => value = newValue,
                  onSubmitted: (value) => submit(context, value),
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.add_circle),
                color: kTempoThemeData.accentColor,
                onPressed: () => submit(context, value),
              )
            ],
          ),
        ),
      ),
    );
  }

  void submit(BuildContext context, String value) {
    if (value == null || value.isEmpty) return;

    Task task = Task();
    task.name = value;

    project.tasks.add(task);

    // Closes BottomSheet (and keyboard)
    Navigator.pop(context);
    // Calls #updateTask() from previous page
    onSubmit();
  }
}
