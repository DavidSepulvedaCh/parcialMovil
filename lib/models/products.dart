class Product{
  String? id;
  String? name;
  String? description;
  String? photo;
  double? price;

  Product({
    this.id,
    this.name,
    this.description,
    this.photo,
    this.price
  });

  Product.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    name = json["name"];
    description = json["description"];
    photo = json["photo"];
    price = json["price"].toDouble();
  }
}