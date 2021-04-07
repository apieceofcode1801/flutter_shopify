class Address {
  String id;
  String firstname;
  String lastname;
  String address1;
  String address2;
  String country;
  String countryCodeV2;
  String zip;

  Address.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstname = json["firstname"];
    lastname = json["lastname"];
    address1 = json["address1"];
    address2 = json["address2"];
    country = json["country"];
    countryCodeV2 = json["countryCodeV2"];
    zip = json["zip"];
  }
}
