import 'package:flutter/material.dart';

import 'package:fashionstore/core/constants.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    Key? key,
    required this.name,
    required this.icon,
    required this.voidCallback,
  }) : super(key: key);
  final String name;
  final IconData icon;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return GestureDetector(
      onTap: () {
        voidCallback();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: [
            Container(
              height: height / 19,
              width: width / 10,
              decoration: const BoxDecoration(
                color: Color.fromARGB(40, 0, 0, 0),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Icon(
                icon,
                color: Colors.black,
              ),
            ),
            kwidth20,
            Text(
              name,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
            )
          ],
        ),
      ),
    );
  }
}
