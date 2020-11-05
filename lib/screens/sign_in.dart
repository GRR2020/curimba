import 'package:curimba/errors_helper.dart';
import 'package:curimba/validators.dart';
import 'package:curimba/view_models/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../locator.dart';
import '../navigation_service.dart';

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
    return ChangeNotifierProvider<SignInViewModel>(
        create: (context) => locator<SignInViewModel>(),
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('Fazer login'),
            ),
            body: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Form(
                    key: _formKey,
                    child: Consumer<SignInViewModel>(
                        builder: (context, model, child) =>
                            ListView(children: <Widget>[
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
                                validator: (value) =>
                                    Validators.validateNotEmpty(value),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _passwordCtrl,
                                focusNode: _passwordFocus,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _signIn(model),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Senha',
                                ),
                                validator: (value) =>
                                    Validators.validateBySize(value, 6),
                              ),
                              SizedBox(height: 5),
                              FlatButton(
                                  onPressed: () => locator<NavigationService>()
                                      .navigateToAndReplace('/sign-up'),
                                  textColor: Colors.black,
                                  child: Text('Não possui cadastro?')),
                              SizedBox(height: 10),
                              model.viewState == ViewState.Idle
                                  ? RaisedButton(
                                      onPressed: () => _signIn(model),
                                      color: Colors.black,
                                      textColor: Colors.white,
                                      child: Text('Entrar'.toUpperCase()))
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          child: CircularProgressIndicator(),
                                          width: 60,
                                          height: 60,
                                        )
                                      ],
                                    ),
                            ]))))));
  }

  _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _signIn(SignInViewModel viewModel) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      final savedUserId = await viewModel.login(
        _usernameCtrl.text,
        _passwordCtrl.text,
      );

      if (savedUserId == AuthErrors.UserNotFound.code) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Usuário não encontrado'),
          duration: const Duration(seconds: 1),
        ));
        return;
      }

      if (savedUserId == AuthErrors.PasswordMismatch.code) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Senha incorreta'),
          duration: const Duration(seconds: 1),
        ));
        return;
      }

      locator<NavigationService>().navigateToAndReplace('/home');
    }
  }
}
