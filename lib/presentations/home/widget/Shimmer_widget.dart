import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeProductShimmerEffect extends StatelessWidget {
  const HomeProductShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 1 / 1.8,
      shrinkWrap: true,
      children: List.generate(4, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer(
              color: Colors.black,
              child: Container(
                height: 180,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Shimmer(
              color: Colors.black,
              child: Container(
                height: 10,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Shimmer(
              color: Colors.black,
              child: Container(
                height: 10,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Shimmer(
              color: Colors.black,
              child: Container(
                height: 10,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Shimmer(
              color: Colors.black,
              child: const SizedBox(
                height: 30,
                width: 100,
              ),
            ),
          ],
        );
      }),
    );
  }
}
