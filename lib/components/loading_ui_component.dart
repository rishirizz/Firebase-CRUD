import 'package:flutter/material.dart';

class LoadingUIComponent extends StatelessWidget {
  final String message;
  const LoadingUIComponent({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: 20,
          ),
          Text(message),
        ],
      ),
    );
  }
}
