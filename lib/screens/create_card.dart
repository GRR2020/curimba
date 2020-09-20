import 'package:curimba/masks.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/card_repository.dart';
import 'package:curimba/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateCard extends StatefulWidget {
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
    // Build a Form widget using the _formKey created above.
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
                    inputFormatters: [
                      Masks.expiryDateMask,
                      LengthLimitingTextInputFormatter(5)
                    ],
                    onFieldSubmitted: (_) => _submitCard(),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Vencimento',
                        hintText: 'DD/MM'),
                    validator: (value) {
                      return Validators.validateExpiryDate(value);
                    },
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                      onPressed: () {
                        _submitCard();
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

  _submitCard() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Salvando cartão')));
      var response = await _registerCard();
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(response.toString())));
    }
  }

  Future<int> _registerCard() async {
    return await CardRepository.insert(CardModel(
        lastNumbers: _lastNumbersController.text,
        brandName: _brandNameController.text,
        expiryDate: _expiryDateController.text));
  }
}
