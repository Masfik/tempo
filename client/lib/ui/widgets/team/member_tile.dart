import 'package:Tempo/models/team.dart' show MemberRank;
import 'package:flutter/material.dart';

class MemberTile extends StatefulWidget {
  final String fullName;
  final String identifier;
  final MemberRank memberType;
  final Function onTap;
  bool selectable = false;

  MemberTile({
    Key key,
    @required this.fullName,
    @required this.identifier,
    this.memberType,
    this.onTap,
    this.selectable
  }) : super(key: key);

  @override
  _MemberTileState createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.fullName),
      subtitle: Text('@${widget.identifier}'),
      leading: Image.asset('images/user.png', width: 40),
      trailing: Text(
        widget.memberType == MemberRank.creator ? 'Creator' :
        widget.memberType == MemberRank.admin ? 'Admin' :
        ''
      ),
      onTap: widget.onTap,
    );
  }
}
