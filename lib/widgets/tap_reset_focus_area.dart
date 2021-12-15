import 'package:flutter/material.dart';

// use this widget when needed to unfocus active input by tapping
// on area somewhere outside such input.
class TapResetFocusArea extends StatelessWidget {
  final Widget child;

  const TapResetFocusArea({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
