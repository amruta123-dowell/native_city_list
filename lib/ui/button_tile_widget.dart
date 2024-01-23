import 'package:flutter/material.dart';

class ButtonTileWidget extends StatelessWidget {
  final String text;
  const ButtonTileWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Text(
        text,
        style: Theme.of(context)
            .primaryTextTheme
            .bodyLarge
            ?.copyWith(fontSize: 15, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}
