import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final value;

  CustomText({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          children: [
            TextSpan(text: '$title:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
            TextSpan(text: '  $value',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.red),)
          ]
      ),
    );
  }
}
