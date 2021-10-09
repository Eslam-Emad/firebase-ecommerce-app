import 'package:flutter/material.dart';

class AuthenticationInput extends StatefulWidget {
  final Key key;
  final String hint;
  final bool isEmail;
  final bool isEnabled;
  final bool isPassword;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final FormFieldSetter<String> onSaved;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  AuthenticationInput({
    this.key,
    this.hint,
    this.onSaved,
    this.validator,
    this.focusNode,
    this.controller,
    this.textInputAction,
    this.isEmail = false,
    this.isEnabled = false,
    this.isPassword = false,
  })  : assert(key != null),
        assert(hint != null),
        assert(isEmail == true ||
            isEmail == false && isPassword == true
            || isEmail == false && isPassword == false,
            "cant be password & Email"),
        super(key: key);

  @override
  _AuthenticationInputState createState() => _AuthenticationInputState();
}

class _AuthenticationInputState extends State<AuthenticationInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: TextFormField(
        minLines: 1,
        maxLines: 1,
       // maxLength: widget.isPassword ? 10 : 20,
        textInputAction: widget.textInputAction ,
        focusNode: widget.focusNode,
        enabled: widget.isEnabled,
        textCapitalization: (widget.isPassword || widget.isEmail)
            ? TextCapitalization.none
            : TextCapitalization.words,
        autocorrect: !widget.isPassword,
        obscureText: widget.isPassword,
        enableSuggestions: !widget.isPassword,
        keyboardType: widget.isEmail ? TextInputType.emailAddress : null,
        controller: widget.controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(width: 1.5)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(width: 1.5, color: Colors.grey)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(width: 1.5, color: Colors.red)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(width: 1.5, color: Colors.blue)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(width: 1.5, color: Colors.blue)),
          border: InputBorder.none,
          prefixIcon: Icon(
            widget.isEmail
                ? Icons.email_outlined
                : widget.isPassword
                    ? Icons.security_outlined
                    : Icons.account_circle,
            color: widget.isEnabled ? Colors.black : null,
          ),
          hintText: widget.hint,
          enabled: widget.isEnabled,
          filled: true,
          fillColor: Colors.white,
        ),
        validator: widget.validator,
        onSaved: widget.onSaved,
      ),
    );
  }
}
