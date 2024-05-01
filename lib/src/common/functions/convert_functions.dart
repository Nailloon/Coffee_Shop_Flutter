List returnJsonDataAsList(jsonData) {
  try {
    return jsonData['data'] as List;
  } catch (e) {
    throw Exception(
        'Exception while converting data in the form of a list: $e');
  }
}
