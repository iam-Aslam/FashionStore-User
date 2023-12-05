import 'package:fashionstore/provider/product_provider.dart';
import 'package:fashionstore/widgets/main_heading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants.dart';
import '../../home/widget/shimmer_widget.dart';
import '../../home/widget/product_tile_widget.dart';

class CategoryBoys extends StatelessWidget {
  const CategoryBoys({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                    padding: const EdgeInsets.only(top: 10.0, left: 10),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.bag,
                          size: 30,
                        )),
                  )
                ],
              ),
              const MainHeading(
                text: 'Boys',
              ),
              khieght10,
              StreamBuilder(
                stream: productProvider.getCategoryProducts('Boy'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (itemWidth / itemHeight),
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 14.0),
                        itemBuilder: (context, index) {
                          return ProductTile(
                            name: data[index].get('name'),
                            subname: data[index].get('subname'),
                            rate: data[index].get('price'),
                            image: data[index].get('image'),
                            id: data[index].get('id'),
                            description: data[index].get('description'),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const HomeProductShimmerEffect();
                  } else {
                    return const HomeProductShimmerEffect();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
