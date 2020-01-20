import 'Product.dart';

class EstimateProducts {
  Product product;
  int quantity;

  EstimateProducts({this.product, this.quantity});

  EstimateProducts.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}