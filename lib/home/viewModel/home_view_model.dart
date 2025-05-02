import 'package:flutter/material.dart';
import 'package:tdd_flutter/home/model/home_model.dart';
import 'package:tdd_flutter/home/service/home_service.dart';
import 'package:tdd_flutter/product/cache/home_cache.dart';

typedef UIUpdate = void Function(VoidCallback fn);
typedef SnackBarShow = void Function();

abstract class IHomeViewModel{
  final UIUpdate viewUpdate;
  final SnackBarShow snackBarShow;
  IHomeService homeService;
  IHomeCache homeCache;

  Color? backgroundColor = Colors.white;
  void changeColor(Color color);

  bool isLoading = true;
  void changeLoading();

  List<ReqProfile> dataList = [];
  void fetchAllData();

  String? title;
  void initCacheData();

  Future<void> cacheItItem(ReqProfile profile);

  IHomeViewModel(this.viewUpdate, this.homeService, this.homeCache, this.snackBarShow);
}

class HomeViewModel extends IHomeViewModel{
  HomeViewModel(super.viewUpdate, super.homeService, super.homeCache, super.snackBarShow){
    initCacheData();
  }
  
  @override
  void changeColor(Color color){
    backgroundColor = color;
    viewUpdate((){});
  }

  @override
  void changeLoading(){
    isLoading = !isLoading;
    viewUpdate((){});
  }
  
  @override
  Future<void> fetchAllData() async{
    final data = await homeService.getAllItems();
    if(data != null)
    {
      dataList = data;
    }

    changeLoading();
  }
  
  @override
  Future<void> initCacheData() async{
    final data = await homeCache.getModelWithoutExpiry();

    if(data != null)
    {
      title = "${data.name} - ${data.username}";
      viewUpdate((){});
    }
  }
  
  @override
  Future<void> cacheItItem(ReqProfile profile) async{
    if(await homeCache.saveModel(profile)){
      title = profile.name;
      snackBarShow();
      viewUpdate((){});
    }
  }

}