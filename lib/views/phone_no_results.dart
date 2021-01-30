import 'package:flutter/material.dart';
import 'package:order_app/components/order_tile.dart';

import '../order_model.dart';

class PhoneNoResults extends StatelessWidget {
  final phoneNo;
  final List<OrderModel> orders;

  PhoneNoResults({@required this.phoneNo, @required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Phone No Results",
        ),
      ),
      body: Container(
        child: Column(
          children: [
            for (int index = 0; index < orders.length; index++)
              if (phoneNo.toString() == orders[index].phone.toString())
                new OrderTile(
                  orderNo: orders[index].orderNo,
                  phone: orders[index].phone,
                  name: orders[index].name,
                  areaCode: orders[index].areaCode,
                  quantity: orders[index].quantity,
                  amount: orders[index].amount,
                  totalPrice: orders[index].totalPrice,
                ),
          ],
        ),
      ),
    );
  }
}
