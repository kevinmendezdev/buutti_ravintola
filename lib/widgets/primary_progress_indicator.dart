import 'package:flutter/material.dart';

class PrimaryProgressIndicator extends StatelessWidget {
  const PrimaryProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Theme.of(context).primaryColor,
    );
  }
}
