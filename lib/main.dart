import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'providers/scan_list_provider.dart';
import 'providers/ui_provider.dart';

 
void main() => runApp(const MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider() ),
        ChangeNotifierProvider(create: (_) => ScanListProvider() ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': ( _ ) => const HomePage()
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple
          )
        ),
      ),
    );

  }
}