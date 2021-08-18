import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class getAPIData {
  String inputData1;
  String dataModel1;
  String narrationVoice;
  String quality;
  String language;
  String narrationText;
  String secretKey;

  getAPIData(this.inputData1, this.dataModel1, this.narrationVoice,
      this.quality, this.language, this.narrationText, this.secretKey);

  static http.Response? response;
  static Map<String, dynamic>? _jsonResponse;
  String? myvideo;

  Future<Map> getData() async {
    try {
      response = await http.Client()
          .get(Uri.parse(
              'http://api.rivetik.com/rivetik-engine/generate-video/?input-data1=${inputData1}&data-model1=${dataModel1}&narration-voice=${narrationVoice}&quality=${quality}&language=${language}&narration-text=${narrationText}&secret-key=${secretKey}'))
          .timeout(Duration(minutes: 1));
      print(
          'http://api.rivetik.com/rivetik-engine/generate-video/?input-data1=${inputData1}&data-model1=${dataModel1}&narration-voice=${narrationVoice}&quality=${quality}&language=${language}&narration-text=${narrationText}&secret-key=${secretKey}');
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
