class Product{
  String? name;
  String? userName;
  String? image;
  String? calification;
  Product({
    this.name,
    this.userName,
    this.image,
    this.calification
  });

  Product.fromJson(Map<String, dynamic> json){
    name = json["name"];
    userName = json["userName"];
    image = json["image"];
    calification = json["calification"];
  }
}