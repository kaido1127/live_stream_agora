import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_agora/app/app.dart';

class BaseCallIconButton extends StatefulWidget {
  final Function function;
  final IconData icon;
  final bool isOn;

  const BaseCallIconButton(
      {super.key, required this.function, required this.icon, required this.isOn});

  @override
  State<BaseCallIconButton> createState() => _BaseCallIconButtonState();
}

class _BaseCallIconButtonState extends State<BaseCallIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => widget.function(),
        icon: CircleAvatar(
          backgroundColor: widget.isOn ? null : Colors.deepPurple,
          radius: deviceSize.width * 0.07,
          child: Icon(
            widget.icon,
            color: widget.isOn ? null : Colors.purple[50],
          ),
        ));
  }
}

// Widget callButtonFromType(CallButtonType buttonType){
//   switch(buttonType){
//     case CallButtonType.switchCamera
//       return BaseCallIconButton(function: function, icon: icon)
//   }
// }
