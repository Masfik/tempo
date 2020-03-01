import 'package:Tempo/ui/pages/show_current_team.dart';
import 'package:flutter/material.dart';

enum Item {
  qr_code,
  show_team
}

class ActionsMenu extends StatelessWidget {
  const ActionsMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Item>>[
        const PopupMenuItem<Item>(
          value: Item.qr_code,
          child: Text('Scan QR Code'),
        ),
        const PopupMenuItem<Item>(
          value: Item.show_team,
          child: Text('Show Team'),
        ),
      ],
      onSelected: (Item item) {
        if (item == Item.qr_code)
          Navigator.pushNamed(context, '/scan');
        else if (item == Item.show_team)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowCurrentTeam()
            )
          );
      },
    );
  }
}