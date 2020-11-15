import 'package:curimba/enums/sign_in_up_errors.dart';
import 'package:curimba/enums/view_state.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/models/user_model.dart';
import 'package:curimba/utils/validators.dart';
import 'package:curimba/view_models/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/navigation_service.dart';
import 'base_view.dart';

class SignUp extends StatelessWidget {
  // Keys values
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Text fields focus node
  final _nameFocus = FocusNode(canRequestFocus: true);
  final _usernameFocus = FocusNode(canRequestFocus: true);
  final _passwordFocus = FocusNode(canRequestFocus: true);

  // Text fields controllers
  final _nameCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
        viewModel: locator<SignUpViewModel>(),
        builder: (context, model, child) => Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('Fazer cadastro'),
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
                        validator: (value) =>
                            Validators.validateNotEmpty(value),
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
                        onFieldSubmitted: (_) => _signUp(context, model),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              new RegExp(r"\s\b|\b\s"))
                        ],
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
                              .navigateToAndReplace('/sign-in'),
                          textColor: Colors.black,
                          child: Text('Já possui cadastro?')),
                      SizedBox(height: 10),
                      model.viewState == ViewState.Idle
                          ? RaisedButton(
                              onPressed: () => _signUp(context, model),
                              color: Colors.black,
                              textColor: Colors.white,
                              child: Text('Cadastrar'.toUpperCase()))
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

  _signUp(BuildContext context, SignUpViewModel viewModel) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      var savedUserId = await viewModel.register(UserModel(
        name: _nameCtrl.text,
        username: _usernameCtrl.text,
        password: _passwordCtrl.text,
      ));

      if (savedUserId == SignInUpErrors.UserFound.code) {
        final snackBar = SnackBar(
          content: Text('Username já cadastrado'),
          duration: Duration(seconds: 1),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        return;
      }

      if (savedUserId <= 0) {
        final snackBar = SnackBar(
          content: Text('Falha no cadastro'),
          duration: Duration(seconds: 1),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        return;
      }

      locator<NavigationService>().navigateToAndReplace('/home');
    }
  }
}
