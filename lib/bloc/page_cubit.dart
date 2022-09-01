import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<PageController> {
  PageCubit() : super(PageController(initialPage: 0));

  void switchPageTo(int index) => state.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );

  @override
  void onChange(Change<PageController> change) {
    super.onChange(change);
    print(change);
  }
}
