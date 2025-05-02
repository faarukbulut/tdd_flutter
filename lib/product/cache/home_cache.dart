import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_flutter/home/model/home_model.dart';

abstract class IHomeCache {
  Future<bool> saveModel(ReqProfile model);
  Future<ReqProfile?> getModel();
  Future<bool> removeModel();
  Future<ReqProfile?> getModelWithoutExpiry();

  int durationTime = 5;
  IHomeCache({int? durationTime}){
    this.durationTime = durationTime ?? 5;
  }
}

class HomeCacheShared extends IHomeCache{
  SharedPreferences? _prefs;
  HomeCacheShared(int? durationTime) : super(durationTime: durationTime);

  @override
  Future<ReqProfile?> getModel() async{
    _prefs = await SharedPreferences.getInstance();
    final modelValues = _prefs?.getString(runtimeType.toString());

    if(modelValues == null) return null;

    final jsonBody = jsonDecode(modelValues);
    return ReqProfile.fromJson(jsonBody);
  }

  @override
  Future<bool> saveModel(ReqProfile model) async{
    _prefs = await SharedPreferences.getInstance();

    model.expiryTime = DateTime.now().add(Duration(milliseconds: durationTime)).toIso8601String();
    final modelValues = jsonEncode(model);
    return await _prefs?.setString(runtimeType.toString(), modelValues) ?? false;
  }
  
  @override
  Future<bool> removeModel() async{
    _prefs = await SharedPreferences.getInstance();
    return await _prefs?.remove(runtimeType.toString()) ?? false;
  }
  
  @override
  Future<ReqProfile?> getModelWithoutExpiry()  async{
    final data = await getModel();
    
    if(data != null)
    {
      return data.isExpiry() ? null : data;
    }

    return null;
  }
  
}