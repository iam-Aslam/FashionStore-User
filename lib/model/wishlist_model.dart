class Wishlist {
  final String? id;
  final String? productId;
  final String? email;

  Wishlist.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          productId: json['productid']! as String,
          email: json['email']! as String,
        );
  Wishlist({
    this.id,
    required this.productId,
    required this.email,
  });
}
