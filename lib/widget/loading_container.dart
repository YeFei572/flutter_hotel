import 'package:flutter/material.dart';

///加载进度条组件
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  LoadingContainer(
      {Key key,
      @required this.child,
      @required this.isLoading,
      this.cover = false})
      : super(key: key);

  get _loadingView => Center(
        child: CircularProgressIndicator(),
      );

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !isLoading ? child : _loadingView
        : Stack(
            children: <Widget>[child, isLoading ? _loadingView : null],
          );
  }
}
