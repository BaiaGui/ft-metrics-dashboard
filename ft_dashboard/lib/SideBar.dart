import 'package:flutter/material.dart';
import 'package:ft_dashboard/UI/SideBarBtn.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        Container(
          alignment: Alignment.center,
          height: 60,
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            "Avaliação das Disciplinas",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SideBarBtn(name: "Geral (FT)"),
        Divider(),
        SideBarBtn(name: "Sistemas de Informação"),
        SideBarBtn(name: "TADS"),
      ],
    );
  }
}
