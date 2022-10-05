import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:cs310_term_project/config/palette.dart';
import 'package:cs310_term_project/models/models.dart';


class Rooms extends StatelessWidget {
  final List<User> onlineUsers;

  const Rooms({
    Key? key,
    required this.onlineUsers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Container(
        height: 60.0,
        color: Colors.white,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 4.0,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: 1 + onlineUsers.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _CreateChatButton(),
              );
            }
            final User user = onlineUsers[index - 1];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CircularProfileAvatar(
                user.imageUrl,
                radius: 20,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CreateChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => print('Chat'),

      child: Row(
        children: [
          Icon(
            Icons.chat,
            size: 30.0,
            color: Colors.purple,
          ),
          const SizedBox(width: 4.0),
          Text('Chat'),
        ],
      ),
      style: OutlinedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: 20.0,
          color:Palette.facebookBlue,
        ),
        side:BorderSide(
          width: 3.0,
          color: Colors.blueAccent,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
         ),
      ),
    );
  }
}