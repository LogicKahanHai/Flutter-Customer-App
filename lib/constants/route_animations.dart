import 'package:flutter/material.dart';

enum AnimationDirection { RTL, LTR, TTB, BTT }

class RouteAnimations {
  final Widget nextPage;
  final AnimationDirection animationDirection;

  final Map<AnimationDirection, Offset> _offsets = {
    AnimationDirection.RTL: const Offset(1.0, 0.0),
    AnimationDirection.LTR: const Offset(-1.0, 0.0),
    AnimationDirection.TTB: const Offset(0.0, -1.0),
    AnimationDirection.BTT: const Offset(0.0, 1.0),
  };

  RouteAnimations(
      {required this.nextPage,
      this.animationDirection = AnimationDirection.RTL});

  Route createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = _offsets[animationDirection];
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
