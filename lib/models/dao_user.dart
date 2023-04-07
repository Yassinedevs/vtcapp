// Class User
class DAOUser {
  int idUser = 0;
  String name = "";
  String firstname = "";
  String email = "";
  String password = "";

  /* Constructeur */
  DAOUser(
      {required this.idUser,
      required this.name,
      required this.firstname,
      required this.email,
      required this.password});

  factory DAOUser.fromJson(Map<String, dynamic> json) {
    return DAOUser(
      idUser: json['idUser'],
      name: json['name'],
      firstname: json['firstname'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'firstname': firstname,
        'email': email,
        'password': password,
      };

  /* Getters and setters */
  // ignore_for_file: unused_element

  int get iduser => idUser;

  set iduser(value) => idUser = value;

  get _name => name;

  set _name(value) => name = value;

  get _firstname => firstname;

  set _firstname(value) => firstname = value;

  get _email => email;

  set _email(value) => email = value;

  get _password => password;

  set _password(value) => password = value;
}
