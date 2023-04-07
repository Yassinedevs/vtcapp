import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vtc_application/ui/commons/design.dart';
import 'package:vtc_application/ui/screens/add_user.dart';
import 'package:vtc_application/ui/screens/connexion.dart';
import 'package:vtc_application/ui/screens/home_page.dart';

// Pour autoriser la connexion avec une IP au lieu d'un nom de domaine
// (vers ma BDD)
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // A eviter pour la mise en prod
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VCT Reservation',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: AppColors(),
      ),
      routes: {
        '/connexion': (context) => const Connexion(),
        '/addUser': (context) => const AddUser(),
        HomePage.routeName: (context) => const HomePage(),
      },
      initialRoute: '/connexion',
    );
  }
}
