import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meau/chat/comps/widgets.dart';
import 'package:meau/chat/chatpage.dart';

class AnimatedDialog extends StatefulWidget {
  final double height;
  final double width;

  const AnimatedDialog({Key? key, required this.height, required this.width}) : super(key: key);

  @override
  State<AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog> {
  final firestore = FirebaseFirestore.instance;
  final controller = TextEditingController();
  String search = '';
  bool show = false;
  @override
  Widget build(BuildContext context) {
    if (widget.height != 0) {
      Timer(const Duration(milliseconds: 200), () {
        setState(() {
          show = true;
        });
      });
    } else {
      setState(() {
        show = false;
      });
    }

    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              color: widget.width == 0 ? Colors.indigo.withOpacity(0) : const Color(0xffF5A900),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.width == 0 ? 100 : 0),
                bottomRight: Radius.circular(widget.width == 0 ? 100 : 0),
                bottomLeft: Radius.circular(widget.width == 0 ? 100 : 0),
              )),
          child: widget.width == 0
              ? null
              : !show
                  ? null
                  : Column(
                      children: [
                        ChatWidgets.searchField(onChange: (value) {
                          setState(() {
                            search = value;
                          });
                        }),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: StreamBuilder(
                                stream: firestore.collection('user').snapshots(),
                                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  List data = !snapshot.hasData
                                      ? []
                                      : snapshot.data!.docs
                                          .where((element) =>
                                              element['name'].toString().contains(search) ||
                                              element['name'].toString().contains(search))
                                          .toList();
                                  return ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, i) {
                                      return ChatWidgets.card(
                                        title: data[i]['name'],
                                        time: DateFormat('EEE HH:mm').format(DateTime.now()),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ChatPage(
                                                    id: data[i].id.toString(),
                                                    name: data[i]['name']);
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
        ),
      ],
    );
  }
}
