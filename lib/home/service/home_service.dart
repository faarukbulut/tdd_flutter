import 'package:tdd_flutter/core/services/http_service.dart';
import 'package:tdd_flutter/home/model/home_model.dart';

abstract class IHomeService{
  final HttpService httpService;

  IHomeService(this.httpService);

  Future<List<ReqProfile>?> getAllItems();
}

class HomeService extends IHomeService{
  HomeService(super.httpService);

  @override
  Future<List<ReqProfile>?> getAllItems() async{
    final response = await httpService.get(url: 'https://jsonplaceholder.typicode.com/users');
    return reqProfileFromJson(response.body);
  }






}