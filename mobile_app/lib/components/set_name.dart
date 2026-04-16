import 'package:flutter/material.dart';
import 'package:mobile_app/widget/custome_textField.dart';

class SetName extends StatefulWidget {
  final TextEditingController nameConotroller;
  const SetName({
    super.key,
    required this.nameConotroller
  });

  @override
  State<SetName> createState() => _SetNameState();
}

class _SetNameState extends State<SetName> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CustomeTextfield(
            controller: widget.nameConotroller, 
            hintText: "Write Your Name", 
            icon: Icons.person_2_rounded, 
            maxLength: 15, 
            keyboardType: TextInputType.name)
        ],
      ),
    );
  }
}