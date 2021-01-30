import 'package:flutter/material.dart';
import 'package:order_app/views/phone_no_results.dart';

import '../order_model.dart';

class PhoneNoSearchScreen extends StatefulWidget {
  final List<OrderModel> orders;

  PhoneNoSearchScreen({@required this.orders});

  @override
  _PhoneNoSearchScreenState createState() =>
      _PhoneNoSearchScreenState(orders: orders);
}

class _PhoneNoSearchScreenState extends State<PhoneNoSearchScreen> {
  final List<OrderModel> orders;
  _PhoneNoSearchScreenState({@required this.orders});

  var phoneNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Phone No Search",
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
                      phoneNo = value;
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
                          builder: (context) => PhoneNoResults(
                            phoneNo: phoneNo,
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
