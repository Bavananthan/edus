import 'dart:convert';
import 'package:edus_project/provider/locator.dart';
import 'package:edus_project/screen/form_view/form_view_model.dart';
import 'package:edus_project/screen/home_view/home_view_model.dart';
import 'package:http/http.dart' as http;

import '../model/post_model.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<PostModel> createPost(String title, String body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': title,
          'body': body,
          'userId': 1,
        }),
      );
      if (response.statusCode == 201) {
        return PostModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create post');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<PostModel> updatePost(FormData post) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/posts/${post.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': post.title,
          'body': post.body,
          'userId': 1,
          'id': post.id
        }),
      );
      app.printStatement(response);
      if (response.statusCode == 200) {
        return PostModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update post');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<void> deletePost(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/posts/$id'));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete post');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
