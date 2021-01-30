import 'package:flutter/material.dart';

class OrderModel {
  var orderNo;
  var phone;
  var name;
  var areaCode;
  var quantity;
  var amount;
  var totalPrice;

  OrderModel({
    this.orderNo,
    this.phone,
    this.name,
    this.areaCode,
    this.quantity,
    this.amount,
    this.totalPrice,
  });

  factory OrderModel.fromJSON(dynamic json) {
    return OrderModel(
      orderNo: "${json['orderNo']}",
      phone: "${json['phone']}",
      name: "${json['name']}",
      areaCode: "${json['areaCode']}",
      quantity: "${json['quantity']}",
      amount: "${json['amount']}",
      totalPrice: "${json['totalPrice']}",
    );
  }

  Map toJson() => {
        "orderNo": orderNo,
        "phone": phone,
        "name": name,
        "areaCode": areaCode,
        "quantity": quantity,
        "amount": amount,
        "totalPrice": totalPrice,
      };
}
