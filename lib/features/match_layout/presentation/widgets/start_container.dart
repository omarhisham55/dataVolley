import 'package:flutter/material.dart';

class StartContainer extends StatelessWidget {
  final String text;
  final Function() onTap;
  const StartContainer({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1, color: Colors.white),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(text, style: Theme.of(context).textTheme.displayMedium),
        ),
      ),
    );
  }
}
