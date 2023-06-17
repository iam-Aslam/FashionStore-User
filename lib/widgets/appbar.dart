import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/prev.jpg')),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.bag,
              size: 30,
            ))
      ],
    );
  }
}
