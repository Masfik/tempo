import 'package:Tempo/services/authentication/authentication.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:Tempo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class RegisterScreen extends StatelessWidget {
  // FocusNode listeners -> changing the focus to next input field
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _surnameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  final FocusNode _confirmPassFocus = FocusNode();

  // Key for identifying the form itself
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    String confirmPassword;
    String firstName;
    String surname;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Column(
                children: <Widget>[
                  Text(
                    'Tempo',
                    style: GoogleFonts.firaSans(
                      fontSize: 72,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: _firstNameFocus,
                    onFieldSubmitted: (value) {
                      _fieldFocusChange(context, _firstNameFocus, _surnameFocus);
                    },
                    onChanged:  (value) => firstName = value,
                    decoration: kInputLoginDecoration.copyWith(
                      hintText: 'First Name',
                      prefixIcon: Icon(Icons.person)
                    ),
                    validator: kValidator,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: _surnameFocus,
                    onFieldSubmitted: (value) {
                      _fieldFocusChange(context, _surnameFocus, _emailFocus);
                    },
                    onChanged:  (value) => surname = value,
                    decoration: kInputLoginDecoration.copyWith(
                      hintText: 'Surname',
                      prefixIcon: Icon(Icons.person)
                    ),
                    validator: kValidator,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: _emailFocus,
                    onFieldSubmitted: (value) {
                      _fieldFocusChange(context, _emailFocus, _passFocus);
                    },
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => email = value,
                    decoration: kInputLoginDecoration.copyWith(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email)
                    ),
                    validator: kValidator
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: _passFocus,
                    onChanged: (value) => password = value,
                    onFieldSubmitted: (value) {
                      _fieldFocusChange(context, _passFocus, _confirmPassFocus);
                    },
                    obscureText: true,
                    decoration: kInputLoginDecoration.copyWith(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.vpn_key)
                    ),
                    validator: kValidator
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    focusNode: _confirmPassFocus,
                    onChanged: (value) => confirmPassword = value,
                    obscureText: true,
                    decoration: kInputLoginDecoration.copyWith(
                      hintText: 'Confirm Password',
                      prefixIcon: Icon(Icons.vpn_key)
                    ),
                    validator: (confirmPassword) {
                      if (confirmPassword != password)
                        return "Confirm password needs to be the same as password";
                      else
                        return null;
                    }
                  ),
                  const SizedBox(height: 10),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Container(
                      child: Center(child: Text('Register')),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    elevation: 0,
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) return;

                      var user = await Provider.of<AuthService>(context, listen: false).signUp(email, password);

                      if (user != null) Navigator.pushReplacementNamed(context, '/home');
                      else print('Error!');
                    }
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Container(
                      child: Center(child: Text('Already signed up?')),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
