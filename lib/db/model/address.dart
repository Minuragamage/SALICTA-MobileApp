class Address {

  String address;
  String city;
  String zipCode;
  String district;

  Address({
    required this.address,
    required this.city,
    required this.district,
    required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      city: json['city'],
      zipCode: json['zipCode'],
      district: json['district'],
    );
  }

  String displayAddress() {
    return "$address,";
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "city": city,
      "zipCode": zipCode,
      "district": district
    };
  }
}
