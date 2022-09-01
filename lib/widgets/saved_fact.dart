import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SavedFact extends StatelessWidget {
  const SavedFact({required this.text, required this.time, required this.delete, Key? key}) : super(key: key);

  final DateTime time;
  final String text;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              spacing: 6,
              borderRadius: BorderRadius.circular(20),
              onPressed: (context) => delete(),
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Card(
          elevation: 5,
          color: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Image.asset(
                          'img/cat_icon.png',
                          height: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      const TextSpan(text: '\u{00A0}\u{00A0}\u{00A0}'), // just to add some spacing
                      TextSpan(
                        text: DateFormat('dd/MM/yyy  kk:mm').format(time),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(20),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
