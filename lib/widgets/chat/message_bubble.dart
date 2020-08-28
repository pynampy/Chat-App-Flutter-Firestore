
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {

  final String message;
  final bool isMe;
  final Key key;
 final String username;
 final String userImage;
  MessageBubble(this.message, this.isMe, this.username, this.userImage, { this.key} );
  //MessageBubble(this.message, this.isMe,  { this.key} );


  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            Row(
        mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: isMe? Colors.grey[300] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: isMe? Radius.circular(12):Radius.circular(0),
                bottomRight: isMe? Radius.circular(0):Radius.circular(12),
                ),

            ),
            width: 140,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Column(
              crossAxisAlignment: isMe? CrossAxisAlignment.end: CrossAxisAlignment.start,
              children: <Widget>[
                Text(username, style: TextStyle(
                  fontWeight: FontWeight.bold,
                   color: isMe? Colors.black :Theme.of(context).accentTextTheme.headline1.color
                )),
                   

                
                Text(message, style: TextStyle(
                  color: isMe? Colors.black :Theme.of(context).accentTextTheme.headline1.color
                ),
                textAlign: isMe? TextAlign.end: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
      Positioned(
        top: -10,
        left: isMe? null : 120,
        right: isMe? 120 : null,
        child: CircleAvatar(
          backgroundImage: NetworkImage(userImage),
        ),

        
        ),
      
      
          ] ,
          overflow: Overflow.visible,

    );
  }
}