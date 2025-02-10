class CommonRestBody {
  CommonRestBody({this.data, this.code, this.error, this.status, this.message});

  dynamic data;
  int? code;
  ErrorModel? error;
  bool? status;
  String? message;

  factory CommonRestBody.fromJson(Map<String, dynamic> json) => CommonRestBody(
        data: json["data"],
        code: json["code"],
        message: json["message"],
        error:
            json["error"] != null ? ErrorModel.fromJson(json["error"]) : null,
        status: json["status"],
      );
}

class ErrorModel {
  String? title;
  String? detail;
  String? status;
  bool? isError;

  ErrorModel({this.title, this.detail, this.status, this.isError});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        title: json["title"] ?? "",
        detail: json["detail"] ?? "",
        status: json["status"] ?? "",
        isError: json["isError"] ?? false,
      );
}
