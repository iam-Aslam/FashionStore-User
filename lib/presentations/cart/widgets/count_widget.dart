import 'package:flutter/cupertino.dart';

class CountWidget extends StatefulWidget {
  const CountWidget({super.key});

  @override
  CountWidgetState createState() => CountWidgetState();
}

class CountWidgetState extends State<CountWidget> {
  int count = 1;

  void reduceCount() {
    setState(() {
      if (count > 1) {
        count--;
      }
    });
  }

  void addCount() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.2,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: reduceCount,
            child: const Icon(
              CupertinoIcons.minus,
              size: 15,
            ),
          ),
          Text(
            count.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          GestureDetector(
            onTap: addCount,
            child: const Icon(
              CupertinoIcons.add,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }
}
