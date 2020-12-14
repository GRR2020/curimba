import 'package:curimba/enums/view_state.dart';
import 'package:curimba/models/product_model.dart';
import 'package:curimba/utils/monetary_value_mask.dart';
import 'package:curimba/utils/validators.dart';
import 'package:curimba/view_models/register_product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/locator.dart';
import 'base_view.dart';

class RegisterProduct extends StatelessWidget {
  // Keys values
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Text fields focus node
  final _nameFocus = FocusNode(canRequestFocus: true);
  final _descriptionFocus = FocusNode(canRequestFocus: true);
  final _priceFocus = FocusNode(canRequestFocus: true);
  final _monthFocus = FocusNode(canRequestFocus: true);

  // Text fields controllers
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _monthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterProductViewModel>(
        viewModel: locator<RegisterProductViewModel>(),
        builder: (context, model, child) => Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('Registrar um produto'),
            ),
            body: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Form(
                    key: _formKey,
                    child: ListView(children: <Widget>[
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _nameController,
                        focusNode: _nameFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => _fieldFocusChange(
                            context, _nameFocus, _descriptionFocus),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Produto',
                            labelText: 'Nome do produto'),
                        validator: (value) {
                          return Validators.validateNotEmpty(value);
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _descriptionController,
                        focusNode: _descriptionFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => _fieldFocusChange(
                            context, _descriptionFocus, _priceFocus),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Descrição',
                            labelText: 'Descrição do produto'),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _priceController,
                        focusNode: _priceFocus,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          MonetaryValueMask(),
                        ],
                        onFieldSubmitted: (_) => _submitProduct(context, model),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Preço',
                            hintText: 'R\$0,00'),
                        validator: (value) {
                          return Validators.validateNotEmpty(value);
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _monthController,
                        focusNode: _monthFocus,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [LengthLimitingTextInputFormatter(2)],
                        onFieldSubmitted: (_) => _submitProduct(context, model),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mês da compra',
                            hintText: 'MM'),
                        validator: (value) {
                          return Validators.validateMonth(value);
                        },
                      ),
                      SizedBox(height: 10),
                      model.viewState == ViewState.Idle
                          ? RaisedButton(
                              onPressed: () {
                                _submitProduct(context, model);
                              },
                              color: Colors.black,
                              textColor: Colors.white,
                              child: Text('Registrar produto'.toUpperCase()))
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

  _submitProduct(BuildContext context,
      RegisterProductViewModel registerProductViewModel) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      final price = double.parse(_priceController.text.substring(3));
      final month = int.parse(_monthController.text);
      final productToBeRegistered = ProductModel(
        name: _nameController.text,
        description: _descriptionController.text,
        price: price,
        month: month,
      );

      var savedCardId =
          await registerProductViewModel.register(productToBeRegistered);

      if (savedCardId > 0) {
        final snackBar = SnackBar(
          content: Text('Produto salvo com sucesso'),
          duration: Duration(seconds: 1),
        );
        _scaffoldKey.currentState..showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('Falha no cadastro do Produto'),
          duration: Duration(seconds: 1),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }
}
