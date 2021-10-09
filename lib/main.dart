import 'package:flutter/material.dart';
import 'package:FirebaseEcommerce/screen/initializing_%20app/initializing_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vatrina',
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          accentColor: Colors.red,
          scaffoldBackgroundColor: Colors.grey[50],
          primarySwatch: Colors.blue,
          appBarTheme:
              AppBarTheme(iconTheme: IconThemeData(color: Colors.grey))),
      home: InitializingApp(),
    );
  }
}
