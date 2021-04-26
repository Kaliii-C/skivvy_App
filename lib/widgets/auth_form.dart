import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skivvy_app/providers/auth.dart';
import 'package:skivvy_app/screens/dashboard_screen.dart';
import 'package:skivvy_app/store/size_config.dart';
import 'package:skivvy_app/theme.dart';
import 'package:skivvy_app/widgets/default_button.dart';
import 'package:skivvy_app/widgets/error_body.dart';
import 'package:skivvy_app/store/error_confiq.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({
    Key key,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  AuthMode _authMode = AuthMode.Login;
  bool rememberMe = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'firstName': '',
    'lastName': '',
  };

  var _isLoading = false;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
        Navigator.pushNamed(context, DashboardScreen.routeName);
      } else {
        await Provider.of<Auth>(context, listen: false).signup(
            _authData['firstName'],
            _authData['firstName'],
            _authData['email'],
            _authData['password']);
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('User already exist')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('User does not exist')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('Invalid password')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          if (_authMode == AuthMode.Signup) buildFirstNameInputField(),
          SizedBox(height: getPropScreenHeight(25)),
          if (_authMode == AuthMode.Signup) buildLastNameInputField(),
          SizedBox(height: getPropScreenHeight(25)),
          buildEmailInputField(),
          SizedBox(height: getPropScreenHeight(25)),
          buildPasswordInputField(),
          SizedBox(height: getPropScreenHeight(25)),
          Row(
            children: [
              Checkbox(
                value: rememberMe,
                activeColor: skivvyBaseColor,
                onChanged: (value) {
                  setState(() {
                    rememberMe = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot Password",
                  style:
                      GoogleFonts.poppins(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          if (_isLoading)
            CircularProgressIndicator()
          else
            ErrorBody(errors: errors),
          SizedBox(height: getPropScreenHeight(20)),
          DefaultBtn(
              text: _authMode == AuthMode.Login ? "Login" : "Sign Up",
              click: _submit),
          FlatButton(
            child: Text(
                '${_authMode == AuthMode.Login ? 'Sign Up' : 'Login'} INSTEAD'),
            onPressed: _switchAuthMode,
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailInputField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        _authData['email'] = value;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: emailNullErr);
        } else if (emailValidatorRgx.hasMatch(value)) {
          removeError(error: invalidEmailErr);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: emailNullErr);
          return "";
        } else if (!emailValidatorRgx.hasMatch(value)) {
          addError(error: invalidEmailErr);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPasswordInputField() {
    return TextFormField(
      obscureText: true,
      onSaved: (value) {
        _authData['password'] = value;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: passwordNullErr);
        } else if (value.length >= 8) {
          removeError(error: passwordShortErr);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: passwordNullErr);
          return "";
        } else if (value.length < 8) {
          addError(error: passwordShortErr);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildFirstNameInputField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (value) {
        _authData['firstName'] = value;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: firstNameNullErr);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: firstNameNullErr);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildLastNameInputField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (value) {
        _authData['lastName'] = value;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: lastNameNullErr);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: lastNameNullErr);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
