import 'package:flutter/material.dart';
import 'package:tdd_flutter/core/services/http_service.dart';
import 'package:tdd_flutter/home/service/home_service.dart';
import 'package:tdd_flutter/home/viewModel/home_view_model.dart';
import 'package:tdd_flutter/product/cache/home_cache.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final IHomeViewModel homeViewModel;
  final HttpService _httpService = HttpService();

  @override
  void initState() {
    super.initState();
    homeViewModel = HomeViewModel(setState, HomeService(_httpService), HomeCacheShared(null), showScaffoldMessage);
    homeViewModel.fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeViewModel.backgroundColor,
      appBar: AppBar(title: Text(homeViewModel.title ?? "")),
      body: homeViewModel.isLoading 
        ? const CircularProgressIndicator()
        : buildListData(),
    );
  }

  void showScaffoldMessage(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ok')));
  }

  ListView buildListData() {
    return ListView.builder(
      itemCount: homeViewModel.dataList.length,
      itemBuilder: (context, i){
        return ListTile(
          onTap: (){
            homeViewModel.cacheItItem(homeViewModel.dataList[i]);
          },
          leading: CircleAvatar(child: Text(homeViewModel.dataList[i].name?.substring(0,1) ?? "")),
          title: Text(homeViewModel.dataList[i].name ?? ""),
        );
      },
    );
  }
}