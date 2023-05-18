import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 110.0, top: 70),
      child: SizedBox(
        width: 150,
        height: 80,
        child: Image.asset('assets/images/logo1.png'),
      ),
    );
  }
}
