import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    this.currentValue = 0,
  }) : super(key: key);
  final int currentValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
            3,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: AnimatedContainer(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 500),
                    width: index == currentValue ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: index == currentValue
                            ? Colors.black
                            : Colors.black54,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )),
      ),
    );
  }
}
