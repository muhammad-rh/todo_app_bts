part of '../class/app_env.dart';

class AppReportModel extends Equatable {
  const AppReportModel(
      {required this.api,
      required this.title,
      required this.content,
      required this.message,
      required this.version,
      required this.datetime,
      required this.type});
  final String api, title, content, message, version, datetime;
  final AppAPIType type;

  static Future<AppReportModel> onDefault(
      {required List<String> api,
      required String title,
      required String content,
      required AppAPIType type}) async {
    Future<String> version() async {
      try {
        var info = await PackageInfo.fromPlatform();
        return "${AppAsset.appLabel} v${info.version}";
      } catch (e) {
        return "";
      }
    }

    return AppReportModel(
      type: type,
      api: api.map((e) => AppApi.baseURL + e).join(","),
      title: title,
      content: content,
      message: content,
      version: await version(),
      datetime: AppParse.formatDate(
        DateTime.now(),
        format: (x) =>
            "${x.date} ${x.month} ${x.year}, Pukul ${x.hour}:${x.minute}",
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "api": api,
      "title": title,
      "content": content,
      "message": message,
      "version": version,
      "datetime": datetime,
      "type": type.name.toUpperCase()
    };
  }

  @override
  List<Object?> get props => [
        "api: $api",
        "title: $title",
        "content: $content",
        "message: $message",
        "version: $version",
        "datetime: $datetime",
        "type: $type"
      ];
}
