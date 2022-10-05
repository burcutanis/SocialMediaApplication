
//@JsonSerializable()
class AppNotification{
  DateTime notificationDatetime;
  String content;
  String receiver;
  String sender;
  int notificationId;


  AppNotification({
    required this.notificationDatetime,
    required this.content,
    required this.receiver,
    required this.sender,
    required this.notificationId
  });

//factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
//Map<String, dynamic> toJson() => _$CompanyToJson(this);
}