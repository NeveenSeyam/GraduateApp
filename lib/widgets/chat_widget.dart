import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../screen/comment_screen.dart';
import '../utils/theme/app_colors.dart';

class ChatWidget extends StatefulWidget {
  final QuerySnapshot<Object?> data;
  final int index;
  final BuildContext context;
  const ChatWidget(
      {Key? key,
      required this.data,
      required this.index,
      required this.context})
      : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  int likes_num = 0;
  int comment_num = 0;
  String owner_img = "";
  String post_owner = "";
  String post_text = "";
  int list_comment_number = 0;
  String like_states = "assets/images/2.png";
  void like_navegate(String value) {
    setState(() {
      if (like) {
        like = false;
        like_states = value;
      } else {
        like = true;
        like_states = value;
      }
    });
  }

  bool like = false;

  @override
  void initState() {
    like = widget.data.docs[widget.index]['like_states'];
    print('like $like');
    like
        ? like_states = "assets/images/like_pressed.png"
        : like_states = "assets/images/2.png";

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "widget.data.docs[widget.index]['owner_img'] ${widget.data.docs[widget.index]['owner_img']}");
    return Card(
        margin: const EdgeInsets.all(8),
        elevation: 2,
        color: Colors.white,
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color.fromARGB(195, 255, 255, 255),
              // offset: Offset(
              //   1.0,
              //   1.0,
              // ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ]),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if ((widget.data.docs[widget.index]['owner_img']
                                  as String)
                              .isEmpty ||
                          !((widget.data.docs[widget.index]['owner_img'])
                                  as String)
                              .contains("https://"))
                        Container(
                          decoration: BoxDecoration(
                            //  borderRadius: BorderRadius.circular(50),
                            //color: const Color(0xff423310),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xff423310),
                              width: 1,
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            backgroundImage: AssetImage(
                              "assets/images/2.png",
                              //   fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      if ((widget.data.docs[widget.index]['owner_img']
                                  as String)
                              .isEmpty ||
                          ((widget.data.docs[widget.index]['owner_img'])
                                  as String)
                              .contains("https://"))
                        Container(
                          decoration: BoxDecoration(
                            //  borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff423310),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xff423310),
                              width: 1,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              "${widget.data.docs[widget.index]['owner_img']}",
                              //   fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        "${(widget.data.docs[widget.index]['post_owner'] as String).isEmpty ? "nev" : widget.data.docs[widget.index]['post_owner']}",
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 14,
                          color: AppColors.scadryColor,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 26),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommentScreen(
                                          data: widget.data.docs[widget.index],
                                        )),
                              ); //aaas
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 50.w,
                                  child: Text(
                                    "${widget.data.docs[widget.index]['post_text'] ?? 0}",
                                    style: const TextStyle(
                                      fontFamily: 'Arial',
                                      fontSize: 14,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w700,
                                      height: 1.5,
                                    ),
                                    textHeightBehavior:
                                        const TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //   const Spacer(),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  like = !like;
                                  like
                                      ? like_states =
                                          "assets/images/like_pressed.png"
                                      : like_states = "assets/images/2.png";

                                  final postLike = FirebaseFirestore.instance
                                      .collection('posts')
                                      .doc(widget.data.docs[widget.index]
                                          .reference.id);
                                  postLike.update({'like_states': like});
                                  postLike.update({
                                    'likes_num': widget.data.docs[widget.index]
                                        ['likes_num']
                                  });
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: const BorderRadius.all(
                                        Radius.elliptical(9999.0, 9999.0)),
                                    border: Border.all(
                                        width: 4.0,
                                        color: const Color(0xfff4f7fa)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x29000000),
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: like
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              Icons.favorite_border,
                                              color: Colors.grey,
                                            ))),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
