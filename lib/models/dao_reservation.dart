class DAOReservation {
  int idReservation = 0;
  DateTime date = DateTime.utc(2000, 00, 00);
  String adStart = "";
  String adEnd = "";
  String distance = "";
  String price = "";
  int idUser = 0;

  /* Constructeur */
  DAOReservation(
      {required this.idUser,
      required this.idReservation,
      required this.adStart,
      required this.adEnd,
      required this.date,
      required this.distance,
      required this.price});

  factory DAOReservation.fromJson(Map<String, dynamic> json) {
    return DAOReservation(
        idUser: json['idUser'],
        idReservation: json['idReservation'],
        adStart: json['adStart'],
        adEnd: json['adEnd'],
        date: DateTime.parse(json['date']),
        distance: json['distance'],
        price: json['price']);
  }

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'idReservation': idReservation,
        'adStart': adStart,
        'adEnd': adEnd,
        'date': date,
        'distance': distance,
        'price': price
      };

  /* Getters and setters */
  // ignore_for_file: unused_element

  int get iduser => idUser;

  set iduser(value) => idUser = value;

  get _idReservation => idReservation;

  set _idReservation(value) => idReservation = value;

  get _adStart => adStart;

  set _adStart(value) => adStart = value;

  get _adEnd => adEnd;

  set _adEnd(value) => adEnd = value;

  get _date => date;

  set _date(value) => date = value;
}
