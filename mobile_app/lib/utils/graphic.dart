import 'package:flutter/material.dart';
import 'package:mobile_app/utils/graphic2.dart';

class Graphic extends StatelessWidget {
  final bool wanted;
  const Graphic({
    super.key,
    required this.wanted
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 166, 61, 1),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 130, 54, 1),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Color.fromRGBO(186, 247, 207, 0.7),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
          ),
        ),
        wanted ? Graphic2() : SizedBox(height: 0)
      ],
    );
  }
}