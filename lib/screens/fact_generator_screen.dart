import 'package:flutter/material.dart';
import 'package:cats/widgets/fact_generator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/fact_bloc.dart';

import '/widgets/loading_placeholder.dart';
import '/widgets/history_button.dart';

class FactGeneratorScreen extends StatefulWidget {
  const FactGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<FactGeneratorScreen> createState() => _FactGeneratorScreenState();
}

class _FactGeneratorScreenState extends State<FactGeneratorScreen> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController controller;
  late Animation animation;
  String imageUrl = 'https://cataas.com/cat'; // not const to anable further anti-caching

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void didChangeDependencies() {
    // i've put animation declaration here to access BuildContext
    animation = Tween<double>(
      begin: -MediaQuery.of(context).size.height * .55,
      end: MediaQuery.of(context).size.height * .1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // required by AutomaticKeepAliveClientMixin
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .142),
                child: Column(
                  children: [
                    const LoadingPlaceholder(),
                    ElevatedButton(
                      onPressed: () {
                        // prevent multiple listeners upon rebuild
                        controller.removeListener(() {});

                        if (controller.status == AnimationStatus.completed) {
                          controller
                            ..reverse()
                            ..addListener(() {
                              // this way i launch new fact loading only when widget is off the screen
                              if (controller.status == AnimationStatus.dismissed) {
                                context.read<FactBloc>().add(AnotherFactEvent());
                                setState(() {
                                  // here i try to prevent image caching in the simpliest way
                                  // more sophisticated approach canbe provided if time time's given
                                  imageUrl = 'https://cataas.com/cat?${DateTime.now().millisecondsSinceEpoch.toString()}';
                                });
                              }
                            });
                        }
                      },
                      style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll<double>(10),
                        backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                        padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
                        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Another fact',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: animation.value,
                child: Card(
                  elevation: 10,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white,
                  child: SizedBox(
                    // AspectRatio could've work as well
                    width: MediaQuery.of(context).size.width * .73,
                    height: MediaQuery.of(context).size.height * .5,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return FactGenerator(
                        key: UniqueKey(), // necessary to rebuild widget and also prevent caching
                        controller,
                        imageUrl: imageUrl,
                      );
                    }),
                  ),
                ),
              ),
              const HistoryButton(),
            ],
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
