class Address {
  final String? id;
  final String? name;
  final int? pinCode;
  final String? permanentAddress;
  final String? state;
  final String? city;
  final int? phone;
  final String? email;

  Address.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          name: json['name']! as String,
          pinCode: json['pincode']! as int,
          permanentAddress: json['address']! as String,
          state: json['state']! as String,
          city: json['city']! as String,
          email: json['email']! as String,
          phone: json['phone']! as int,
        );

  Address({
    required this.id,
    required this.name,
    required this.pinCode,
    required this.permanentAddress,
    required this.state,
    required this.city,
    required this.phone,
    required this.email,
  });
}
