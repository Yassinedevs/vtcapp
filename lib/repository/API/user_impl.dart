// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vtc_application/models/dao_user.dart';
import 'package:vtc_application/ui/screens/home_page.dart';
import '../ShowToast/show_toast.dart';
import 'env.dart';

class UserImpl {
  // Se connecte au compte
  Future connexion(DAOUser user, BuildContext context) async {
    var url = "${Env.urlPrefix}/user/login.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": user.email,
      "password": user.password,
    });
    var data = jsonDecode(response.body);
    if (data['status'] == "success") {
      user = DAOUser(
        name: data['name'],
        firstname: data['firstname'],
        email: data['email'],
        idUser: data['idUser'],
        password: '',
      );
      Navigator.pushNamed(
        context,
        HomePage.routeName,
        arguments: {'user': user},
      );
      ShowToast.showSuccessToast('Connexion réussis');
      return true;
    } else {
      ShowToast.showErrorToast("Email ou mot de passe incorrect !");
      return false;
    }
  }

  // Ajoute un compte
  Future addUser(DAOUser user, BuildContext context) async {
    var url = "${Env.urlPrefix}/user/register.php";
    var response = await http.post(Uri.parse(url), body: {
      "name": user.name,
      "firstname": user.firstname,
      "email": user.email,
      "password": user.password,
    });

    var data = jsonDecode(response.body);
    if (data == "Error") {
      ShowToast.showErrorToast("Compte déjà existant!");
      return false;
    } else {
      Navigator.pushNamed(
        context,
        HomePage.routeName,
        arguments: {'user': user},
      );
      ShowToast.showSuccessToast('Inscription réussis');
      return true;
    }
  }
}
