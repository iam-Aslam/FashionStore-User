import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddWishlistWidget extends StatelessWidget {
  const AddWishlistWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0, right: 18),
      child: Row(
        children: [
          const Spacer(),
          CircleAvatar(
            radius: 16,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.heart,
                  size: 20,
                )),
          ),
        ],
      ),
    );
  }
}
