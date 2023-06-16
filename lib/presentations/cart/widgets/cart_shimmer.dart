import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: List.generate(
        1,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: size.height * 0.17,
            child: Row(
              children: [
                Column(
                  children: [
                    Shimmer(
                      color: Colors.black,
                      child: const SizedBox(
                        height: 140,
                        width: 90,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: [
                        Shimmer(
                          color: Colors.black,
                          child: SizedBox(
                            // color: Colors.red,
                            width: size.width * 0.5,
                            height: 30,
                            // color: Colors.red,
                          ),
                        ),
                        Shimmer(
                          color: Colors.black,
                          child: const SizedBox(
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ],
                    ),
                    Shimmer(
                      color: Colors.black,
                      child: SizedBox(
                        height: size.height * 0.06,
                        width: size.width * 0.6,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: size.width * 0.2,
                      children: [
                        Shimmer(
                          color: Colors.black,
                          child: SizedBox(
                            width: size.width * 0.2,
                            height: 25,
                          ),
                        ),
                        Shimmer(
                          color: Colors.black,
                          child: SizedBox(
                            width: size.width * 0.2,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
