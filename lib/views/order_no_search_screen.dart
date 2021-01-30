import 'package:flutter/material.dart';
import 'package:order_app/views/order_no_results.dart';

import '../order_model.dart';

class OrderNoSearchScreen extends StatefulWidget {
  final List<OrderModel> orders;

  OrderNoSearchScreen({@required this.orders});

  @override
  _OrderNoSearchScreenState createState() =>
      _OrderNoSearchScreenState(orders: orders);
}

class _OrderNoSearchScreenState extends State<OrderNoSearchScreen> {
  final List<OrderModel> orders;
  _OrderNoSearchScreenState({@required this.orders});

  var orderNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order No Search",
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      orderNo = value;
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Icon(
                      Icons.search,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderNoResults(
                            orderNo: orderNo,
                            orders: orders,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
