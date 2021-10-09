import 'package:FirebaseEcommerce/constants/constants.dart';
import 'package:FirebaseEcommerce/helpers/Exceptions/user_exception.dart';
import 'package:FirebaseEcommerce/provider/riverpod.dart';
import 'package:FirebaseEcommerce/services/Firebase/firebase.dart';
import 'package:FirebaseEcommerce/widgets/Alert.dart';
import 'package:flutter/material.dart';
import 'components/Custom_input.dart';
import 'components/custom_button.dart';

enum AuthMode {
  login,
  signup,
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();

}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  String _userEmail;
  String _userName = "";
  String _userPassword = "";
  final GlobalKey userKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _userController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  var height = 0.0;
  AuthMode _authMode = AuthMode.login;

  _loading(bool check) {
    setState(() {
      _isLoading = check;
    });
  }

  _changeMode() {
    final box = userKey.currentContext.findRenderObject() as RenderBox;

    if (_authMode == AuthMode.login) {
      setState(() {
        height = box.size.height;
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        height = 0.0;
        _authMode = AuthMode.login;
      });
    }
    print(_authMode.toString());
  }

  _submit() async {
    _loading(true);

    final bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      print("user : $_userName , email : $_userEmail , pass: $_userPassword");

      // login
      if (_authMode == AuthMode.login) {
        try {
          await FirebaseServices.login(_userEmail, _userPassword);
        } on UserException catch (error) {
          _loading(false);
          Alert.showAlertDialog(context:context, content:error.message ,isError: true);
        } catch (error) {
          _loading(false);
          Alert.showAlertDialog(context:context, content:"error" , isError: true);
        }
      }
      ///////////////////
      // sign up
      if (_authMode == AuthMode.signup) {
        try {
          await FirebaseServices.signUp(_userEmail, _userPassword);
        } on UserException catch (error) {
          _loading(false);
          Alert.showAlertDialog(context:context, content:error.message,isError: true);
        } catch (error) {
          _loading(false);
          Alert.showAlertDialog(context:context,content: null,isError: true);
        }
      }
      _loading(false);
    } else {
      print(' Invalid!');
      // Alert.showAlert(context);
      _loading(false);
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    emailFocus.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    FirebaseServices.signOut;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Welcome Back,\n Login to your account ',
                    textAlign: TextAlign.center,
                    style: Constants.kBoldHeadingBlack,
                  ),
                  Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                              height: height,
                              constraints: BoxConstraints(minHeight: height),
                              onEnd: () {
                                _userController.clear();
                                emailFocus.previousFocus();
                              },
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 500),
                                opacity:
                                    _authMode == AuthMode.login ? 0.0 : 1.0,
                                child: SingleChildScrollView(
                                  child: AuthenticationInput(
                                    key: ValueKey('username'),
                                    controller: _userController,
                                    textInputAction: TextInputAction.next,
                                    isEnabled: _authMode == AuthMode.login
                                        ? false
                                        : true,
                                    hint: 'username...',
                                    validator: (value) {
                                      if (_authMode == AuthMode.signup) {
                                        if (value.isEmpty ||
                                            value.trim().length < 4) {
                                          return 'Try a valid user';
                                        } else
                                          return null;
                                      } else
                                        return null;
                                    },
                                    onSaved: (value) {
                                      _userName = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            AuthenticationInput(
                              isEnabled: true,
                              focusNode: emailFocus,
                              key: userKey,
                              isEmail: true,
                              hint: 'Email...',
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (!value.trim().contains('@') ||
                                    !value.trim().contains('.com')) {
                                  return ' Try a valid email';
                                } else
                                  return null;
                              },
                              onSaved: (value) {
                                _userEmail = value;
                              },
                            ),
                            AuthenticationInput(
                              isEnabled: true,
                              key: ValueKey('password'),
                              hint: 'password...',
                              isPassword: true,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value.trim().isEmpty ||
                                    value.trim().length < 7) {
                                  return ' Try a valid password';
                                } else
                                  return null;
                              },
                              onSaved: (value) {
                                _userPassword = value;
                              },
                            ),
                            CustomButton(
                              isLoading: _isLoading,
                              onTap: _submit,
                              outLineBtn: false,
                              text: _authMode == AuthMode.login
                                  ? 'Login'
                                  : 'Signup',
                            ),
                          ],
                        ),
                      )),
                  CustomButton(
                    onTap: _changeMode,
                    outLineBtn: true,
                    text: _authMode == AuthMode.login
                        ? 'Create Account'
                        : 'Login',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
