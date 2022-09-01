import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/boxes.dart';
import '/models/known_fact.dart';
import '/widgets/header.dart';
import '/widgets/saved_fact.dart';

// FactHistory screen and Favorites screen utilises many similar functions
// and are structed in the similar manner
// yet in my opinion they are different enough not to extend the common model
// plus in the future they can separately be modified in vary specific ways

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class FactHistoryScreen extends StatelessWidget {
  const FactHistoryScreen({Key? key}) : super(key: key);

  Widget _displayHistory(List<KnownFact> todays, List<KnownFact> thisWeek, List<KnownFact> beforeThisWeek) {
    // i've extracted this function as different display may be required in future
    return ListView(
      children: [
        if (todays.isNotEmpty) const TimeDivider('Today'),
        for (final fact in todays)
          SavedFact(
            time: fact.date,
            text: fact.fact,
            delete: fact.delete,
          ),
        if (thisWeek.isNotEmpty) const TimeDivider('This Week'),
        for (final fact in thisWeek)
          SavedFact(
            time: fact.date,
            text: fact.fact,
            delete: fact.delete,
          ),
        if ((todays.isNotEmpty || thisWeek.isNotEmpty) && beforeThisWeek.isNotEmpty) const TimeDivider('Before This Week'),
        for (final fact in beforeThisWeek)
          SavedFact(
            time: fact.date,
            text: fact.fact,
            delete: fact.delete,
          ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(
              title: 'Fact History',
              toExecute: () => Navigator.pop(context),
            ),
            Expanded(
              // listening to the hive box and gatting values dynamically
              child: ValueListenableBuilder<Box<KnownFact>>(
                valueListenable: Boxes.getKnowsFacts().listenable(),
                builder: (context, box, _) {
                  final facts = box.values.toList().cast<KnownFact>();

                  facts.sort((KnownFact b, KnownFact a) => a.date.compareTo(b.date)); // desc

                  final todays = facts.where((fact) => DateTime.now().isSameDate(fact.date)).toList();

                  final thisWeek = facts.where((fact) {
                    return !DateTime.now().isSameDate(fact.date) && DateTime.now().subtract(const Duration(days: 8)).compareTo(fact.date) < 0;
                  }).toList();

                  final beforeThisWeek = facts
                      .where(
                        (fact) => DateTime.now().subtract(const Duration(days: 8)).compareTo(fact.date) >= 0,
                      )
                      .toList();
                  return _displayHistory(todays, thisWeek, beforeThisWeek);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeDivider extends StatelessWidget {
  const TimeDivider(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .06,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}
