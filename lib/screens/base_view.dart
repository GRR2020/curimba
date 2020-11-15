import 'package:curimba/view_models/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget child)
      builder;
  final T viewModel;
  final Function(T) onModelLoaded;

  BaseView({
    @required this.builder,
    @required this.viewModel,
    this.onModelLoaded,
  });

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T viewModel;

  @override
  void initState() {
    viewModel = widget.viewModel;
    if (widget.onModelLoaded != null) {
      widget.onModelLoaded(viewModel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => viewModel,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
