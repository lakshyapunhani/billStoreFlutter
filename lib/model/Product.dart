class Product
{
  String name;
  int id;
  double rate;
  String description;
  int quantity;

  Product(this.name,this.id,this.rate,this.description,this.quantity);

  Product.fromJson(Map<String,dynamic> map)
  {
    this.name = map['name'];
    this.id = map['id'];
    this.rate = map['rate'];
    this.description = map['description'];
    this.quantity = map['quantity'];
  }

  Map<String,dynamic> toJson() => {
    'name':name,
    'id':id,
    'rate':rate,
    'description':description,
    'quantity':quantity
  };
}