import 'package:flutter/material.dart';
import 'package:ft_dashboard/UI/SideBarBtn.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Material(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 60,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Avaliação das Disciplinas",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Geral",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SideBarBtn(name: "Geral (FT)"),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Cursos",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SideBarBtn(name: "Sistemas de Informação"),
              SideBarBtn(name: "TADS"),
            ],
          ),
        ),
      ),
    );
  }
}
