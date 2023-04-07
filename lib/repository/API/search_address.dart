import 'dart:convert';

import 'package:http/http.dart';

import '../../models/address.dart';

class AddressRepository {
  Future<List<Address>> fetchAddresses(String query) async {
    final Response response = await get(
        Uri.parse('https://api-adresse.data.gouv.fr/search?q=$query'));
    if (response.statusCode == 200) {
      final List<Address> addresses = []; // Liste que la méthode va renvoyer

      // Transformation du JSON (String) en Map<String, dynamic>
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey("features")) {
        // Récupération des "features"
        final List<dynamic> features = json['features'];

        // Transformation de chaque "feature" en objet de type "Address"
        for (Map<String, dynamic> feature in features) {
          final Address address = Address.fromGeoJson(feature);
          addresses.add(address);
        }
      }
      return addresses;
    } else {
      throw Exception('Failed to load addresses');
    }
  }
}
