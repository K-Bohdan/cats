import 'package:hive/hive.dart';
import '/models/known_fact.dart';
import '/models/favorite_fact.dart';

class Boxes {
  static Box<KnownFact> getKnowsFacts() => Hive.box<KnownFact>('knownfacts');
  static Box<FavoriteFact> getFavoriteFacts() => Hive.box<FavoriteFact>('favorites');
}
