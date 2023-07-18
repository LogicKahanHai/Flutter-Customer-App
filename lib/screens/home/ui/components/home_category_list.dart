import 'package:flutter/material.dart';

class HomeCategoryList extends StatefulWidget {
  const HomeCategoryList({super.key});

  @override
  State<HomeCategoryList> createState() => _HomeCategoryListState();
}

class _HomeCategoryListState extends State<HomeCategoryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Snacks By Category: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: GetCategories.categories,
            ),
          )
        ],
      ),
    );
  }
}

class GetCategories {
  final List<Map<String, Widget>> _items = [
    {
      'title': const Text(
        'Laddoos',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/laddoos.png'),
      'subtitle': const Text('Laddoos are amazing!')
    },
    {
      'title': const Text(
        'Healthy',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/healthy.png'),
      'subtitle': const Text('Health is Wealth!')
    },
    {
      'title': const Text(
        'Traditional',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/traditional.png'),
      'subtitle': const Text('Traditions are golden!')
    },
    {
      'title': const Text(
        'Namkeen',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/namkeen.png'),
      'subtitle': const Text('Namkeen is the soul of life!')
    },
    {
      'title': const Text(
        'Laddoos',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/laddoos.png'),
      'subtitle': const Text('Laddoos are amazing!')
    },
    {
      'title': const Text(
        'Healthy',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/healthy.png'),
      'subtitle': const Text('Health is Wealth!')
    },
    {
      'title': const Text(
        'Traditional',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/traditional.png'),
      'subtitle': const Text('Traditions are golden!')
    },
    {
      'title': const Text(
        'Namkeen',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/namkeen.png'),
      'subtitle': const Text('Namkeen is the soul of life!')
    },
  ];

  //[ ]: Make this container clickable and redirect to the category page
  //[ ]: Format the list above properly according to the API to accept variable values.

  static List<Widget> get categories {
    return GetCategories()._items.map((item) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            item['image']!,
            item['title']!,
          ],
        ),
      );
    }).toList();
  }
}
