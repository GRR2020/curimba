import 'package:curimba/masks.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/validators.dart';
import 'package:curimba/view_models/card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locator.dart';

class CreateCard extends StatefulWidget{
  @override
  _CreateCardState createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _brandNameFocus = FocusNode(canRequestFocus: true);
  final _lastNumbersFocus = FocusNode(canRequestFocus: true);
  final _expiryDateFocus = FocusNode(canRequestFocus: true);

  final _brandNameController = TextEditingController();
  final _lastNumbersController = TextEditingController();
  final _expiryDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cardViewModel = Provider.of<CardViewModel>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Cadastrar Cartão'),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Form(
                key: _formKey,
                child: ListView(children: <Widget>[
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _brandNameController,
                    focusNode: _brandNameFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _fieldFocusChange(
                        context, _brandNameFocus, _lastNumbersFocus),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Visa',
                        labelText: 'Marca do Cartão'),
                    validator: (value) {
                      return Validators.validateNotEmpty(value);
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _lastNumbersController,
                    focusNode: _lastNumbersFocus,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      Masks.lastNumbersMask,
                      LengthLimitingTextInputFormatter(19)
                    ],
                    onFieldSubmitted: (_) => _fieldFocusChange(
                        context, _lastNumbersFocus, _expiryDateFocus),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '•••• •••• •••• 4444',
                        labelText: 'Últimos números'),
                    validator: (value) {
                      return Validators.validateLastNumbers(value);
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _expiryDateController,
                    focusNode: _expiryDateFocus,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [LengthLimitingTextInputFormatter(2)],
                    onFieldSubmitted: (_) => _submitCard(cardViewModel),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Dia do Vencimento da Fatura',
                        hintText: 'DD'),
                    validator: (value) {
                      return Validators.validateExpiryDay(value);
                    },
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                      onPressed: () {
                        _submitCard(cardViewModel);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Cadastrar cartão'.toUpperCase()))
                ]))));
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _submitCard(CardViewModel cardViewModel) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      final usersId = await locator<SharedPreferencesHelper>().userId;

      if (usersId <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Usuário não autentificado'),
          duration: const Duration(seconds: 1),
        ));
        return;
      }

      var savedCardId = await cardViewModel.register(CardModel(
        lastNumbers: _lastNumbersController.text,
        brandName: _brandNameController.text,
        expiryDate: _expiryDateController.text,
        usersId: usersId,
      ));

      if (savedCardId > 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Cartão salvo com sucesso'),
          duration: const Duration(seconds: 1),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Falha no cadastro do cartão'),
          duration: const Duration(seconds: 1),
        ));
      }
    }
  }
}
