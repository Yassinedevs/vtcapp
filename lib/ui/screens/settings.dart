import 'package:flutter/material.dart';
import 'package:vtc_application/models/dao_user.dart';
import 'package:vtc_application/ui/commons/responsive.dart';

class Settings extends StatefulWidget {
  const Settings(this.user, {super.key});

  final DAOUser user;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    double hauteur = Responsive.hauteur;
    double largeur = Responsive.largeur;
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.white),
      child: Scaffold(
          body: Container(
        width: largeur,
        height: hauteur / 3,
        margin: EdgeInsets.only(top: hauteur / 5),
        child: Column(children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero))),
            onPressed: (() {
              Navigator.of(context).pushNamed('/connexion');
            }),
            child: const Text('Deconnexion', textAlign: TextAlign.center),
          )
        ]),
      )),
    );
  }
}
