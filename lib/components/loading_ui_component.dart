import 'package:flutter/material.dart';

class LoadingUIComponent extends StatelessWidget {
  final String message;
  const LoadingUIComponent({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(
          height: 20,
        ),
        Text(message),
      ],
    );
  }
}
