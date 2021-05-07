class Address {
  String id = "";
  String? firstname;
  String? lastname;
  String? address1;
  String? address2;
  String? country;
  String? countryCodeV2;
  String? zip;

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

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "firstname": this.firstname,
      "lastname": this.lastname,
      "address1": this.address1,
      "address2": this.address2,
      "country": this.country,
      "countryCodeV2": this.countryCodeV2,
      "zip": this.zip
    };
  }
}
