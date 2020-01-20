import 'package:billstore/model/Contact.dart';

import 'EstimateProducts.dart';

class Estimate
{
  int id;
  Contact contact;
  String invoiceNumber;
  double total;
  List<EstimateProducts> estimateProducts;

  Estimate(
      {this.id,
        this.contact,
        this.invoiceNumber,
        this.total,
        this.estimateProducts});

  Estimate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contact =
    json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    invoiceNumber = json['invoice_number'];
    total = json['total'];
    if (json['estimateProducts'] != null) {
      estimateProducts = new List<EstimateProducts>();
      json['estimateProducts'].forEach((v) {
        estimateProducts.add(new EstimateProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.contact != null) {
      data['contact'] = this.contact.toJson();
    }
    data['invoice_number'] = this.invoiceNumber;
    data['total'] = this.total;
    if (this.estimateProducts != null) {
      data['estimateProducts'] =
          this.estimateProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }

}