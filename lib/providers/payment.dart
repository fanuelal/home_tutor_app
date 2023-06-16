import 'package:chapasdk/chapasdk.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class Payment extends ChangeNotifier {
  var uuid = Uuid();

  Future<void> paymentFunc(
      BuildContext context, String email, double price) async {
    var headers = {
      'Authorization': 'Bearer CHAPUBK_TEST-CML0L28FwYOyTISmaWF2XCfCP8zXsRIM',
      'Content-Type': 'application/json'
    };
    // var request = http.Request( CHASECK_TEST-0tsiGl5e4zVggZiYefAJ5uO5DtTMxyYV
    //     'POST', Uri.parse('https://api.chapa.co/v1/transaction/initialize'));
    final body = json.encode({
      "amount": price.toString(),
      "currency": "ETB",
      "email": "$email",
      "first_name": "Our",
      "last_name": "Client",
      "phone_number": "0912345678",
      "tx_ref": "hometutor-${uuid.v1()}",
      "callback_url":
          "https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60",
      "customization[title]": "Payment for my home tutor teacher",
      "customization[description]": "i am paying for Home tutor!"
    });
    final _response = await http
        .post(Uri.parse('https://api.chapa.co/v1/transaction/initialize'),
            body: body,
            headers: headers)
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
      await launchUrl(parsedUrl,
      
      );
    }else 
      throw Exception('Could not launch $_url');
  }
}
