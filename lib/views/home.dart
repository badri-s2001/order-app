import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:order_app/components/order_tile.dart';
import 'package:order_app/order_model.dart';
import 'package:order_app/views/search_screen.dart';
import 'dart:convert' as convert;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<OrderModel> orders = List<OrderModel>();

  Future<void> getOrderFromSheet() async {
    var response = await http.get(
        "enter google sheet link here");

    orders.clear();

    var jsonOrder = convert.jsonDecode(response.body);

    jsonOrder.forEach((element) {
      OrderModel orderModel = new OrderModel();
      orderModel.orderNo = element['orderNo'];
      orderModel.phone = element['phone'];
      orderModel.name = element['name'];
      orderModel.areaCode = element['areaCode'];
      orderModel.quantity = element['quantity'];
      orderModel.amount = element['amount'];
      orderModel.totalPrice = element['totalPrice'];

      orders.add(orderModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOrderFromSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders",
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    orders: orders,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.print,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfPreview(
                    build: (format) => _generatePdf(format),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return OrderTile(
                orderNo: orders[index].orderNo,
                phone: orders[index].phone,
                name: orders[index].name,
                areaCode: orders[index].areaCode,
                quantity: orders[index].quantity,
                amount: orders[index].amount,
                totalPrice: orders[index].totalPrice,
              );
            },
          ),
          onRefresh: getOrderFromSheet,
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    for (int index = 0; index < orders.length; index++) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat(
            2.54 * PdfPageFormat.cm,
            5 * PdfPageFormat.cm,
            marginLeft: 4.5,
            marginBottom: 3,
            marginTop: 3,
          ),
          build: (context) {
            return pw.Center(
              child: pw.Column(
                children: [
                  pw.Text(
                    "Order No: " + orders[index].orderNo.toString(),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 3.5,
                    ),
                  ),
                  pw.Container(
                    height: 0,
                  ),
                  pw.Text(
                    "Phone: " + orders[index].phone.toString(),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 3.5,
                    ),
                  ),
                  pw.Container(
                    height: 0,
                  ),
                  pw.Text(
                    orders[index].name.toString(),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 3.5,
                    ),
                  ),
                  pw.Container(
                    height: 0,
                  ),
                  pw.Text(
                    orders[index].areaCode.toString(),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 3.5,
                    ),
                  ),
                  pw.Container(
                    height: 0,
                  ),
                  pw.Text(
                    "Quantity: " + orders[index].quantity.toString(),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 3.5,
                    ),
                  ),
                  pw.Container(
                    height: 0,
                  ),
                  pw.Text(
                    "Total Price: Rs." + orders[index].totalPrice.toString(),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 3.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    return pdf.save();
  }
}
