import 'package:flutter/material.dart';

class CustomProfileTitleText extends StatelessWidget {
  const CustomProfileTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text("Custom Profile",
          style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}
