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
      child: Ink(
        color: Colors.blueAccent[700],
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
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Geral",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SideBarBtn(name: "Geral (FT)"),
            const Divider(),
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Container(
            //     alignment: Alignment.centerLeft,
            //     child: const Text(
            //       "Cursos",
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            // const SideBarBtn(name: "Sistemas de Informação"),
            // const SideBarBtn(name: "TADS"),
            // const SideBarBtn(name: "Eng. Ambiental"),
            // const SideBarBtn(name: "Eng. de Telecomunicações"),
            // const SideBarBtn(name: "Eng. de Transportes"),
            // const SideBarBtn(name: "Saneamento Ambiental"),
          ],
        ),
      ),
    );
  }
}
