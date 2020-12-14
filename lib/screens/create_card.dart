import 'package:curimba/enums/view_state.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/utils/masks.dart';
import 'package:curimba/utils/validators.dart';
import 'package:curimba/view_models/create_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/locator.dart';
import 'base_view.dart';

class CreateCard extends StatelessWidget {
  // Keys values
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Text fields focus node
  final _brandNameFocus = FocusNode(canRequestFocus: true);
  final _lastNumbersFocus = FocusNode(canRequestFocus: true);
  final _expiryDateFocus = FocusNode(canRequestFocus: true);

  // Text fields controllers
  final _brandNameController = TextEditingController();
  final _lastNumbersController = TextEditingController();
  final _expiryDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<CreateCardViewModel>(
        viewModel: locator<CreateCardViewModel>(),
        builder: (context, model, child) => Scaffold(
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
                        onFieldSubmitted: (_) => _submitCard(context, model),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Dia do Vencimento da Fatura',
                            hintText: 'DD'),
                        validator: (value) {
                          return Validators.validateDay(value);
                        },
                      ),
                      SizedBox(height: 10),
                      model.viewState == ViewState.Idle
                          ? RaisedButton(
                              onPressed: () {
                                _submitCard(context, model);
                              },
                              color: Colors.black,
                              textColor: Colors.white,
                              child: Text('Cadastrar cartão'.toUpperCase()))
                          : Center(
                              child: CircularProgressIndicator(),
                            )
                    ])))));
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _submitCard(
      BuildContext context, CreateCardViewModel createCardViewModel) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      final lastNumbers =
          Masks.lastNumbersMask.unmaskText(_lastNumbersController.text);
      final cardToBeRegistered = CardModel(
        lastNumbers: lastNumbers,
        brandName: _brandNameController.text,
        expiryDate: _expiryDateController.text,
      );

      var savedCardId = await createCardViewModel.register(cardToBeRegistered);

      if (savedCardId > 0) {
        final snackBar = SnackBar(
          content: Text('Cartão salvo com sucesso'),
          duration: Duration(seconds: 1),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('Falha no cadastro do cartão'),
          duration: Duration(seconds: 1),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }
}
