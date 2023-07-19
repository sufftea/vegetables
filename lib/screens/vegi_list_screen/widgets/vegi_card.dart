// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegitables/data/vegitable_data.dart';
import 'package:vegitables/screens/details_screen/details_screen.dart';

class VegiCard extends StatefulWidget {
  const VegiCard({
    required this.progress,
    required this.vegitable,
    super.key,
  });

  final double progress;
  final VegitableData vegitable;

  @override
  State<VegiCard> createState() => _VegiCardState();
}

class _VegiCardState extends State<VegiCard> with TickerProviderStateMixin {
  late final tapAnimCtrl = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );
  final tapAnimTween =
      Tween(begin: 1.0, end: 0.95).chain(CurveTween(curve: Curves.easeOutCirc));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        tapAnimCtrl.forward();
      },
      onTapCancel: () {
        tapAnimCtrl.animateBack(0);
      },
      onTapUp: (details) {
        tapAnimCtrl.animateBack(0);

        Navigator.of(context).push(DetailsScreen.createRoute(widget.vegitable));
      },
      child: AnimatedBuilder(
        animation: tapAnimCtrl,
        builder: (context, child) {
          return Transform.scale(
            scale: tapAnimTween.evaluate(tapAnimCtrl),
            child: child!,
          );
        },
        child: Transform.scale(
          alignment:
              widget.progress > 0.5 ? Alignment.topLeft : Alignment.topCenter,
          scale: lerpDouble(
            0.6,
            1,
            widget.progress < 0.5
                ? widget.progress * 2
                : 2 - widget.progress * 2,
          ),
          child: Container(
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.lerp(widget.vegitable.color, Colors.white, 0.3)!,
                  Color.lerp(widget.vegitable.color, Colors.white, 0.5)!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                buildHeader(),
                buildBowl(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/horned-owl.jpeg'),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Martha Sandoval',
                    style: GoogleFonts.arimo(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '29 JUL',
                    style: GoogleFonts.arimo(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Spicy Maguro',
                style: GoogleFonts.arimo(
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                    letterSpacing: 2),
              ),
              Spacer(),
              Icon(
                Icons.favorite_outlined,
                color: Colors.black,
              ),
            ],
          ),
          Text(
            'Rich nutrition',
            style: GoogleFonts.arimo(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            style: ButtonStyle(
              elevation: MaterialStatePropertyAll(20),
              shape: MaterialStatePropertyAll(StadiumBorder()),
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              foregroundColor: MaterialStatePropertyAll(Colors.black),
              textStyle: MaterialStatePropertyAll(TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
              padding: MaterialStatePropertyAll(const EdgeInsets.all(12)),
            ),
            icon: Icon(Icons.add_circle_rounded),
            label: Text('Add to bag'),
          ),
        ],
      ),
    );
  }

  Expanded buildBowl() {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            right: -60,
            child: Hero(
              tag: widget.vegitable,
              flightShuttleBuilder: (
                flightContext,
                animation,
                flightDirection,
                fromHeroContext,
                toHeroContext,
              ) {
                final rotationAnim =
                    Tween(begin: pi / 6, end: 0.0).animate(animation);

                return AnimatedBuilder(
                  animation: rotationAnim,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: rotationAnim.value,
                      child: child,
                    );
                  },
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      widget.vegitable.color,
                      BlendMode.modulate,
                    ),
                    child: Image.asset(
                      'assets/pepper_bowl_bw.png',
                      fit: BoxFit.contain,
                      height: 350,
                      width: 350,
                    ),
                  ),
                );
              },
              child: Transform.rotate(
                angle: lerpDouble(0, pi / 3, widget.progress)!,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    widget.vegitable.color,
                    BlendMode.modulate,
                  ),
                  child: Image.asset(
                    'assets/pepper_bowl_bw.png',
                    fit: BoxFit.contain,
                    height: 350,
                    width: 350,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
