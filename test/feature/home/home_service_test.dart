import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_flutter/core/services/http_service.dart';
import 'package:tdd_flutter/home/model/home_model.dart';
import 'package:tdd_flutter/home/service/home_service.dart';

void main(){
  late HttpService httpService;
  late IHomeService homeService;

  setUp(() {
    httpService = HttpService();
    homeService = HomeService(httpService);
  });

  test('Get All List Data', () async {
    final response = await httpService.get(url: 'https://jsonplaceholder.typicode.com/users');
    final List<ReqProfile> listData = reqProfileFromJson(response.body);

    expect(listData, isNotNull);
  });

  test('Get All List Manager', () async {
    final listData = await homeService.getAllItems();

    expect(listData, isNotNull);
  });


}