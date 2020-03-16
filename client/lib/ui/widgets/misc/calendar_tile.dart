import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarTile extends StatelessWidget {
  final String title;
  final DateTime date;
  final Function onTap;
  final bool enabled;

  CalendarTile({
    @required this.title,
    @required this.date,
    @required this.onTap,
    this.enabled = true
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.calendar_today,
      ),
      title: Text(title),
      subtitle: Text(
          date != null ? DateFormat('E d MMM, y').format(date) : 'Select date'
      ),
      onTap: onTap,
      enabled: enabled,
    );
  }
}
