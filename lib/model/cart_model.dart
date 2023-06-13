class Cart {
  final String? id;
  final String? productId;
  final int? price;
  final int? totalPrice;
  final int? quantity;
  final String? color;
  final String? email;
  final String? size;
  Cart.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          color: json['color']! as String,
          productId: json['productid']! as String,
          quantity: json['quantity']! as int,
          totalPrice: json['totalprice']! as int,
          price: json['price']! as int,
          email: json['email']! as String,
          size: json['size']! as String,
        );
  Cart({
    this.id,
    required this.productId,
    required this.price,
    required this.totalPrice,
    required this.quantity,
    this.color = "Black",
    required this.email,
    required this.size,
  });
}
