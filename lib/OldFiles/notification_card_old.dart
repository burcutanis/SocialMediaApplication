import 'package:flutter/material.dart';
import 'package:cs310_term_project/notification_old.dart';

class NotificationCard extends StatelessWidget {

  final AppNotification notification;
  final VoidCallback delete;

  NotificationCard({required this.notification, required this.delete});


  String dateTimeDifference(DateTime zaman){

    if(DateTime.now().difference(zaman).inHours >= 24){
      return(DateTime.now().difference(zaman).inDays.toString() + "d");
    }
    else{
      return(DateTime.now().difference(zaman).inHours.toString() + "h");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),

      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            //Text("${notification.notificationDatetime.day}/${notification.notificationDatetime.month}/${notification.notificationDatetime.year}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
            //Text("${notification.notificationDatetime.hour}.${notification.notificationDatetime.minute}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.circle, color: Colors.green,size: 18,),
                const Spacer(flex:1),
                Text(notification.sender + notification.content, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                const Spacer(flex:8),
                Text(dateTimeDifference(notification.notificationDatetime), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                const Spacer(flex:1),
                IconButton(onPressed: delete, icon: const Icon(Icons.mark_email_read, size: 14, color:Colors.red)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
