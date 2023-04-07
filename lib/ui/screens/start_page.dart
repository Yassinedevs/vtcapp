import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vtc_application/models/dao_reservation.dart';
import 'package:vtc_application/models/dao_user.dart';
import 'package:vtc_application/repository/API/reservation_impl.dart';
import 'package:vtc_application/ui/commons/design.dart';
import 'package:vtc_application/ui/commons/responsive.dart';

class StartPage extends StatefulWidget {
  const StartPage(this.user, {super.key});

  final DAOUser user;

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late Future<List<DAOReservation>> daoReservations;
  DateFormat dateEU = DateFormat("dd/MM/yyyy à HH:mm");

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
        body: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.webp'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: largeur,
                  margin:
                      EdgeInsets.only(top: hauteur / 15, left: largeur / 25),
                  child: const Text(
                    "Accueil",
                    style: AppStyle.f30,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: largeur,
                  margin: EdgeInsets.only(left: largeur / 25),
                  child: Text(
                    "Bienvenue ${widget.user.firstname}",
                    style: const TextStyle(color: AppColors.secondaryColor),
                    textAlign: TextAlign.left,
                  ),
                ),
                FutureBuilder<List<DAOReservation>>(
                    future: daoReservations,
                    builder:
                        (context, AsyncSnapshot<List<DAOReservation>> snap) {
                      List<DAOReservation> reservations = snap.data ?? [];
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: AppColors.darkGrey,
                              )
                            ],
                          ),
                        );
                      }
                      if (snap.connectionState == ConnectionState.done &&
                          !snap.hasData) {
                        return const Center(
                          child: Text('Aucune trajet trouvée.'),
                        );
                      }
                      if (reservations.isEmpty) {
                        return Container(
                          margin: EdgeInsets.only(
                              left: largeur / 25,
                              top: hauteur / 3,
                              right: largeur / 25),
                          width: hauteur / 2,
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: hauteur / 50),
                                  child: const Text(
                                    "Vous n'avez pris de réservations. Vous devez au moins prendre un rendez-vous afin de visualiser vos reservations",
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        final now = DateTime.now();
                        final upcomingReservations = reservations
                            .where(
                                (reservation) => reservation.date.isAfter(now))
                            .take(3)
                            .toList();
                        if (upcomingReservations.isEmpty) {
                          return const Center(
                            child: Text('Aucun trajet à venir.'),
                          );
                        } else {
                          return Container(
                              margin: EdgeInsets.only(
                                  left: largeur / 25,
                                  top: incline ? 0 : hauteur / 3,
                                  right: largeur / 25),
                              width: incline ? largeur / 2 : largeur / 1.5,
                              height: incline ? hauteur / 1.8 : hauteur / 3,
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const Text(
                                                "Vos prochains trajets",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 10),
                                              DataTable(
                                                columnSpacing: 10,
                                                columns: const [
                                                  DataColumn(
                                                      label: Text("Date")),
                                                ],
                                                rows: upcomingReservations
                                                    .map((entity) =>
                                                        DataRow(cells: [
                                                          DataCell(Text(
                                                            dateEU.format(
                                                                entity.date),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          ))
                                                        ]))
                                                    .toList(),
                                              ),
                                              const SizedBox(height: 40),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }
                      }
                    }),
              ],
            )));
  }
}
