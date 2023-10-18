import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/screens/category/component/categoryGrid.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PKTheme.bgColor,
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(color: PKTheme.blackColor),
        ),
        elevation: 2,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,color: PKTheme.blackColor,),
        ),
      ),
      body: MasonryGridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 2,
        padding:
        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return CategoryGridItemWidget(
              category: [],
              heroTag: "heroTag");
        },
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
      ),
    );
  }
}
