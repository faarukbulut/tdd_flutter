import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_flutter/home/model/home_model.dart';
import 'package:tdd_flutter/product/cache/home_cache.dart';

void main(){
  late IHomeCache homeCache;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    homeCache = HomeCacheShared(10);
  });

  test('Cache It Sample', () async{
    final model = ReqProfile(email: 'a', name: 'v', username: 'b');
    final result = await homeCache.saveModel(model);

    expect(result, isTrue);
  });

  test('Cache It Get', () async{
    final model = ReqProfile(email: 'a', name: 'v', username: 'b');
    await homeCache.saveModel(model);
    final modelCache = await homeCache.getModel();

    expect(modelCache == model, isTrue);
  });

  test('Cache It With Expiry True', () async{
    final model = ReqProfile(email: 'a', name: 'v', username: 'b');
    await homeCache.saveModel(model);
    final modelCache = await homeCache.getModelWithoutExpiry();

    expect(modelCache == model, isTrue);
  });

  test('Cache It With Expiry Null', () async{
    final model = ReqProfile(email: 'a', name: 'v', username: 'b');
    await homeCache.saveModel(model);
    await Future.delayed(Duration(milliseconds: 11));
    final modelCache = await homeCache.getModelWithoutExpiry();

    expect(modelCache == null, isTrue);
  });


}