import 'package:flutter/material.dart';

class PlatformDetailsScreen extends StatelessWidget {
  final String details;
  const PlatformDetailsScreen({required this.details, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CITY DETAILS"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "State of selected city -> $details",
            style: Theme.of(context)
                .primaryTextTheme
                .bodyLarge
                ?.copyWith(fontSize: 35, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
