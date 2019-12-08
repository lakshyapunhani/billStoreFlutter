class User{
  final String name;
  final int id;
  final String username;
  final String address;
  final String email;

  User(this.name, this.id,this.username,this.address,this.email);

  User.fromJson(Map<String, dynamic> json):
        name = json['name'],
        id = json['id'],
        username = json['username'],
        address = json['address'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'username':username,
    'address':address,
    'email':email
  };
}