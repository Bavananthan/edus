import 'package:edus_project/model/post_model.dart';
import 'package:edus_project/provider/locator.dart';
import 'package:edus_project/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FormPostViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  final ApiService _apiService = ApiService();
  late PostModel postModel;
  //update form datas
  updateForm({PostModel? post}) {
    postData.id = post?.id;
    postData.title = post?.title;
    postData.body = post?.body;
    titleController.text = post!.title;
    bodyController.text = post.body;
    notifyListeners();
  }

//create post
  Future<void> createPost(BuildContext context) async {
    setBusy(true);

    notifyListeners();

    try {
      final newPost = await _apiService.createPost(
          postData.title ?? "", postData.body ?? "");
      customerProvider.posts.insert(0, newPost);
      app.showFlashNotification(
          msg: "Successfully created", bgColor: colors.blue);
      notifyListeners();
    } catch (e) {
      app.showFlashNotification(msg: "Try Again", bgColor: colors.red);
    } finally {
      setBusy(false);

      Navigator.pop(context);
    }
  }

  FormData formData = FormData();
  FormData get postData => formData;
//update post
  Future<void> updatePost(
    BuildContext context,
  ) async {
    setBusy(true);

    try {
      await _apiService.updatePost(formData).then(
        (value) {
          final index =
              customerProvider.posts.indexWhere((p) => p.id == formData.id);
          if (index != -1) {
            customerProvider.posts[index] = value;
            notifyListeners();
            app.showFlashNotification(
                msg: "Update Successfully", bgColor: colors.blue);
          }
        },
      );
    } catch (e) {
      app.showFlashNotification(msg: "Try Again", bgColor: colors.red);
      print(e.toString());
    } finally {
      setBusy(false);
      Navigator.pop(context);
    }

    notifyListeners();
  }

  void onTextChange(value, FormEnum type) {
    if (type == FormEnum.title) {
      postData.title = value.trim();
    } else if (type == FormEnum.body) {
      postData.body = value.trim();
    }
    notifyListeners();
  }

  //validate
  String? onValidation(value, FormEnum type) {
    if (type == FormEnum.title) {
      return validation.validateName(value.trim());
    } else if (type == FormEnum.body) {
      return validation.validateName(value);
    }
    notifyListeners();
    return null;
  }
}

enum FormEnum { title, body }

class FormData {
  int? id;
  String? title;
  String? body;
  FormData({this.title, this.body, this.id});
}
