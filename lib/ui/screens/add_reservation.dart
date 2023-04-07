// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vtc_application/models/address.dart';
import 'package:vtc_application/models/dao_reservation.dart';
import 'package:vtc_application/models/dao_user.dart';
import 'package:vtc_application/repository/API/reservation_impl.dart';
import 'package:vtc_application/repository/API/search_address.dart';
import 'package:vtc_application/ui/commons/design.dart';
import 'package:vtc_application/ui/commons/responsive.dart';

class AddReservation extends StatefulWidget {
  const AddReservation(this.user, {super.key});

  final DAOUser user;

  static const routeName = '/addReservation';

  @override
  State<AddReservation> createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  final GlobalKey<FormState> _reservationkey = GlobalKey();
  final TextEditingController _adStartController = TextEditingController();
  final TextEditingController _adEndController = TextEditingController();
  List<Address> _addresseStart = [];
  double latitudeStart = 0;
  double longitudeStart = 0;
  List<Address> _addresseEnd = [];
  double latitudeEnd = 0;
  double longitudeEnd = 0;
  bool selctAdStart = false;
  bool selctAdEnd = false;
  String distance = '0';
  String price = '0';

  Future<void> _calculateDistance() async {
    final distanceM = Geolocator.distanceBetween(
      latitudeStart,
      longitudeStart,
      latitudeEnd,
      longitudeEnd,
    );
    setState(() {
      distance = (distanceM / 1000).toStringAsFixed(2);
      price = (distanceM / 1000 * 2.5).toStringAsFixed(2);
    });
  }

  Future<DateTime?> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
      selectableDayPredicate: (DateTime date) {
        return date.weekday != 6 && date.weekday != 7;
      },
    );
    if (pickedDate == null) return null;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return null;
    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }

  late DateTime selectedDateTime;
  // Enregistre la réservation
  Future newReservation() async {
    final dateTime = await _selectDateTime(context);
    if (dateTime != null) {
      setState(() {
        selectedDateTime = dateTime;
      });
      DAOReservation newReservation = DAOReservation(
          idReservation: 0,
          date: selectedDateTime,
          adStart: _adStartController.text,
          adEnd: _adEndController.text,
          distance: distance,
          price: price,
          idUser: widget.user.idUser);
      await ReservationImpl()
          .addReservation(newReservation, widget.user, context)
          .then((value) {
        if (value) {
          _adStartController.clear();
          _adEndController.clear();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool incline = Responsive.incline(context);
    var hauteur = Responsive.hauteur;
    var largeur = Responsive.largeur;
    return Scaffold(
        body: Column(children: <Widget>[
      Container(
        width: largeur,
        margin: EdgeInsets.only(top: hauteur / 15, left: largeur / 5),
        child: const Text(
          "RESERVATION VTC",
          style: AppStyle.f24,
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(
        height: hauteur / 20,
      ),
      SizedBox(
        width: largeur,
        height: incline == false ? hauteur / 2 : hauteur / 6,
        child: Form(
          key: _reservationkey,
          child: Column(children: <Widget>[
            Container(
              width: largeur / 1.25,
              margin: EdgeInsets.only(
                  left: largeur / 10, top: hauteur / 50, right: largeur / 10),
              child: TextFormField(
                controller: _adStartController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le champ ne doit pas être vide';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: AppStyle.borderRad16,
                  prefixIcon: Icon(Icons.location_on_sharp),
                  labelText: "Adresse de départ",
                ),
                onTap: () {
                  setState(() {
                    selctAdStart = false;
                  });
                },
                onChanged: (value) async {
                  if (value.length >= 3) {
                    final AddressRepository addressRepository =
                        AddressRepository();
                    // Méthode 1
                    List<Address> addresseStart =
                        await addressRepository.fetchAddresses(value);
                    setState(() {
                      _addresseStart = addresseStart;
                    });
                  }
                },
              ),
            ),
            (_adStartController.text.length > 2 && selctAdStart == false)
                ? Expanded(
                    child: ListView.separated(
                      itemCount: _addresseStart.length,
                      itemBuilder: (context, index) {
                        final Address address = _addresseStart[index];
                        return ListTile(
                          title: Text(address.street),
                          subtitle: Text('${address.postcode} ${address.city}'),
                          onTap: () {
                            _adStartController.text =
                                '${address.street}, ${address.city}';
                            latitudeStart = address.latitude;
                            longitudeStart = address.longitude;
                            _calculateDistance();
                            setState(() {
                              selctAdStart = true;
                            });
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(height: 0);
                      },
                    ),
                  )
                : const SizedBox(),
            Container(
              width: largeur / 1.25,
              margin: EdgeInsets.only(
                  left: largeur / 10, top: hauteur / 50, right: largeur / 10),
              child: TextFormField(
                controller: _adEndController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le champ ne doit pas être vide';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: AppStyle.borderRad16,
                  prefixIcon: Icon(Icons.location_on_sharp),
                  labelText: "Adresse de destination",
                ),
                onTap: () {
                  setState(() {
                    selctAdEnd = false;
                  });
                },
                onChanged: (value) async {
                  if (value.length >= 3) {
                    final AddressRepository addressRepository =
                        AddressRepository();
                    // Méthode 1
                    List<Address> addresseEnd =
                        await addressRepository.fetchAddresses(value);
                    setState(() {
                      _addresseEnd = addresseEnd;
                    });
                  }
                },
              ),
            ),
            (_adEndController.text.length > 2 && selctAdEnd == false)
                ? Expanded(
                    child: ListView.separated(
                      itemCount: _addresseEnd.length,
                      itemBuilder: (context, index) {
                        final Address address = _addresseEnd[index];
                        return ListTile(
                          title: Text(address.street),
                          subtitle: Text('${address.postcode} ${address.city}'),
                          onTap: () {
                            _adEndController.text =
                                '${address.street}, ${address.city}';
                            latitudeEnd = address.latitude;
                            longitudeEnd = address.longitude;
                            _calculateDistance();
                            setState(() {
                              selctAdEnd = true;
                            });
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(height: 0);
                      },
                    ),
                  )
                : const SizedBox(),
            selctAdStart && selctAdEnd
                ? Container(
                    width: largeur / 1.25,
                    margin: EdgeInsets.only(
                        left: largeur / 10,
                        top: hauteur / 50,
                        right: largeur / 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Distance (km)',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          distance,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            selctAdStart && selctAdEnd
                ? Container(
                    width: largeur / 1.25,
                    margin: EdgeInsets.only(
                        left: largeur / 10,
                        top: hauteur / 50,
                        right: largeur / 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Prix (euros)',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          price,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            Container(
              width: largeur / 1.25,
              height: incline == false ? hauteur / 15 : hauteur / 10,
              margin: EdgeInsets.only(top: hauteur / 35),
              child: ElevatedButton(
                  onPressed: () {
                    if (_reservationkey.currentState!.validate()) {
                      newReservation();
                    }
                  },
                  child: const Text('Valider et choisir sa date',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primaryColor,
                      ))),
            ),
          ]),
        ),
      ),
    ]));
  }
}
