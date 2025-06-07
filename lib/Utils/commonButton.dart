
import 'package:flutter/material.dart';
import 'commonStyles.dart';

class CustomButtonIcon extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onPressed;
  String title;


  CustomButtonIcon({super.key,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.title,


  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          gradient: LinearGradient(
              colors: [
                Color(0xFFF2530A),
                Color(0xFFF2530A),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
      child: MaterialButton(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          minWidth: width,
          onPressed: onPressed,
          child: Text(title,style: TextStyles.buttonStyle)
      ),
    );
  }
}