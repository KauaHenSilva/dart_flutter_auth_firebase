import 'package:dart_flutter_auth_firebase/routes/login_page.dart';
import 'package:dart_flutter_auth_firebase/utils/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.supportedLocales,
      title: 'Flutter Auth Firebase',
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.light,
      initialRoute: MyRoutes.loginPage,
      routes: {
        MyRoutes.loginPage: (context) => const LoginPage(),
      },
    );
  }
}

class MyThemeData {
  static ThemeData get light {
    return ThemeData.light().copyWith(
      textTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.bebasNeue().fontFamily,
            ),
            displayMedium: const TextStyle(
              fontSize: 20,
            ),
          ),
    );
  }
}
