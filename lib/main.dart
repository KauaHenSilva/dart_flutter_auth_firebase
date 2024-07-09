import 'package:dart_flutter_auth_firebase/auth/auth_page.dart';
import 'package:dart_flutter_auth_firebase/auth/forgot_password_page.dart';
import 'package:dart_flutter_auth_firebase/models/auth.dart';
import 'package:dart_flutter_auth_firebase/models/firestore_database.dart';
import 'package:dart_flutter_auth_firebase/my_theme_data.dart';
import 'package:dart_flutter_auth_firebase/pages/home_page.dart';
import 'package:dart_flutter_auth_firebase/pages/main_page.dart';
import 'package:dart_flutter_auth_firebase/utils/my_routes.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => FirestoreDatabase()),
      ],
      child: const MyApp(),
    ),
  );
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
      initialRoute: MyRoutes.mainPage,
      routes: {
        MyRoutes.authPage: (context) => const AuthPage(),
        MyRoutes.mainPage: (context) => const MainPage(),
        MyRoutes.homePage: (context) => const HomePage(),
        MyRoutes.forgotPasswordPage: (context) => const ForgotPasswordPage(),
      },
    );
  }
}
