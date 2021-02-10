import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:order_app/components/order_tile.dart';
import 'package:order_app/order_model.dart';
import 'package:order_app/views/ordercount_screen.dart';
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
  var itemName1,
      itemName2,
      itemName3,
      itemName4,
      itemName5,
      itemName6,
      itemName7,
      itemName8,
      item1Count,
      item2Count,
      item3Count,
      item4Count,
      item5Count,
      item6Count,
      item7Count,
      item8Count;

  Future<void> getOrderFromSheet() async {
    var response = await http.get(
        "https://script.google.com/macros/s/AKfycbxg4j--irM3PqV9YNo1Y_0sDaO2IJpLd5mwc6jpOEIlNBY-2k2zXwzX/exec");

    orders.clear();

    var jsonResponse = convert.jsonDecode(response.body);

    var jsonOrder = jsonResponse["data"];

    itemName1 = jsonResponse["itemname1"].toString();
    item1Count = jsonResponse["item1count"].toString();

    itemName2 = jsonResponse["itemname2"].toString();
    item2Count = jsonResponse["item2count"].toString();

    itemName3 = jsonResponse["itemname3"].toString();
    item3Count = jsonResponse["item3count"].toString();

    itemName4 = jsonResponse["itemname4"].toString();
    item4Count = jsonResponse["item4count"].toString();

    itemName5 = jsonResponse["itemname5"].toString();
    item5Count = jsonResponse["item5count"].toString();

    itemName6 = jsonResponse["itemname6"].toString();
    item6Count = jsonResponse["item6count"].toString();

    itemName7 = jsonResponse["itemname7"].toString();
    item7Count = jsonResponse["item7count"].toString();

    itemName8 = jsonResponse["itemname8"].toString();
    item8Count = jsonResponse["item8count"].toString();

    jsonOrder.forEach((element) {
      OrderModel orderModel = new OrderModel();
      orderModel.orderNo = element['orderNo'];
      orderModel.phone = element['phone'];
      orderModel.name = element['name'];
      orderModel.areaCode = element['areaCode'];
      orderModel.quantity = element['quantity'];
      orderModel.amount = element['amount'];
      orderModel.totalPrice = element['totalPrice'];

      if (orderModel.orderNo != null &&
          orderModel.phone != "" &&
          orderModel.name != "" &&
          orderModel.areaCode != "" &&
          orderModel.quantity != 0 &&
          orderModel.amount != 0 &&
          orderModel.totalPrice != null) orders.add(orderModel);
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
              Icons.list_alt,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderCountScreen(
                    itemName1: itemName1,
                    item1Count: item1Count,
                    itemName2: itemName2,
                    item2Count: item2Count,
                    itemName3: itemName3,
                    item3Count: item3Count,
                    itemName4: itemName4,
                    item4Count: item4Count,
                    itemName5: itemName5,
                    item5Count: item5Count,
                    itemName6: itemName6,
                    item6Count: item6Count,
                    itemName7: itemName7,
                    item7Count: item7Count,
                    itemName8: itemName8,
                    item8Count: item8Count,
                  ),
                ),
              );
            },
          ),
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
          ),
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
