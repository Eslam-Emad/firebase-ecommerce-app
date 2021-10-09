import 'package:FirebaseEcommerce/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool outLineBtn;
  final bool isLoading;
  CustomButton({
    @required this.onTap,
    @required this.text,
    this.outLineBtn = false,
    this.isLoading = false,
  })  : assert(text != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        decoration: BoxDecoration(
            color: outLineBtn ? Colors.transparent : Colors.black,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.black, width: 2.0)),
        child: !isLoading
            ? Text(
                text,
                style: outLineBtn
                    ? Constants.kRegularHeadingBlack
                    : Constants.kRegularHeadingWhite,
              )
            : CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                backgroundColor: Colors.blue,
                strokeWidth: 2.0,
              ),
      ),
    );
  }
}
