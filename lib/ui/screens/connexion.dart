import 'package:flutter/material.dart';
import 'package:vtc_application/models/dao_user.dart';
import 'package:vtc_application/repository/API/user_impl.dart';
import 'package:vtc_application/ui/commons/design.dart';
import 'package:vtc_application/ui/commons/responsive.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final GlobalKey<FormState> _connexionkey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  // Se connecte à l'application
  Future login() async {
    DAOUser logUser = DAOUser(
        idUser: 0,
        email: _emailController.text,
        password: _passwordController.text,
        firstname: '',
        name: '');
    await UserImpl().connexion(logUser, context).then((value) {
      if (value) {
        _emailController.clear();
        _passwordController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool incline = Responsive.incline(context);
    double hauteur = Responsive.hauteur;
    double largeur = Responsive.largeur;
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: AppColors.black),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _connexionkey,
          child: Column(
            children: <Widget>[
              Container(
                height: incline == false ? hauteur / 3 : 0,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/vtc_logo.png'))),
              ),
              Container(
                height: incline == false ? hauteur * 2 / 3 : hauteur,
                width: largeur,
                decoration: AppStyle.yellowBox,
                child: Column(children: <Widget>[
                  Container(
                    width: largeur,
                    margin:
                        EdgeInsets.only(top: hauteur / 25, left: largeur / 8),
                    child: const Text(
                      "Connexion",
                      style: AppStyle.f24,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    width: largeur / 1.15,
                    margin: EdgeInsets.only(top: hauteur / 35),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le champ ne doit pas être vide';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: AppStyle.borderRad16,
                        prefixIcon: Icon(Icons.mail),
                        labelText: "Email",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hauteur / 40,
                  ),
                  SizedBox(
                    width: largeur / 1.15,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      obscuringCharacter: "*",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le champ ne doit pas être vide';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: AppStyle.borderRad16,
                        prefixIcon: Icon(Icons.key),
                        labelText: "Mot de passe",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hauteur / 100,
                  ),
                  Container(
                    width: largeur / 1.15,
                    height: incline == false ? hauteur / 15 : hauteur / 10,
                    margin: EdgeInsets.only(top: hauteur / 35),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_connexionkey.currentState!.validate()) {
                            login();
                          }
                        },
                        child: const Text('Se connecter',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryColor,
                            ))),
                  ),
                  SizedBox(
                    height: hauteur / 50,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: largeur / 9),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        // onTap: mdpPerdu,
                        child: const Text('Mot de passe oublié ?',
                            style: TextStyle(
                              color: AppColors.thirdColor,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hauteur / 100,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Vous n\'avez pas de compte ?',
                              style: TextStyle(
                                color: AppColors.thirdColor,
                              )),
                          TextButton(
                            style: TextButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.zero))),
                            onPressed: () async {
                              await Navigator.of(context).pushNamed('/addUser');
                            },
                            child: const Text(
                              'S\'inscrire',
                              style: TextStyle(color: AppColors.darkblue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
