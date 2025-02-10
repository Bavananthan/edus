import 'package:edus_project/common/asserts.dart';
import 'package:edus_project/provider/locator.dart';
import 'package:edus_project/screen/form_view/form_view.dart';
import 'package:edus_project/screen/home_view/widget/post_card.dart';
import 'package:edus_project/widgets/common_dialog.dart';
import 'package:edus_project/widgets/common_header.dart';
import 'package:edus_project/widgets/common_loader.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) {
        model.fetchPosts();
      },
      builder: (context, model, child) {
        return Scaffold(
          body: Column(children: [
            const CommonHeader(
              title: "EDUS",
              isPop: false,
            ),
            Expanded(
                child: RefreshIndicator(
              onRefresh: () => model.fetchPosts(),
              child: model.isBusy
                  ? const CommonLoader(animationPath: animation)
                  : customerProvider.posts.isEmpty
                      ? const Center(
                          child: Text('No posts available'),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => model.setIsTaped(index: index),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, left: 15),
                                child: PostCard(
                                    onUpdate: () {
                                      CommonDialog.show(
                                              context: context,
                                              title: "Confirm Update",
                                              message:
                                                  "Are you sure you want to Update this post?")
                                          .then(
                                        (value) {
                                          if (value == true) {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) => PostForm(
                                                isUpdate: true,
                                                post: customerProvider
                                                    .posts[index],
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                    onDelete: () {
                                      CommonDialog.show(
                                              context: context,
                                              message:
                                                  "Are you sure you want to delete this Post?",
                                              title: "Confirm Delete")
                                          .then(
                                        (value) {
                                          if (value == true) {
                                            model.deletePost(context,
                                                id: customerProvider
                                                    .posts[index].id);
                                          }
                                        },
                                      );
                                    },
                                    isTapped: model.isTapedIndex == index
                                        ? true
                                        : false,
                                    title: customerProvider.posts[index].title,
                                    subtitle:
                                        customerProvider.posts[index].body),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: customerProvider.posts.length),
            ))
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const PostForm(),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
