import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meau/chat/comps/styles.dart';
import 'package:meau/chat/comps/widgets.dart';
import 'package:meau/controllers/user/auth_controller.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String id;
  final String name;

  const ChatPage({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var roomId;

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final firestore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: const Color(0xffF5A900),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xffF5A900),
        title: Text(widget.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 27,
            )),
        elevation: 0,
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Chats',
                  style: Styles.h1(),
                ),
                const Spacer(),
                StreamBuilder(
                    stream: firestore.collection('user').doc(widget.id).snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                      return !snapshot.hasData
                          ? Container()
                          : Text(
                              'Visto por ultimo: ${DateFormat('HH:mm a').format(snapshot.data!['date_time'].toDate())}',
                              style: Styles.h1().copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white70),
                            );
                    }),
                const Spacer(),
                const SizedBox(
                  width: 50,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: Styles.friendsBox(),
              child: StreamBuilder(
                  stream: firestore.collection('rooms').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        List<QueryDocumentSnapshot?> allData = snapshot.data!.docs
                            .where((element) =>
                                element['users'].contains(widget.id) &&
                                element['users'].contains(authController.user.docID))
                            .toList();
                        QueryDocumentSnapshot? data = allData.isNotEmpty ? allData.first : null;
                        if (data != null) {
                          roomId = data.id;
                        }
                        return data == null
                            ? Container()
                            : StreamBuilder(
                                stream: data.reference
                                    .collection('messages')
                                    .orderBy('datetime', descending: true)
                                    .snapshots(),
                                builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                                  return !snap.hasData
                                      ? Container()
                                      : ListView.builder(
                                          itemCount: snap.data!.docs.length,
                                          reverse: true,
                                          itemBuilder: (context, i) {
                                            return ChatWidgets.messagesCard(
                                                snap.data!.docs[i]['sent_by'] ==
                                                    authController.user.docID,
                                                snap.data!.docs[i]['message'],
                                                DateFormat('HH:mm a').format(
                                                    snap.data!.docs[i]['datetime'].toDate()));
                                          },
                                        );
                                });
                      } else {
                        return Center(
                          child: Text(
                            "Nenhuma conversa encontrada!",
                            style: Styles.h1().copyWith(color: Colors.indigo.shade400),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      );
                    }
                  }),
            ),
          ),
          Container(
            color: Colors.white,
            child: ChatWidgets.messageField(onSubmit: (controller) {
              if (controller.toString() != '') {
                if (roomId != null) {
                  Map<String, dynamic> data = {
                    'message': controller.text.trim(),
                    'sent_by': authController.user.docID,
                    'datetime': DateTime.now(),
                  };
                  firestore.collection('rooms').doc(roomId).update(
                      {'last_message': controller.text, 'last_message_time': DateTime.now()});
                  firestore.collection('rooms').doc(roomId).collection('messages').add(data);
                } else {
                  Map<String, dynamic> data = {
                    'message': controller.text.trim(),
                    'sent_by': authController.user.docID,
                    'datetime': DateTime.now(),
                  };
                  firestore.collection('rooms').add({
                    'users': [widget.id, authController.user.docID],
                    'last_message': controller.text,
                    'last_message_time': DateTime.now()
                  }).then((value) {
                    value.collection('messages').add(data);
                  });
                }
              }
              controller.clear();
            }),
          )
        ],
      ),
    );
  }
}
