import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.isFavourite,
    this.qty
  });

  String image;
  String id;
  bool isFavourite;
  String name;
  double price;
  String description;


  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    double parsedPrice = json["price"] != null
        ? double.tryParse(json["price"].toString()) ?? 0.0
        : 0.0;

    return ProductModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      image: json["image"] ?? "",
      isFavourite: false,
      qty: json["qty"],
      price: parsedPrice,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "isFavourite": isFavourite,
        "price": price.toString(), // Convert price to string here.
        "qty": qty,
      };

  @override
  ProductModel copyWith({
  int? qty,
  }) =>
      ProductModel(
       id: id,
      name: name,
      description: description,
      image: image,
      isFavourite: isFavourite,
      qty: qty??this.qty,
      price: price,
      
      );
}
