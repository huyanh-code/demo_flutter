import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:namer_app/common/app_theme.dart';
import 'package:namer_app/service/book_provider.dart';
import 'package:namer_app/state/app_state.dart';
import 'package:namer_app/views/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyAppState()),
        ChangeNotifierProvider(create: (_) => BookProvider()),
      ],
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: kDefaultColor),
        ),
        home: HomeView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
