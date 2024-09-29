import 'package:app_chatting_habiskerja/widgets/chat/chat_input_widget.dart';
import 'package:app_chatting_habiskerja/widgets/chat/messages_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
        actions: [
          DropdownButton(
              underline: Container(
              ),
              icon: Icon(Icons.more_vert, color: Colors.black,),
              items: [
                DropdownMenuItem(child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app, color: Colors.black,
                    ),
                    const SizedBox(width: 8,),
                    Text('Logout')
                  ],
                ), value: 'Logout',),
              ], onChanged: (itemIdentifier){
                if (itemIdentifier == 'Logout'){
                  FirebaseAuth.instance.signOut();
                }
          })
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: MessagesWidget()),
            ChatInputWidget(),
          ],
        ),
      ),
    );
  }
}
