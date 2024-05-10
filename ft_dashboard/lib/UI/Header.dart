import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
            width: 1,
            color: (Colors.grey[100])!,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Dashboard",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.more_vert)
        ],
      ),
    );
  }
}
