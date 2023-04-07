class Address {
  final String street;
  final String city;
  final String postcode;
  final double latitude;
  final double longitude;

  Address(this.street, this.city, this.postcode, this.latitude, this.longitude);

  factory Address.fromGeoJson(Map<String, dynamic> json) {
    final Map<String, dynamic> properties = json['properties'] ?? {};
    final coordinates = json['geometry']['coordinates'] ?? {};
    final String street = properties['name'];
    final String postcode = properties['postcode'];
    final String city = properties['city'];
    final double latitude = coordinates[1];
    final double longitude = coordinates[0];

    return Address(street, postcode, city, latitude, longitude);
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'postcode': postcode,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        json['street'], json['city'], json['postcode'], json['x'], json['y']);
  }
}
