import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:vtc_application/models/dao_reservation.dart';
import 'package:vtc_application/models/dao_user.dart';
import 'package:vtc_application/repository/API/reservation_impl.dart';
import 'package:vtc_application/ui/commons/design.dart';
import 'package:vtc_application/ui/commons/responsive.dart';
import 'package:vtc_application/ui/screens/home_page.dart';

class Reservation extends StatefulWidget {
  const Reservation(this.user, {super.key});

  final DAOUser user;

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  DateFormat dateEU = DateFormat("dd/MM/yyyy à HH:mm");
  DateTime date = DateTime.now().toLocal();
  late Future<List<DAOReservation>> daoReservations;

  // Permet de refresh la liste après une action
  // Future setListReservation() async {
  //   setState(() {
  //     daoReservations = ReservationImpl().getAllReservation(widget.user.idUser);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    daoReservations = ReservationImpl().getAllReservation(widget.user.idUser);
  }

  @override
  Widget build(BuildContext context) {
    bool incline = Responsive.incline(context);
    double hauteur = Responsive.hauteur;
    double largeur = Responsive.largeur;
    return Scaffold(
        body: FutureBuilder<List<DAOReservation>>(
      future: daoReservations,
      builder: (context, AsyncSnapshot<List<DAOReservation>> snap) {
        List<DAOReservation> reservations = snap.data ?? [];
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Chargement en cours veuillez patienter !'),
              ],
            ),
          );
        }
        if (snap.connectionState == ConnectionState.done && !snap.hasData) {
          return const Center(
            child: Text('Aucune donnée trouvée.'),
          );
        }
        if (reservations.isEmpty) {
          return Column(
            children: <Widget>[
              Container(
                width: largeur,
                margin: EdgeInsets.only(top: hauteur / 15, left: largeur / 25),
                child: const Text(
                  "Vos Réservations",
                  style: AppStyle.f24,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                width: largeur,
                margin: EdgeInsets.only(left: largeur / 25),
                child: Text(
                  "Bonjour ${widget.user.firstname}",
                  style: const TextStyle(color: AppColors.black),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                width: largeur,
                margin: EdgeInsets.only(
                    top: hauteur / 15,
                    left: largeur / 25,
                    right: largeur / 25,
                    bottom: hauteur / 20),
                child: const Text(
                  "Vous n'avez pris de réservations. Vous devez au moins prendre un rendez-vous afin de visualiser vos reservations",
                  style: TextStyle(color: AppColors.black),
                  textAlign: TextAlign.left,
                ),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                        height: incline == false ? hauteur / 3 : hauteur / 3,
                        width: incline == false ? largeur / 1.25 : largeur / 2,
                        child: IconButton(
                          icon: SvgPicture.asset("assets/logo/calendrier.svg",
                              width: largeur / 1.5),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              HomePage.routeName,
                              arguments: {
                                'user': widget.user,
                                'idCurrentTab': 2
                              },
                            );
                          },
                        )),
                    Padding(
                      padding: EdgeInsets.only(bottom: hauteur / 50),
                      child: const Text(
                        "Appuyez ici pour prendre \nune réservation",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Column(
          children: [
            Container(
              width: largeur,
              margin: EdgeInsets.only(top: hauteur / 15, left: largeur / 25),
              child: const Text(
                "Vos Réservations",
                style: AppStyle.f24,
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: largeur,
              margin: EdgeInsets.only(left: largeur / 25),
              child: Text(
                "Bonjour ${widget.user.firstname}",
                style: const TextStyle(color: AppColors.black),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: ListView.separated(
                    itemCount: reservations.length,
                    itemBuilder: ((BuildContext context, int index) {
                      return Card(
                        elevation: 10,
                        child: ListTile(
                          leading: const Icon(Icons.route_outlined),
                          title: Text(
                              '${reservations[index].adStart.split(',').first}-${reservations[index].adEnd.split(',').first}'),
                          subtitle: Text(
                              'Date : ${dateEU.format(reservations[index].date)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(reservations[index].price),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.euro,
                                    size: 20.0,
                                    color: Colors.brown[900],
                                  )),
                            ],
                          ),
                          onTap: () {
                            // Voir les détails si besoin
                          },
                        ),
                      );
                    }),
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(height: 0);
                    },
                  )),
            ),
          ],
        );
      },
    ));
  }
}
