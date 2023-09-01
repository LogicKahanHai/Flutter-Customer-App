import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/screens/cart/ui/cart_page.dart';
import 'package:pk_customer_app/screens/home/ui/home_page.dart';

Widget bottomNavBar({
  required int currentIndex,
  required String currentPage,
  required BuildContext context,
}) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.shifting,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    currentIndex: currentIndex,
    onTap: (index) {
      switch (index) {
        case 0:
          if (currentPage != 'home') {
            //FIXME: This should basically pop the stack till home page and not push a new page, because new page loads again and calls the server again.
            Navigator.pushReplacement(
                context,
                RouteAnimations(
                  nextPage: const HomePage(),
                  animationDirection: AnimationDirection.LTR,
                ).createRoute());
          }
          break;
        case 1:
          if (currentIndex != 1) {
            //FIXME: This is a temporary fix, remove this when the "Saved/bookmark page" is ready.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Coming soon'),
                backgroundColor: PKTheme.primaryColor,
                duration: Duration(milliseconds: 1000),
              ),
            );
            // if (currentPage != 'home') {
            //   Navigator.pushReplacement(
            //       context,
            //       RouteAnimations(
            //         nextPage: const HomePage(),
            //         animationDirection: AnimationDirection.leftToRight,
            //       ).createRoute());
            // }
          }
          break;
        case 2:
          if (currentIndex != 2) {
            //FIXME: This is a temporary fix, remove this when the "Profile page" is ready.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Coming soon'),
                backgroundColor: PKTheme.primaryColor,
                duration: Duration(milliseconds: 500),
              ),
            );
            // if (currentPage != 'home') {
            //   Navigator.pushReplacement(
            //       context,
            //       RouteAnimations(
            //         nextPage: const HomePage(),
            //         animationDirection: AnimationDirection.leftToRight,
            //       ).createRoute());
            // }
          }
          break;
        case 3:
          if (currentIndex != 3) {
            //FIXME: This is a temporary fix, remove this when the "Cart page" is ready.
            Navigator.pushReplacement(
                context,
                RouteAnimations(
                  nextPage: const CartPage(),
                  animationDirection: AnimationDirection.RTL,
                ).createRoute());
            // if (currentPage != 'home') {
            //   Navigator.pushReplacement(
            //       context,
            //       RouteAnimations(
            //         nextPage: const HomePage(),
            //         animationDirection: AnimationDirection.leftToRight,
            //       ).createRoute());
            // }
          }
          break;
        default:
          return;
      }
    },
    selectedIconTheme: const IconThemeData(color: Colors.black),
    unselectedIconTheme: const IconThemeData(color: Colors.black),
    items: const [
      BottomNavigationBarItem(
        backgroundColor: PKTheme.bottomNavBarBg,
        icon: Icon(Icons.home_outlined),
        label: '',
        activeIcon: Icon(Icons.home),
      ),
      BottomNavigationBarItem(
        backgroundColor: PKTheme.bottomNavBarBg,
        icon: Icon(Icons.bookmark_border_outlined),
        label: '',
        activeIcon: Icon(Icons.bookmark),
      ),
      BottomNavigationBarItem(
        backgroundColor: PKTheme.bottomNavBarBg,
        icon: Icon(Icons.account_circle_outlined),
        label: '',
        activeIcon: Icon(Icons.account_circle),
      ),
      BottomNavigationBarItem(
        backgroundColor: PKTheme.bottomNavBarBg,
        icon: Icon(Icons.shopping_bag_outlined),
        label: '',
        activeIcon: Icon(Icons.shopping_bag),
      ),
    ],
  );
}
