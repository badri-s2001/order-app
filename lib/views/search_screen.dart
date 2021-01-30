import 'package:flutter/material.dart';
import 'package:order_app/views/phone_no_search_screen.dart';

import '../order_model.dart';
import 'order_no_search_screen.dart';

class SearchScreen extends StatelessWidget {
  final List<OrderModel> orders;

  SearchScreen({@required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderNoSearchScreen(
                    orders: orders,
                  ),
                ),
              );
            },
            child: Text(
              "Order No Search",
            ),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhoneNoSearchScreen(
                    orders: orders,
                  ),
                ),
              );
            },
            child: Text(
              "Phone No Search",
            ),
          ),
        ],
      ),
    );
  }
}
