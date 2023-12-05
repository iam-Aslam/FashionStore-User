import 'package:fashionstore/presentations/Categories/Boys/category_boys.dart';
import 'package:fashionstore/presentations/Categories/Girls/category_women.dart';
import 'package:fashionstore/presentations/Categories/Men/category_men.dart';
import 'package:fashionstore/presentations/Categories/Women/category_women.dart';
import 'package:fashionstore/presentations/home/widget/category_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CategoryButton(
          name: 'Men',
          active: true,
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const CategoryMen()));
          },
        ),
        CategoryButton(
          name: 'Women',
          active: true,
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const CategoryWomen()));
          },
        ),
        CategoryButton(
          name: 'Boys',
          active: true,
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const CategoryBoys()));
          },
        ),
        CategoryButton(
          name: 'Girls',
          active: true,
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const CategorGirls()));
          },
        ),
      ],
    );
  }
}
