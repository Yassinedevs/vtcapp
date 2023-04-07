// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vtc_application/models/dao_reservation.dart';
import 'package:vtc_application/models/dao_user.dart';
import 'package:vtc_application/ui/screens/home_page.dart';
import 'env.dart';
import '../ShowToast/show_toast.dart';

class ReservationImpl {
  // Récupère le listing des reservations de l'utilisateur
  Future<List<DAOReservation>> getAllReservation(int id) async {
    var url = "${Env.urlPrefix}/reservation/getReservation.php";
    var response = await http.post(Uri.parse(url), body: {
      "idUser": id.toString(),
    });
    final items = jsonDecode(response.body).cast<Map<String, dynamic>>();
    List<DAOReservation> listeReservations = items.map<DAOReservation>((json) {
      return DAOReservation.fromJson(json);
    }).toList();
    return listeReservations;
  }

  // Ajoute une reservation
  Future addReservation(
      DAOReservation reservation, DAOUser user, BuildContext context) async {
    var url = "${Env.urlPrefix}/reservation/newReservation.php";
    var response = await http.post(Uri.parse(url), body: {
      "date": reservation.date.toIso8601String(),
      "adStart": reservation.adStart,
      "adEnd": reservation.adEnd,
      "distance": reservation.distance,
      "price": reservation.price,
      "idUser": reservation.idUser.toString(),
    });
    var data = jsonDecode(response.body);
    if (data == "Error") {
      ShowToast.showErrorToast('Error 101');
      return false;
    } else {
      ShowToast.showSuccessToast('Reservation accepté');
      Navigator.pushNamed(
        context,
        HomePage.routeName,
        arguments: {'user': user},
      );
      return true;
    }
  }
}
