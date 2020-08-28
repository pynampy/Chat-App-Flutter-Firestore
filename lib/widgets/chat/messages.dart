import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (ctx, snapShot) { 
                 if(snapShot.connectionState == ConnectionState.waiting){
                             return Center(child: CircularProgressIndicator(),);}
             
      return  StreamBuilder(
      stream: Firestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, chatSnapshot){
        if(chatSnapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
          }
          final chatDocs = chatSnapshot.data.documents;
         return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx,index) 
           { 
             return MessageBubble(
              chatDocs[index]['text'],              
              chatDocs[index]['userId'] == snapShot.data.uid,
              chatDocs[index]['username'],
              chatDocs[index]['userImage'],
              key: ValueKey(chatDocs[index].documentID)
              ); 
              }      
        );}
        );
        
        
      },
      
    );
  }
}