import 'package:flutter/material.dart';
import 'package:vegitables/data/vegitable_data.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    required this.vegitable,
    required this.transitionAnim,
    super.key,
  });

  final VegitableData vegitable;
  final Animation<double> transitionAnim;

  static PageRoute createRoute(VegitableData vegitable) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 800),
      reverseTransitionDuration: const Duration(milliseconds:800),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return DetailsScreen(
          vegitable: vegitable,
          transitionAnim: animation,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            )
                .chain(CurveTween(curve: Curves.easeInOutSine))
                .animate(transitionAnim),
            child: const Scaffold(
              body: Placeholder(),
            ),
          ),
        ),
        Positioned(
          top: -150,
          left: 0,
          right: 0,
          child: Center(
            child: Hero(
              tag: vegitable,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  vegitable.color,
                  BlendMode.modulate,
                ),
                child: Image.asset(
                  'assets/pepper_bowl_bw.png',
                  height: 300,
                  width: 300,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
