// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegetables/data/vegetable_data.dart';
import 'package:vegetables/screens/vegi_list_screen/widgets/vege_card.dart';

const _viewportFraction = 0.8;
final _items = [
  VegetableData(color: Colors.orange),
  VegetableData(color: Colors.green),
  VegetableData(color: Colors.purple),
  VegetableData(color: Colors.blue),
  VegetableData(color: Colors.pink),
];

class VegeListScreen extends StatefulWidget {
  const VegeListScreen({super.key});

  @override
  State<VegeListScreen> createState() => _VegeListScreenState();
}

class _VegeListScreenState extends State<VegeListScreen> {
  final controller = PageController(
    viewportFraction: _viewportFraction,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBar(),
            bulidHeader(),
            const SizedBox(height: 16),
            buildList(),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    return Expanded(
      child: LayoutBuilder(builder: (context, cons) {
        return Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: cons.maxWidth * (1 - _viewportFraction) / -2,
              child: PageView.builder(
                itemCount: _items.length,
                controller: controller,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        double p = controller.position.hasContentDimensions
                            ? controller.page ?? 0
                            : 0.0;

                        p = (index - p) * 0.5 + 0.5;
                        return VegeCard(
                          progress: p,
                          vegetable: _items[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget bulidHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'FEAT.\n.URED',
            style: GoogleFonts.robotoMono(
                fontSize: 30, letterSpacing: 15, fontWeight: FontWeight.w700),
          ),
          Spacer(),

          IconButton(
            onPressed: () {},
            icon: Icon(Icons.view_carousel),
          ),
          // Icon(Icons.view_carousel),
          // const SizedBox(width: 15),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.view_day),
          )
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/horned-owl.jpeg'),
          ),
          Expanded(
            child: Text(
              'DISCOVER',
              textAlign: TextAlign.center,
              style: GoogleFonts.arimo(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                // color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            // color: Colors.white,
          ),
        ],
      ),
    );
  }
}
