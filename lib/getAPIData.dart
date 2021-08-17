import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class getAPIData {
  String x;
  String y;

  getAPIData(this.x, this.y);

  static http.Response? response;
  static Map<String, dynamic>? _jsonResponse;
  String? myvideo;

  Future<Map> getData() async {
    try {
      response = await http.Client()
          .get(Uri.parse(
              'http://a.y.com/generate-video/?input-data1=${x}&secret-key=${y}'))
          .timeout(Duration(minutes: 1));
      print('http://a.y.com/generate-video/?input-data1=${x}&secret-key=${y}');
      if (response!.statusCode == 200) {
        print('Converting to map');
        print(response!.body);
        _jsonResponse = json.decode(response!.body);
        print('GOT JSON RESPONSE: ${_jsonResponse!['video']}');
        myvideo = _jsonResponse!['video'];
        return {
          'status': true,
          'error': null,
          'message': _jsonResponse!['message'],
          'video': _jsonResponse!['video'],
          //'next_page_url': _jsonResponse['next_page_url']
        };
      } else {
        print('JSON RESPONSE ERROR STATUS CODE: ${response!.statusCode}');
        return {
          'status': false,
          'error': response!.statusCode.toString(),
          'data': null
        };
      }
    } on TimeoutException {
      print('TIME EXCEPTION');
      return {'status': false, 'error': 'Connection Timed out', 'data': null};
    } on HandshakeException {
      print('HANDSHAKE EXCEPTION');
      return {'status': false, 'error': 'Connection Error', 'data': null};
    } catch (e) {
      print('Printing Error in API SERVICE');
      print(e);
      return {'status': false, 'error': e.toString(), 'data': null};
    }
  }
}
