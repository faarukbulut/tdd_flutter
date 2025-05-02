import 'package:http/http.dart' as http;

class HttpService{
  Future<http.Response> get({required String url}) async{
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }


  
}