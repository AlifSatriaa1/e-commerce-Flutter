import 'package:flutter/material.dart';
import 'detail_chat.dart';

class ListChatPage extends StatelessWidget {
  const ListChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chats = [
      {
        "name": "Toko A",
        "avatar": "assets/images/profile2.png",
        "lastMessage": "Produk masih ada kak",
        "unread": 2,
        "time": "10:45"
      },
      {
        "name": "Toko B",
        "avatar": "assets/images/profile3.png",
        "lastMessage": "Terima kasih sudah order!",
        "unread": 0,
        "time": "09:12"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4C53A5),
        elevation: 0,
        title: const Text("Messages"),
        actions: [
          IconButton(
            onPressed: () {
              // contoh search (bisa dikembangkan)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Search coming soon...")),
              );
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("More options...")),
              );
            },
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return InkWell(
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
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: AssetImage(chat["avatar"]),
              ),
              title: Text(
                chat["name"],
                style: TextStyle(
                  fontWeight:
                      chat["unread"] > 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              subtitle: Text(
                chat["lastMessage"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: chat["unread"] > 0 ? Colors.black : Colors.black54,
                  fontWeight:
                      chat["unread"] > 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    chat["time"],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (chat["unread"] > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        chat["unread"].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
