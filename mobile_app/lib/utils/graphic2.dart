import 'package:flutter/material.dart';

class Graphic2 extends StatelessWidget {
  const Graphic2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            width: 35,
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromRGBO(9, 153, 52, 1),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight:Radius.circular(20)),
            ),
          ),
          SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(6),
            width: 25,
            height: 30,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 166, 61, 0.6),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight:Radius.circular(20)),
            ),
          ),
          SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(6),
            width: 40,
            height: 60,
            decoration: BoxDecoration(
              color: Color.fromRGBO(2, 138, 65, 1),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight:Radius.circular(20)),
            ),
          )
        ]
      ),
    );
  }
}