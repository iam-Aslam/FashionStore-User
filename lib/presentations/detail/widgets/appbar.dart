import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailAppbar extends StatelessWidget {
  const DetailAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/prev.jpg')),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: CircleAvatar(
            radius: 16,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.bag,
                  size: 20,
                )),
          ),
        )
      ],
    );
  }
}
