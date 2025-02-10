import 'package:edus_project/provider/locator.dart';
import 'package:edus_project/widgets/common_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../model/post_model.dart';
import '../../services/api_service.dart';

class HomeViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  final ApiService _apiService = ApiService();

  ///handel taped index
  int _isTapedIndex = -1;
  int get isTapedIndex => _isTapedIndex;
  void setIsTaped({required int index}) {
    if (index == _isTapedIndex) {
      _isTapedIndex = -1;
    } else {
      _isTapedIndex = index;
    }

    notifyListeners();
  }

  String? _error;

//fetch posts
  Future<void> fetchPosts() async {
    setBusy(true);
    _error = null;
    notifyListeners();

    try {
      customerProvider.setPosts(await _apiService.getPosts());
    } catch (e) {
      _error = e.toString();
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

//delete the post
  Future<void> deletePost(BuildContext context, {required int id}) async {
    setBusy(true);
    _error = null;
    notifyListeners();

    try {
      await _apiService.deletePost(id);
      customerProvider.posts.removeWhere((post) => post.id == id);
      app.showFlashNotification(
          msg: "Delete Successfully", bgColor: colors.blue);
    } catch (e) {
      _error = e.toString();
      app.showFlashNotification(msg: "Try Again", bgColor: colors.red);
    } finally {
      setBusy(false);
    }

    notifyListeners();
  }
}

enum FormEnum { title, body }
