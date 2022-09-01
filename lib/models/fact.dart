import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fact.g.dart';

// herokuapp server wasn'tresponding for most of the time i was working on this task
// thus i've found ninja endpoint with exactly the same api purpose
// @RestApi(baseUrl: "https://cat-fact.herokuapp.com/")
@RestApi(baseUrl: "https://catfact.ninja")
abstract class FactGetter {
  factory FactGetter(Dio dio, {String baseUrl}) = _FactGetter;

  // @GET('/facts/random') <--herokuapp
  @GET('/fact?max_length=200')
  Future<Fact> getFact();
}

@JsonSerializable()
class Fact {
  String? fact;

  Fact({
    this.fact,
  });

  factory Fact.fromJson(Map<String, dynamic> json) => _$FactFromJson(json);
}
