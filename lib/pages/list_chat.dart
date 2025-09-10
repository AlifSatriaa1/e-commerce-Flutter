import 'package:flutter/material.dart';
import 'detail_chat.dart';

class ListChatPage extends StatelessWidget {
  const ListChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chats = [
      {
        "name": "Toko A",
        "avatar": "assets/images/profile.png",
        "lastMessage": "Produk masih ada kak",
        "unread": 2
      },
      {
        "name": "Toko B",
        "avatar": "assets/images/profile.png",
        "lastMessage": "Terima kasih sudah order!",
        "unread": 0
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Chat List")),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(chat["avatar"]),
            ),
            title: Text(chat["name"]),
            subtitle: Text(
              chat["lastMessage"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: chat["unread"] > 0
                ? CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.red,
                    child: Text(
                      chat["unread"].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  )
                : null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    contactName: chat["name"],
                    avatarUrl: chat["avatar"],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
