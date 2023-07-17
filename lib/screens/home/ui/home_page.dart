import 'package:flutter/material.dart';
import 'package:pk_customer_app/screens/home/ui/components/home_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: const Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              HomeAddressSelectComponent(),
              SizedBox(height: 20),
              HomeSearchComponent(),
              SizedBox(height: 20),
              HomeOffersCarousel(),
              SizedBox(height: 20),
              HomeCategoryList(),
              SizedBox(height: 20),
              HomeFavProducts(),
              SizedBox(height: 20),
              HomeAbout(),
            ],
          ),
        ),
      ),
    );
  }
}
