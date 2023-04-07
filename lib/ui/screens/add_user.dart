import 'package:flutter/material.dart';
import 'package:vtc_application/models/dao_user.dart';
import 'package:vtc_application/repository/API/user_impl.dart';
import 'package:vtc_application/ui/commons/design.dart';
import 'package:vtc_application/ui/commons/responsive.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final GlobalKey<FormState> _userKey = GlobalKey();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _firstnameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _verifPasswordController =
      TextEditingController();

  // Enregistre l'utilisateur
  Future newUser() async {
    DAOUser newUser = DAOUser(
        idUser: 0,
        name: _nameController.text,
        firstname: _firstnameController.text,
        email: _emailController.text,
        password: _passwordController.text);
    await UserImpl().addUser(newUser, context).then((value) {
      if (value) {
        _nameController.clear();
        _firstnameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _verifPasswordController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool incline = Responsive.incline(context);
    var hauteur = Responsive.hauteur;
    var largeur = Responsive.largeur;
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: AppColors.black),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _userKey,
          child: Column(children: <Widget>[
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
              child: Column(
                children: <Widget>[
                  Container(
                    width: largeur,
                    margin: EdgeInsets.only(
                        top: hauteur / 25,
                        bottom: hauteur / 75,
                        left: largeur / 8),
                    child: const Text(
                      "Créer un compte",
                      style: AppStyle.f24,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    width: largeur / 1.15,
                    height: incline == false ? hauteur / 15 : hauteur / 10,
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le champ ne doit pas être vide';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: AppStyle.borderRad16,
                        labelText: "Nom",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hauteur / 100,
                  ),
                  SizedBox(
                    width: largeur / 1.15,
                    height: incline == false ? hauteur / 15 : hauteur / 10,
                    child: TextFormField(
                      controller: _firstnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le champ ne doit pas être vide';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: AppStyle.borderRad16,
                        labelText: "Prénom",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hauteur / 100,
                  ),
                  SizedBox(
                    width: largeur / 1.15,
                    height: incline == false ? hauteur / 15 : hauteur / 10,
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
                        labelText: "Email",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hauteur / 100,
                  ),
                  SizedBox(
                    width: largeur / 1.15,
                    height: incline == false ? hauteur / 15 : hauteur / 10,
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
                        labelText: "Mot de passe",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hauteur / 100,
                  ),
                  SizedBox(
                    width: largeur / 1.15,
                    height: incline == false ? hauteur / 15 : hauteur / 10,
                    child: TextFormField(
                      controller: _verifPasswordController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le champ ne doit pas être vide';
                        } else if (_verifPasswordController.text !=
                            _passwordController.text) {
                          return 'Mot de passe incorrect';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: AppStyle.borderRad16,
                        labelText: "Confirmer votre mot de passe",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hauteur / 75,
                  ),
                  SizedBox(
                    width: largeur / 1.15,
                    height: incline == false ? hauteur / 15 : hauteur / 10,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_userKey.currentState!.validate()) {
                          newUser();
                        }
                      },
                      child: const Text("S'inscire",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primaryColor,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: hauteur / 100,
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Vous avez déjà un compte ?',
                            style: TextStyle(
                              color: AppColors.thirdColor,
                            )),
                        TextButton(
                          style: TextButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.zero))),
                          onPressed: () async {
                            await Navigator.of(context).pushNamed('/connexion');
                          },
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
