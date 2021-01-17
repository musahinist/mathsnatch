import 'package:flutter/material.dart';

class NoConnectionPage extends StatelessWidget {
  static const String PATH = "/noConnection";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("No Connection"),
      ),
    );
  }
}
