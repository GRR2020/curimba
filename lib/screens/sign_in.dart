import 'package:curimba/enums/sign_in_up_errors.dart';
import 'package:curimba/enums/view_state.dart';
import 'package:curimba/utils/validators.dart';
import 'package:curimba/view_models/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/locator.dart';
import '../utils/navigation_service.dart';
import 'base_view.dart';

class SignIn extends StatelessWidget {
  // Keys values
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Text fields focus node
  final _usernameFocus = FocusNode(canRequestFocus: true);
  final _passwordFocus = FocusNode(canRequestFocus: true);

  // Text fields controllers
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<SignInViewModel>(
        viewModel: locator<SignInViewModel>(),
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
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: _passwordCtrl,
                        focusNode: _passwordFocus,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _signIn(context, model),
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
                              onPressed: () => _signIn(context, model),
                              color: Colors.black,
                              textColor: Colors.white,
                              child: Text('Entrar'.toUpperCase()))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  child: CircularProgressIndicator(),
                                  width: 60,
                                  height: 60,
                                )
                              ],
                            ),
                    ])))));
  }

  _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _signIn(BuildContext context, SignInViewModel viewModel) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      final savedUserId = await viewModel.login(
        _usernameCtrl.text,
        _passwordCtrl.text,
      );

      if (savedUserId == SignInUpErrors.UserNotFound.code) {
        final snackBar = SnackBar(
          content: Text('Usuário não encontrado'),
          duration: Duration(seconds: 1),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }

      if (savedUserId == SignInUpErrors.PasswordMismatch.code) {
        final snackBar = SnackBar(
          content: Text('Senha incorreta'),
          duration: Duration(seconds: 1),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }

      locator<NavigationService>().navigateToAndReplace('/home');
    }
  }
}
