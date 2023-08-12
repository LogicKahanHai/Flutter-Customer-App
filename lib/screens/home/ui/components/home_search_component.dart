import 'package:flutter/material.dart';

class HomeSearchComponent extends StatefulWidget {
  const HomeSearchComponent({super.key});

  @override
  State<HomeSearchComponent> createState() => _HomeSearchComponentState();
}

class _HomeSearchComponentState extends State<HomeSearchComponent> {
  //[ ]: Implement Search Functionality
  //[ ]: Clickable Suggestions and Results navigate to Product/Category Page

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(
            context: context,
            delegate: SearchSnacks(hintText: 'Search for Categories...'));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1.5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.search),
            SizedBox(width: 10),
            Text(
              'Search here...',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchSnacks extends SearchDelegate {
  SearchSnacks({
    required String hintText,
  }) : super(
            searchFieldLabel: hintText,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            searchFieldStyle: const TextStyle(
              color: Colors.grey,
          ),
        );
  List<Map<String, Widget>> items = [
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

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Map<String, Widget>> matchQuery = [];
    for (var item in items) {
      if (item['title']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var item = matchQuery[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              item['image']!,
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  item['title']!,
                  item['subtitle']!,
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map<String, Widget>> matchQuery = [];
    for (var item in items) {
      if (item['title']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var item = matchQuery[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              item['image']!,
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  item['title']!,
                  item['subtitle']!,
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
