import 'package:fashionstore/core/constants.dart';
import 'package:flutter/material.dart';
import '../home/widget/product_tile_widget.dart';
import 'widgets/custom_search_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 12, right: 12),
        child: Column(
          children: [
            khieght10,
            const CustomSearchWidget(),
            khieght10,
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0),
                itemBuilder: (context, index) {
                  return ProductTile(
                    index: index,
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
