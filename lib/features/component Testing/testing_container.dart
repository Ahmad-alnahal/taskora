import 'package:flutter/material.dart';
import '../../core/config/widgets/Cards/AppCustomCard.dart';

class TestingContainer extends StatelessWidget{


  const TestingContainer({
    super.key,
    required this.title,
    required this.widget,
    this.width,
    this.height
  });
  final String title;
  final Widget widget;
  final double? width ;
  final double? height;

  @override
  Widget build(BuildContext context) {

    return AppCustomCard(
      margin: EdgeInsets.zero,
      width: double.infinity,
      height: 0,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            SizedBox(
                width:width,
                height: height,
                child: widget
            ),
          ],
        ),
      ),
    );
  }
}