import 'package:chapasdk/chapasdk.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../models/student.dart';

class Payment extends ChangeNotifier {
  var uuid = Uuid();

  Future<void> paymentFunc(
      BuildContext context, Student student, double price) async {
    var headers = {
      'Authorization': 'Bearer CHASECK_TEST-0tsiGl5e4zVggZiYefAJ5uO5DtTMxyYV',
      'Content-Type': 'application/json'
    };

    final body = json.encode({
      "amount": price.toString(),
      "currency": "ETB",
      "email": "${student.email}",
      "first_name": "Our",
      "last_name": "Client",
      "phone_number": "${student.phone}",
      "tx_ref": "hometutor-${uuid.v1()}",
      "callback_url":
          "https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60",
      "customization[title]": "Payment for my home tutor teacher",
      "customization[description]": "i am paying for Home tutor!"
    });
    final _response = await http
        .post(Uri.parse('https://api.chapa.co/v1/transaction/initialize'),
            body: body, headers: headers)
        .then((response) {
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(responseData['data']['checkout_url']);
        _launchUrl(responseData['data']['checkout_url']);
        print(response);
      } else {
        print(response.reasonPhrase);
      }
    });
  }

  Future<void> _launchUrl(String _url) async {
    final parsedUrl = Uri.parse(_url);
    if (await canLaunchUrl(parsedUrl)) {
      await launchUrl(
        parsedUrl,
      );
    } else
      throw Exception('Could not launch $_url');
  }
}
