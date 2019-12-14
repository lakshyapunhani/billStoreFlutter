class Contact{
  final String name;
  final int id;
  final String username;
  final String address;
  final String email;
  final String gstNumber;

  Contact(this.name, this.id,this.username,this.address,this.email,this.gstNumber);

  Contact.fromJson(Map<String, dynamic> json):
        name = json['name'],
        id = json['id'],
        username = json['username'],
        address = json['address'],
        email = json['email'],
        gstNumber = json['gstNumber'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'username':username,
    'address':address,
    'email':email,
    'gstNumber':gstNumber
  };
}