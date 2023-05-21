import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 110.0, top: 70),
      child: SizedBox(
        width: width / 3,
        height: height / 10,
        child: Image.asset('assets/images/logo1.png'),
      ),
    );
  }
}
