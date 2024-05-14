import 'package:flutter/material.dart';

class SideBarBtn extends StatelessWidget {
  final String? name;

  const SideBarBtn({
    super.key,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return Container(
      height: 55.0,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Row(
            children: [
              // const Icon(
              //   Icons.star,
              //   size: 15,
              // ),
              const SizedBox(width: 10),
              Text(
                '$name',
                style: TextStyle(
                  color: Colors.white.withAlpha(95),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
