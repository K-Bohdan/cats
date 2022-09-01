import 'package:cats/widgets/page_toggle.dart';
import 'package:flutter/material.dart';

class BottomFloatingBar extends StatelessWidget {
  const BottomFloatingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            PageToggle(
              pageIndex: 0,
              icon: Icons.pets_rounded,
              label: 'New Fact',
            ),
            PageToggle(
              pageIndex: 1,
              icon: Icons.star_rounded,
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
