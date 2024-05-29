import 'dart:convert';

import 'package:coffee_shop/src/common/functions/exception_functions.dart';
import 'package:coffee_shop/src/common/network/data_sources/order_data_source/interface_order_data_source.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderDataSource implements IOrderDataSource {
  final String baseUrl = 'coffeeshop.academy.effective.band';
  final String apiVersion = '/api/v1/products';
  final String orderVersion = 'api/v1/orders';
  final Duration durationForSmallRequest = const Duration(milliseconds: 500);
  final http.Client client;
  OrderDataSource(this.client);
  @override
  Future<bool> postOrder(Map<String, int> orderData) async {
    debugPrint(orderData.toString());
    try {
      final fCMToken = await FirebaseMessaging.instance.getToken();
      Map<String, dynamic> requestBody = {
        'positions': orderData,
        'token': fCMToken,
      };

      var url = Uri.https(
        baseUrl,
        orderVersion,
      );
      final response = await client
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(requestBody),
          )
          .timeout(durationForSmallRequest);

      if (response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 422) {
        throw Exception('Validation Error');
      } else {
        return false;
      }
    } on Exception catch (e) {
      noInternet(e);
      rethrow;
    }
  }
}
