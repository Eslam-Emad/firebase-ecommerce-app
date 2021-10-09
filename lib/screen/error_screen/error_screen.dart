import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          color: Colors.blue,
          child: SvgPicture.asset(
            'assets/error.svg',
            height: size.height,
            width: size.width,
            alignment: Alignment.center,
          ),
    ));
  }
}
