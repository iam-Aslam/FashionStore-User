import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashionstore/presentations/home/widget/exclusive_widget.dart';
import 'package:fashionstore/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shimmer_widget.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return StreamBuilder(
      stream: productProvider.getOfferProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return Container(
            color: Colors.white,
            height: 100,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 100,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.95,
                enlargeCenterPage: true,
              ),
              items: List.generate(data.length, (index) {
                return Builder(
                  builder: (BuildContext context) {
                    return ExclusiveProductWidget(
                      id: data[index].get('id'),
                      name: data[index].get('name'),
                      subname: data[index].get('subname'),
                      rate: data[index].get('price'),
                      image: data[index].get('image'),
                      description: data[index].get('description'),
                    );
                  },
                );
              }),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const HomeProductShimmerEffect();
        } else {
          return const HomeProductShimmerEffect();
        }
      },
    );
  }
}
