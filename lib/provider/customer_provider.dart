import 'package:edus_project/model/post_model.dart';
import 'package:flutter/material.dart';

class CustomerProvider extends ChangeNotifier {
  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;
  setPosts(List<PostModel> value) {
    _posts = value;
    notifyListeners();
  }
}
