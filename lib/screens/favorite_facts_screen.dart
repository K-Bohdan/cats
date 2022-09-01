import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/main.dart';
import '/boxes.dart';
import '/models/favorite_fact.dart';
import '/widgets/header.dart';
import '/widgets/saved_fact.dart';

// FactHistory screen and Favorites screen utilises many similar functions
// and are structed in the similar manner
// yet in my opinion they are different enough not to extend the common model
// plus in the future they can separately be modified in vary specific ways

class FavoriteFactsScreen extends StatelessWidget {
  const FavoriteFactsScreen({Key? key}) : super(key: key);

  Widget _displayFavorites(List<FavoriteFact> facts) {
    // i've extracted this function as different display may be required in future
    return ListView(
      children: [
        for (final fact in facts)
          SavedFact(
            time: fact.date,
            text: fact.fact,
            delete: fact.delete,
          ),
        const SizedBox(
          height: 150,
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
              title: 'Favorites',
              toExecute: () => pageController.switchPageTo(0),
            ),
            Expanded(
              // listening to the hive box and gatting values dynamically
              child: ValueListenableBuilder<Box<FavoriteFact>>(
                valueListenable: Boxes.getFavoriteFacts().listenable(),
                builder: (context, box, _) {
                  final facts = box.values.toList().cast<FavoriteFact>();
                  facts.sort((FavoriteFact b, FavoriteFact a) => a.date.compareTo(b.date)); // desc
                  return _displayFavorites(facts);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
