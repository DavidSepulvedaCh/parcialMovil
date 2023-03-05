class Product{
  String? name;
  String? description;
  String? photo;
  double? price;
  Product({
    this.name,
    this.description,
    this.photo,
    this.price
  });

  Product.fromJson(Map<String, dynamic> json){
    name = json["name"];
    description = json["description"];
    photo = json["photo"];
    price = json["price"];
  }
}