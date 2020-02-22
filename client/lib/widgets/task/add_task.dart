import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddTask extends StatelessWidget {
  const AddTask({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: 'Name of the task',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                  ),
                  onSubmitted: (value) {
                    print(value);
                  },
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.send),
                color: Colors.blue,
                onPressed: () {
                  // TODO
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
