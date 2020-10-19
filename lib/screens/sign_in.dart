import 'package:curimba/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _usernameFocus = FocusNode(canRequestFocus: true);
  final _passwordFocus = FocusNode(canRequestFocus: true);

  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Fazer login'),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Form(
                key: _formKey,
                child: ListView(children: <Widget>[
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _usernameCtrl,
                    focusNode: _usernameFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _fieldFocusChange(
                        context, _usernameFocus, _passwordFocus),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      return Validators.validateNotEmpty(value);
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordCtrl,
                    focusNode: _passwordFocus,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _signIn(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                    validator: (value) {
                      return Validators.validateBySize(value, 6);
                    },
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                      onPressed: () {
                        _signIn();
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Entrar'.toUpperCase()))
                ]))));
  }

  _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _signIn() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {

    }
  }
}
