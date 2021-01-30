import 'package:flutter/material.dart';
import 'package:order_app/components/order_tile.dart';

import '../order_model.dart';

class OrderNoResults extends StatelessWidget {
  final orderNo;
  final List<OrderModel> orders;

  OrderNoResults({@required this.orderNo, @required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order No Results",
        ),
      ),
      body: Container(
        child: Column(
          children: [
            for (int index = 0; index < orders.length; index++)
              if (orderNo.toString() == orders[index].orderNo.toString())
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
