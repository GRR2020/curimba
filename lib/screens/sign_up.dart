import 'package:curimba/locator.dart';
import 'package:curimba/models/user_model.dart';
import 'package:curimba/screens/sign_up_view_model.dart';
import 'package:curimba/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../navigation_service.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameFocus = FocusNode(canRequestFocus: true);
  final _usernameFocus = FocusNode(canRequestFocus: true);
  final _passwordFocus = FocusNode(canRequestFocus: true);

  final _nameCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
        create: (context) => locator<SignUpViewModel>(),
        child: Consumer<SignUpViewModel>(
          builder: (context, model, child) => Scaffold(
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
                          controller: _nameCtrl,
                          focusNode: _nameFocus,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => _fieldFocusChange(
                              context, _nameFocus, _usernameFocus),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome',
                          ),
                          validator: (value) {
                            return Validators.validateNotEmpty(value);
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _usernameCtrl,
                          focusNode: _usernameFocus,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => _fieldFocusChange(
                              context, _usernameFocus, _passwordFocus),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                new RegExp(r"\s\b|\b\s"))
                          ],
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
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _passwordCtrl,
                          focusNode: _passwordFocus,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _signUp(model),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                new RegExp(r"\s\b|\b\s"))
                          ],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Senha',
                          ),
                          validator: (value) {
                            return Validators.validateBySize(value, 6);
                          },
                        ),
                        SizedBox(height: 10),
                        model.viewState == ViewState.Idle
                            ? RaisedButton(
                                onPressed: () {
                                  _signUp(model);
                                },
                                color: Colors.black,
                                textColor: Colors.white,
                                child: Text('Cadastrar'.toUpperCase()))
                            : CircularProgressIndicator(),
                      ])))),
        ));
  }

  _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _signUp(SignUpViewModel viewModel) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      var savedUserId = await viewModel.register(UserModel(
        name: _nameCtrl.text,
        username: _usernameCtrl.text,
        password: _passwordCtrl.text,
      ));

      if (savedUserId > 0) {
        locator<NavigationService>().navigateTo('home');
      } else if (savedUserId == -1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Username já cadastrado'),
          duration: const Duration(seconds: 1),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Falha no cadastro'),
          duration: const Duration(seconds: 1),
        ));
      }
    }
  }
}
