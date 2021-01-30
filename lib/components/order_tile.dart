import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class OrderTile extends StatelessWidget {
  final orderNo, phone, name, areaCode, quantity, amount, totalPrice;

  OrderTile({
    this.orderNo,
    this.phone,
    this.name,
    this.areaCode,
    this.quantity,
    this.amount,
    this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Order No: " + orderNo.toString(),
                  ),
                  Text(
                    "Phone: " + phone.toString(),
                  )
                ],
              ),
              Container(
                height: 5,
              ),
              Text(
                "Name: " + name.toString(),
              ),
              Container(
                height: 5,
              ),
              Text(
                "Address: " + areaCode.toString(),
              ),
              Container(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Quantity: " + quantity.toString(),
                  ),
                  Text(
                    "Amount: " + amount.toString(),
                  ),
                ],
              ),
              Container(
                height: 5,
              ),
              Text(
                "Total Price: ₹" + totalPrice.toString(),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfPreview(
              build: (format) => _generatePdf(format),
            ),
          ),
        );
      },
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
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
                  "Order No: " + orderNo.toString(),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 3.5,
                  ),
                ),
                pw.Container(
                  height: 0,
                ),
                pw.Text(
                  "Phone: " + phone.toString(),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 3.5,
                  ),
                ),
                pw.Container(
                  height: 0,
                ),
                pw.Text(
                  name.toString(),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 3.5,
                  ),
                ),
                pw.Container(
                  height: 0,
                ),
                pw.Text(
                  areaCode.toString(),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 3.5,
                  ),
                ),
                pw.Container(
                  height: 0,
                ),
                pw.Text(
                  "Quantity: " + quantity.toString(),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 3.5,
                  ),
                ),
                pw.Container(
                  height: 0,
                ),
                pw.Text(
                  "Total Price: Rs." + totalPrice.toString(),
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
    return pdf.save();
  }
}
