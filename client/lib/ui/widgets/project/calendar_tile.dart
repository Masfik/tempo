import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarTile extends StatefulWidget {
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
  _CalendarTileState createState() => _CalendarTileState();
}

class _CalendarTileState extends State<CalendarTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.calendar_today,
      ),
      title: Text(widget.title),
      subtitle: Text(
          widget.date != null ? DateFormat('E d MMM, y').format(widget.date) : 'Select date'
      ),
      onTap: widget.onTap,
      enabled: widget.enabled,
    );
  }
}
