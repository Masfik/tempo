import 'package:flutter/material.dart';

enum LoadingType { loading, successful, error }

class LoadingIndicator extends StatelessWidget {
  final LoadingType type;
  final String message;
  final Function onRetry;

  LoadingIndicator({@required this.type, this.message = '', this.onRetry});

  @override
  Widget build(BuildContext context) {
    List<Widget> children;
    switch (type) {
      case LoadingType.loading:
        children = <Widget>[
          const SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(message),
          )
        ];
        break;
      case LoadingType.successful:
        children = <Widget>[
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFFA3BE8C),
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(message),
          )
        ];
        break;
      case LoadingType.error:
        children = <Widget>[
          Icon(
            Icons.error_outline,
            color: Theme.of(context).errorColor,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Error!' + (message.isNotEmpty ? ' $message' : '')),
          ),
        ];
        if (onRetry != null) children.add(
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: RaisedButton(
              child: Text('Retry'),
              onPressed: onRetry,
            ),
          )
        );
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
