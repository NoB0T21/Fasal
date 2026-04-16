import 'package:flutter/material.dart';

enum Type { error, success, info }

class CustomSnakebar {
  static void show(
    BuildContext context,
    String message,
    Type type,
  ){
    Icon icon = Icon(
      Icons.check_circle_rounded,
      color: Colors.blue,
    );

    switch (type) {
      case Type.error:
        icon = Icon(
          Icons.error_rounded,
          color: Colors.red,
        );
        break;
      case Type.success:
        icon = Icon(
          Icons.check_circle_rounded,
          color: Colors.green,
        );
        break;
      case Type.info:
        icon = Icon(
          Icons.info_rounded,
          color: Colors.blue,
        );
        break;
    }
    
    final snakebar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      duration:  const Duration(seconds: 2),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: 10,),
            Expanded(
              child: Text(
                message,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      )
    );
    ScaffoldMessenger.of(context).showSnackBar(snakebar);
  }
}