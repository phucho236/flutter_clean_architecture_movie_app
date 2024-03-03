import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class AppMessage {
  showToastMessage(String? message, {int seconds = 2}) {
    if (message == null) return;
    BotToast.showCustomNotification(
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
      duration: Duration(seconds: seconds),
      toastBuilder: (cancel) {
        return ToastMessage(message: message);
      },
    );
  }

  showNotificationMessage({NotificationModel? model, NotificationCallback? callback}) {
    BotToast.showCustomNotification(
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 5),
      toastBuilder: (cancel) {
        return NotificationMessage(
          model: model,
          callback: (model) {
            cancel();
            callback!(model);
          },
        );
      },
    );
  }
}

class AppMessageTest extends AppMessage {
  @override
  showToastMessage(String? message, {int seconds = 2}) {
    return;
  }
}

class ToastMessage extends StatelessWidget {
  const ToastMessage({this.message, Key? key}) : super(key: key);
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12),
        //  boxShadow: [AppTheme.defaultBoxShadow]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: const Text("Icon here"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message!, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

typedef NotificationCallback = Function(NotificationModel?);

class NotificationMessage extends StatefulWidget {
  final NotificationCallback? callback;
  final NotificationModel? model;

  const NotificationMessage({Key? key, this.model, this.callback}) : super(key: key);

  @override
  State<NotificationMessage> createState() => _NotificationMessage();
}

class _NotificationMessage extends State<NotificationMessage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: GestureDetector(
        onTap: () {
          widget.callback!(widget.model);
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 1,
                  offset: const Offset(0, 2),
                )
              ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: const Text("Icon here")),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: widget.model!.body!.isEmpty
                          ? [
                              Text(
                                widget.model!.title!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                                maxLines: 2,
                              )
                            ]
                          : [
                              Text(
                                widget.model!.title!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                                maxLines: 2,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.model!.body!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                                maxLines: 2,
                              )
                            ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// import 'notification_type.dart';

class NotificationModel {
  String? title;
  String? body;
  final NotificationData? data;

  NotificationModel({
    required this.title,
    required this.body,
    required this.data,
  });

  // NotificationActionType get actionType =>
  //     NotificationActionExtend.getNotificationActionTypeFromIndex(
  //         data?.notificationType ?? notificationType);

  @override
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final notification = json['notification'] ?? json;
    final dataNoti = json['data'];
    return NotificationModel(
      title: notification['title'],
      body: notification['body'],
      data: dataNoti == null ? null : NotificationData.fromJson(dataNoti),
    );
  }

  static List<NotificationModel> toList(List<dynamic> items) {
    return items.map((item) => NotificationModel.fromJson(item)).toList();
  }
}

class NotificationData {
  final String? communicationId;
  final String? remindId;
  final String? calendarId;
  final String? notificationType;
  final String? notificationId;
  final String? referalCode;
  final String? surveyId;

  NotificationData({
    this.surveyId,
    required this.notificationId,
    required this.calendarId,
    required this.communicationId,
    required this.remindId,
    required this.notificationType,
    required this.referalCode,
  });

  @override
  factory NotificationData.fromJson(dynamic json) {
    return NotificationData(
      notificationId: json['notificationId'],
      communicationId: json['communicationId'],
      remindId: json['remindId'],
      calendarId: json['calendarId'],
      referalCode: json['referalCode'],
      surveyId: json['surveyId'],
      notificationType: json['notificationType'],
    );
  }

  static List<NotificationData> toList(List<dynamic> items) {
    return items.map((item) => NotificationData.fromJson(item)).toList();
  }
}
