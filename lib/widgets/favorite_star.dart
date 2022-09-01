import 'package:flutter/material.dart';

import '../boxes.dart';
import '../models/favorite_fact.dart';

class FavoriteStart extends StatefulWidget {
  const FavoriteStart(this.fact, {Key? key}) : super(key: key);

  final FavoriteFact fact;

  @override
  State<FavoriteStart> createState() => _FavoriteStartState();
}

class _FavoriteStartState extends State<FavoriteStart> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: GestureDetector(
        onTap: () {
          setState(() => isSelected = !isSelected);
          isSelected ? Boxes.getFavoriteFacts().add(widget.fact) : widget.fact.delete(); // deletes only current
        },
        child: Icon(
          Icons.star_rounded,
          size: 45,
          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).primaryColor,
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
