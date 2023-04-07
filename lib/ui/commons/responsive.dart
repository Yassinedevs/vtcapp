import 'package:flutter/material.dart';

class Responsive {
  static double hauteur = 0;
  static double largeur = 0;

  static bool incline(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    hauteur = size.height;
    largeur = size.width;
    return hauteur > 640 ? false : true;
  }
}
