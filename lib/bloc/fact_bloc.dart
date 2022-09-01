import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:cats/models/fact.dart';
import 'package:dio/dio.dart';

part 'fact_event.dart';
part 'fact_state.dart';

class FactBloc extends Bloc<FactEvent, FactState> {
  FactBloc(
    FactGetter api,
  ) : super(FactLoading()) {
    on<FactEvent>((event, emit) async {
      emit(FactLoading());
      // await Future.delayed(Duration(seconds: 2));
      // emit(FactLoaded(factText: '234'));
      try {
        final fact = await api.getFact();
        emit(FactLoaded(factText: fact.fact.toString()));
      } catch (e) {
        switch (e.runtimeType) {
          case DioError:
            final res = (e as DioError).response;
            print("Got error : ${res!.statusCode} -> ${res.statusMessage}");
            break;
          default:
            break;
        }
      }
      // api.getFact().then((fact) {
      //   print(fact.fact);
      //   emit(FactLoaded(factText: '123'));
      // }).catchError((Object obj) {
      //   switch (obj.runtimeType) {
      //     case DioError:
      //       final res = (obj as DioError).response;
      //       print("Got error : ${res!.statusCode} -> ${res.statusMessage}");
      //       break;
      //     default:
      //       break;
      //   }
      // });
    });
  }
}
