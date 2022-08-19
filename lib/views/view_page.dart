import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pagination/models/user_model.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  Future<UserModel> fetchData({int page = 1, bool loadMore = false}) async {
    try {
      final data = await Dio().get("https://reqres.in/api/users?page=$page");
      final UserModel userModel = UserModel.fromMap(data.data);
      setState(() {
        loadMore
            ? userDataModel = userDataModel!.copyWith(
                page: userModel.page,
                totalPages: userModel.totalPages,
                users: [...userDataModel!.users, ...userModel.users])
            : userDataModel = userModel;
      });
      return userModel;
    } on DioError catch (e) {
      if (e.response == null) {
        throw SocketException(e.message);
      } else {
        throw Exception(e.error);
      }
    }
  }

  UserModel? userDataModel;
  bool loading = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Views Page"),
      ),
      body: userDataModel == null
          ? const Center(
              child: Text("...loading"),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ...userDataModel!.users.map(
                    (e) => ListTile(
                      leading: Image.network(e.avatar),
                      title: Text(e.email),
                    ),
                  ),
                  if (userDataModel!.page != userDataModel!.totalPages)
                    loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              await fetchData(
                                page: userDataModel!.page + 1,
                                loadMore: true,
                              );
                              loading = false;
                            },
                            child: const Text("LoadMore"))
                ],
              ),
            ),
    );
  }
}
