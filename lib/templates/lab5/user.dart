import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// TODO add dependencies

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class Address with _$Address {
  factory Address({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
    required Geo geo,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}

@freezed
class Geo with _$Geo {
  factory Geo({
    required String lat,
    required String lng,
  }) = _Geo;

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
}

@freezed
class Company with _$Company {
  factory Company({
    required String name,
    required String catchPhrase,
    required String bs,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
}

@freezed
class User with _$User {
  factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    required Address address,
    required String phone,
    required String website,
    required Company company,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

Future<List<User>> fetchUsers() async {

  final url = Uri.parse("http://jsonplaceholder.typicode.com/users/");
  final response = await http.get(url);

  if(response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception("Failed to load users");
  }
}
