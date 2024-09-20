import 'package:flutter/material.dart';

class FittedWidget extends StatelessWidget {
  final Widget child;
  final MainAxisAlignment mainAxisAlignment;
  const FittedWidget({super.key,required this.child,this.mainAxisAlignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Flexible(
          child: FittedBox(
            child: child,
          ),
        )
      ],
    );
  }
}
