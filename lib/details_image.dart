import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final details;
  const DetailsPage({this.details}) : super(key: details);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [Image(image: NetworkImage(''))],
        ),
      ),
    );
  }
}
