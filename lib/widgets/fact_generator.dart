import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../boxes.dart';

import '../models/known_fact.dart';
import '../models/favorite_fact.dart';
import '../bloc/fact_bloc.dart';
import './favorite_star.dart';

class FactGenerator extends StatefulWidget {
  const FactGenerator(this.controller, {required this.imageUrl, Key? key}) : super(key: key);

  final AnimationController controller;
  final String imageUrl;

  @override
  State<FactGenerator> createState() => _FactGeneratorState();
}

class _FactGeneratorState extends State<FactGenerator> {
  bool isImageLoaded = false;
  late Image img;

  @override
  void initState() {
    super.initState();
    img = Image.network(widget.imageUrl, scale: 1.5, fit: BoxFit.fill);
    // solution below ensure for network image to be fully loaded
    // before it appears on screen
    img.image.resolve(const ImageConfiguration()).addListener(ImageStreamListener((ImageInfo image, bool synchronousCall) {
      if (mounted) {
        setState(() {
          isImageLoaded = true;
        });
      }
    }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FactBloc, FactState>(
      builder: (context, state) {
        if (state is FactLoading) {
          // this is never actually visible for user, but left so the sake of future modifications
          return const CircularProgressIndicator();
        }

        if (state is FactLoaded) {
          final text = state.factText;

          // extra conditions so the card with data do not appear on screen before it is completely loaded
          if (widget.controller.status != AnimationStatus.reverse && widget.controller.status == AnimationStatus.dismissed && isImageLoaded) {
            widget.controller.forward();
            final knownFact = KnownFact()
              ..fact = text
              // here date stores in default format as it may need to be
              // formated differently in the future if locale changes
              ..date = DateTime.now().toLocal();

            // storing fact in local db
            Boxes.getKnowsFacts().add(knownFact);
          }

          return LayoutBuilder(builder: (context, constraints) {
            // localization for time display
            final String locale = Localizations.localeOf(context).languageCode;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * .6,
                      child: img,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * .1,
                      child: Text(
                        DateFormat.yMMMEd(locale).format(
                          DateTime.now().toLocal(),
                        ),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * .3,
                      child: Text(text, overflow: TextOverflow.fade),
                    ),
                  ],
                ),
                FavoriteStart(
                  FavoriteFact()
                    ..fact = text
                    ..date = DateTime.now().toLocal(),
                ),
              ],
            );
          });
        }
        // this also requires a better error handler
        // even those this block of code may never be executed
        return const Text('Oops, some error occured');
      },
    );
  }
}
