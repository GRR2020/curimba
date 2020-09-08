import 'package:curimba/masks.dart';
import 'package:curimba/models/card_model.dart';
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
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    controller: _brandNameController,
                    focusNode: _brandNameFocus,
                    onFieldSubmitted: (_) => _fieldFocusChange(
                        context, _brandNameFocus, _lastNumbersFocus),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Visa',
                      labelText: 'Marca do Cartão',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some a';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: TextFormField(
                            controller: _lastNumbersController,
                            inputFormatters: [
                              Masks().lastNumbersMask,
                              LengthLimitingTextInputFormatter(19)
                            ],
                            keyboardType: TextInputType.number,
                            focusNode: _lastNumbersFocus,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _fieldFocusChange(
                                context, _lastNumbersFocus, _expiryDateFocus),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '•••• •••• •••• 4444',
                              labelText: 'Últimos números',
                            ),
                            validator: (value) {
                              return _validateLastNumbers(value);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: TextFormField(
                            controller: _expiryDateController,
                            inputFormatters: [
                              Masks().expiryDateMask,
                              LengthLimitingTextInputFormatter(5)
                            ],
                            focusNode: _expiryDateFocus,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _submitCard(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Vencimento',
                              hintText: 'DD/MM',
                            ),
                            validator: (value) {
                              return _validateExpiryDate(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    onPressed: () {
                      _submitCard();
                    },
                    child: Text('Cadastrar cartão'),
                  )
                ]))));
  }

  _validateExpiryDate(value) {
    print(value);
    print(Masks().expiryDateMask.unmaskText(value));
    var unmaskedValue = Masks().expiryDateMask.unmaskText(value);
    if (unmaskedValue.isEmpty || unmaskedValue.length < 4) {
      return 'Complete o campo';
    } else {
      var day = int.parse(unmaskedValue.substring(0, 2));
      var month = int.parse(unmaskedValue.substring(2, 4));

      if (day > 31 || day < 1) {
        return 'Dia inválido';
      }

      if (month > 12 || month < 1) {
        return 'Mês inválido';
      }
    }
    return null;
  }

  _validateLastNumbers(value) {
    var unmaskedValue = Masks().lastNumbersMask.unmaskText(value);
    if (unmaskedValue.isEmpty || unmaskedValue.length < 4) {
      return 'Complete o campo';
    }
    return null;
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _submitCard() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Processing Data')));
    }
  }
}
