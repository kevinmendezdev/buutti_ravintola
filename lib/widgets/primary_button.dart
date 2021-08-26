import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * .7,
      child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          )),
    );
  }
}
