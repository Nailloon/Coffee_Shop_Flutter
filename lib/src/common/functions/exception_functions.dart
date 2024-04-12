import 'dart:async';
import 'dart:io';

const SocketException socketException =
    SocketException('Failed to connect to api');

void noInternet(Exception e) {
  if (e is TimeoutException || e is SocketException) {
    throw socketException;
  }
}
