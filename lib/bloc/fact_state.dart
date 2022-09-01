part of 'fact_bloc.dart';

@immutable
abstract class FactState {}

class FactLoading extends FactState {}

class FactLoaded extends FactState {
  final String factText;

  FactLoaded({
    required this.factText,
  });
}
