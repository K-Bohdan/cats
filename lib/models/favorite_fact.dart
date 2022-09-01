import 'package:hive/hive.dart';

part 'favorite_fact.g.dart';

@HiveType(typeId: 1)
class FavoriteFact extends HiveObject {
  @HiveField(0)
  late DateTime date;

  @HiveField(1)
  late String fact;
}
