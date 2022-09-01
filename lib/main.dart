import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'models/fact.dart';
import 'models/favorite_fact.dart';
import 'models/known_fact.dart';

import 'screens/fact_generator_screen.dart';
import 'screens/fact_history_screen.dart';
import 'screens/favorite_facts_screen.dart';

import 'bloc/page_cubit.dart';
import 'bloc/fact_bloc.dart';

import './widgets/bottom_floating_bar.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color(0xFF309975)));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  Hive.registerAdapter(KnownFactAdapter());
  Hive.registerAdapter(FavoriteFactAdapter());
  await Hive.openBox<KnownFact>('knownfacts');
  await Hive.openBox<FavoriteFact>('favorites');
  runApp(const CatsFacts());
}

class CatsFacts extends StatelessWidget {
  const CatsFacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = FactGetter(Dio());
    return MultiBlocProvider(
      providers: [
        // invoke event of the app start
        BlocProvider(create: (context) => FactBloc(api)..add(AnotherFactEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cats Facts',
        theme: ThemeData(
          primaryColor: const Color(0xFF309975),
          scaffoldBackgroundColor: const Color(0xFF309975),
          cardColor: const Color(0xFF454d66),
          colorScheme: const ColorScheme.light(
            primary: Color(0xFFdad873),
            secondary: Color(0xFFefeeb4),
            tertiary: Color(0xFFCE6A49),
          ),
        ),
        home: const MainScreen(),
        routes: <String, WidgetBuilder>{
          '/history': (context) => const FactHistoryScreen(),
        },
      ),
    );
  }
}

final pageController = PageCubit();

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              controller: pageController.state,
              scrollDirection: Axis.horizontal,
              children: const [
                FactGeneratorScreen(),
                FavoriteFactsScreen(),
              ],
            ),
            const Positioned(
              bottom: 50,
              child: BottomFloatingBar(),
            )
          ],
        ),
      ),
    );
  }
}
