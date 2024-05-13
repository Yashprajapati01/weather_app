import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    var uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      var decodedData = jsonDecode(response.body);
      return decodedData; // Return decoded data directly
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data');
    }
  }
}
