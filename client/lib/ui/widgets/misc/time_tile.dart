import 'package:flutter/material.dart';

class TimeTile extends StatelessWidget {
  final String title;
  final TimeOfDay time;
  final Function onTap;
  final bool enabled;

  TimeTile({
    @required this.title,
    @required this.time,
    @required this.onTap,
    this.enabled = true
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.schedule
      ),
      title: Text(title),
      subtitle: Text(
        time != null ? time.format(context) : 'Select Time'
      ),
      onTap: onTap,
      enabled: enabled,
    );
  }
}
