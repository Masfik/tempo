import 'package:Tempo/services/authentication/authentication.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:Tempo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;

  // FocusNode listeners -> changing the focus to next input field
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  // Key for identifying the form itself
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  focusNode: _emailFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _emailFocus, _passFocus);
                  },
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => email = value,
                  decoration: kRoundedInputDecoration.copyWith(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.white70)
                  ),
                  validator: kValidator
                ),
                const SizedBox(height: 10),
                TextFormField(
                  focusNode: _passFocus,
                  onChanged: (value) => password = value,
                  obscureText: true,
                  decoration: kRoundedInputDecoration.copyWith(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.vpn_key, color: Colors.white70)
                  ),
                  validator: kValidator
                ),
                const SizedBox(height: 10),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Container(
                    child: Center(child: Text('Login')),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  elevation: 0,
                  onPressed: () async {
                    var user = await Provider.of<AuthService>(context, listen: false).signIn(email, password);

                    if (user != null) Navigator.pushReplacementNamed(context, '/home');
                    else print('Error!');
                  }
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                  child: Container(
                    child: Center(child: Text('Create account')),
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
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}