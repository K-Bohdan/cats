import 'package:flutter/material.dart';
import 'package:cats/main.dart';

class PageToggle extends StatefulWidget {
  const PageToggle({required this.pageIndex, required this.icon, required this.label, Key? key}) : super(key: key);

  final int pageIndex;
  final IconData icon;
  final String label;

  @override
  State<PageToggle> createState() => _PageToggleState();
}

class _PageToggleState extends State<PageToggle> {
  double currentPage = 0;
  late Color? color;

  @override
  void initState() {
    super.initState();
    pageController.state.addListener(() {
      setState(() {
        // PageController.page returns values from 0.0 to 1.0 when scroll between pages
        // where 0.0 is page one and 1.0 is page two
        // i pick up those values to transition between ColorTween
        currentPage = pageController.state.page ?? 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // this way i'm getting the evaluation whether this is the current page
    final eval = (widget.pageIndex - currentPage).abs();
    color = ColorTween(begin: Theme.of(context).cardColor, end: Colors.grey[400]).lerp(eval);

    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => pageController.switchPageTo(widget.pageIndex),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(widget.icon, color: color),
            Text(widget.label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
