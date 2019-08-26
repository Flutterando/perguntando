import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {

  final String text;
  final IconData icon;
  final bool selected;
  final Function onTap;

  const CustomListTile({Key key, this.text = "", this.icon = Icons.lightbulb_outline, this.selected = false, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.selected ? Colors.white : Colors.blue[800],
      child: ListTile(
        leading: Icon(
          this.icon,
          color: this.selected ? Colors.blue[800] : Colors.white,
          size: 35,
        ),
        title: Text(
          this.text.toUpperCase(),
          style: TextStyle(color: this.selected ? Colors.blue[800] : Colors.white),
        ),
        onTap: this.selected ? null : onTap,
      ),
    );
  }
}