import 'package:flutter/material.dart';
import 'package:sammy/models/color-model.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  FeatureBox(this.color, this.headerText, this.descriptionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(
          left: 15,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: TextStyle(
                  color: ColorPallete.blackColor,
                  fontFamily: 'Cera Pro',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                descriptionText,
                style: TextStyle(
                  color: ColorPallete.blackColor,
                  fontFamily: 'Cera Pro',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
