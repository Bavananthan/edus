import 'package:edus_project/provider/locator.dart';
import 'package:edus_project/screen/form_view/form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../model/post_model.dart';
import '../../../widgets/common_button.dart';

class PostForm extends StatelessWidget {
  final PostModel? post;
  final bool isUpdate;

  const PostForm({Key? key, this.post, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FormPostViewModel>.reactive(
      viewModelBuilder: () => FormPostViewModel(),
      onViewModelReady: (model) {
        if (post != null) {
          model.updateForm(post: post);
        }
      },
      builder: (context, model, child) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Form(
                key: model.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Title',
                        controller: model.titleController,
                        type: FormEnum.title,
                        icon: Icons.title,
                      ),
                      CustomTextField(
                        // label: 'Description',
                        controller: model.bodyController,
                        type: FormEnum.body,
                        icon: Icons.description,
                      ),
                      isUpdate
                          ? CommonButton(
                              title: "Update",
                              isApiCall: model.isBusy,
                              onPressed: () {
                                model.updatePost(
                                  context,
                                );
                              })
                          : CommonButton(
                              title: "Create",
                              isApiCall: model.isBusy,
                              onPressed: () {
                                model.createPost(context);
                              }),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonButton(
                          title: "Cancel",
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
          )),
    );
  }
}

class CustomTextField extends ViewModelWidget<FormPostViewModel> {
  final String? label;
  final IconData icon;
  final FormEnum type;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final String? initial;

  const CustomTextField({
    super.key,
    this.label,
    required this.icon,
    required this.type,
    this.controller,
    this.onTap,
    this.initial,
  });

  @override
  Widget build(BuildContext context, FormPostViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 12,
      ),
      child: TextFormField(
        initialValue: initial,
        controller: controller,
        maxLines: type == FormEnum.body ? 3 : 1,
        onChanged: (value) {
          model.onTextChange(value, type);
        },
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: label ?? "",
          hintStyle: TextStyle(fontSize: 13.0, color: colors.shadow),
          filled: true,
          fillColor: colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: colors.shadow),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.shadow),
              borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colors.blue),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colors.brandColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorStyle: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: colors.red,
            height: 0.6,
          ),
          prefixIcon: Icon(
            icon,
            color: colors.shadow,
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => model.onValidation(value, type),
      ),
    );
  }
}
