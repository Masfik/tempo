import 'package:Tempo/utils/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username;
  String password;

  // FocusNode listeners -> changing the focus to next input field
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  // Key for identifying the form itself
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tempo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10),
                TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: _emailFocus,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(context, _emailFocus, _passFocus);
                    },
                    onChanged: (value) => username = value,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, style: BorderStyle.none),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30)
                        )
                      ),
                      fillColor: Color(0xFF4c566a),
                      filled: true,
                      prefixIcon: Icon(Icons.person, color: Colors.white70),
                      hintText: 'Email'
                    ),
                    validator: kValidator
                ),
                const SizedBox(height: 10),
                TextFormField(
                    focusNode: _passFocus,
                    onChanged: (value) => username = value,
                    obscureText: true,
                    decoration: const InputDecoration(
                      fillColor: Color(0xFF4c566a),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, style: BorderStyle.none),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30)
                        )
                      ),
                      prefixIcon: Icon(Icons.vpn_key, color: Colors.white70),
                      hintText: 'Password',
                    ),
                    validator: kValidator
                ),
                const SizedBox(height: 10),
                RaisedButton(
                  onPressed: () {

                  },
                  child: Container(
                    child: Center(child: Text('Login')),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  elevation: 0,
                ),
                FlatButton(
                  onPressed: () {

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
}

_fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}