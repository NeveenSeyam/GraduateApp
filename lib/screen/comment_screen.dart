import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../provider/auth_provider.dart';

class CommentScreen extends StatefulWidget {
  static const roudName = "/CommentScreen";

  final QueryDocumentSnapshot<Object?> data;

  const CommentScreen({Key? key, required this.data}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  Stream<DocumentSnapshot<Map<String, dynamic>>>? posts;
  var commentController = TextEditingController();

  @override
  void initState() {
    print("posts/${widget.data.reference.id}/comment");
    posts = FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.data.reference.id)
        .snapshots();
    // TODO: implement initState
    super.initState();
  }

  List<dynamic> listData = [];
  types.User? user;

  @override
  void didChangeDependencies() {
    user = Provider.of<Auth>(context).user;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.06,
          // ),
          Card(
            margin: const EdgeInsets.all(8),
            elevation: 2,
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ((widget.data['owner_img'] as String).isEmpty ||
                          !((widget.data['owner_img']) as String)
                              .contains("https://"))
                        Container(
                          decoration: BoxDecoration(
                            //  borderRadius: BorderRadius.circular(50),
                            //  color: const Color(0xff423310),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xff423310),
                              width: 1,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                              "assets/images/2.png",
                              //   fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      if ((widget.data['owner_img'] as String).isEmpty ||
                          ((widget.data['owner_img']) as String)
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
                            radius: 30,
                            backgroundImage: NetworkImage(
                              "${widget.data['owner_img']}",
                              //   fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: SizedBox(
                          width: 70.w,
                          child: Text(
                            widget.data['post_text'] ?? "",
                            style: const TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 14,
                              color: Color(0xff423310),
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                            textHeightBehavior: const TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            softWrap: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.all(4),
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        if ((user?.imageUrl as String).isEmpty ||
                            !((user?.imageUrl) as String).contains("https://"))
                          Container(
                            decoration: BoxDecoration(
                              //  borderRadius: BorderRadius.circular(50),
                              //  color: const Color(0xff423310),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xff423310),
                                width: 1,
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                "assets/images/2.png",
                                //   fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        if ((user?.imageUrl as String).isEmpty ||
                            ((user?.imageUrl) as String).contains("https://"))
                          Container(
                            decoration: BoxDecoration(
                              //  borderRadius: BorderRadius.circular(50),
                              //  color: const Color(0xff423310),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xff423310),
                                width: 1,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                "${user?.imageUrl}",
                                //   fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        const SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: TextField(
                            controller: commentController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              hintText: 'Type Name',
                              hintStyle: TextStyle(color: Color(0xff423310)),

                              //   border: OutlineInputBorder(),
                            ),
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            var data = {
                              "comment": commentController.text,
                              "userImage":
                                  user?.imageUrl ?? "assets/images/man.jpeg",
                              "userName":
                                  "${user?.firstName ?? "test"} ${user?.lastName ?? "test"}"
                            };
                            listData.add(data);
                            final postLike = FirebaseFirestore.instance
                                .collection('posts')
                                .doc(widget.data.reference.id);
                            postLike.update({'comment': listData});
                            commentController.clear();
                          },
                          child: const Text(
                            'send',
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 21,
                              color: Color(0xffe85343),
                              fontWeight: FontWeight.w700,
                              height: 1.5238095238095237,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            softWrap: false,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: posts,
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text("wrnong");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("loading");
                    }

                    final snap = snapshot.requireData;
                    print("data ${snap.data()}");
                    var data = snap.data();

                    listData = (data as dynamic)['comment'] as List<dynamic>;

                    // print(data.docs[0]['likes_num'] ?? "no data");
                    return SizedBox(
                      height: 69.h,
                      child: ListView.builder(
                          // shrinkWrap: true,
                          //  physics: const BouncingScrollPhysics(),
                          itemCount: listData.length,
                          itemBuilder: (Context, index) {
                            print(
                                "listData[index] ['userImage'] ${listData[index]['userImage']}");

                            //      print(
                            //          "data.docs ${data.docs[index].reference.id}");
                            double scale = 1.0;
                            return Card(
                              margin: const EdgeInsets.all(8),
                              elevation: 2,
                              color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //listData[index]['userImage']
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if ((listData[index]['userImage']
                                                    as String)
                                                .isEmpty ||
                                            !((listData[index]['userImage'])
                                                    as String)
                                                .contains("https://"))
                                          Container(
                                            decoration: BoxDecoration(
                                              //  borderRadius: BorderRadius.circular(50),
                                              //  color: const Color(0xff423310),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: const Color(0xff423310),
                                                width: 1,
                                              ),
                                            ),
                                            child: const CircleAvatar(
                                              radius: 15,
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: AssetImage(
                                                "assets/images/2.png",
                                                //   fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        if ((listData[index]['userImage']
                                                    as String)
                                                .isEmpty ||
                                            ((listData[index]['userImage'])
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
                                              radius: 15,
                                              backgroundImage: NetworkImage(
                                                "${listData[index]['userImage']}",
                                                //   fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          listData[index]['userName'] ?? "nev",
                                          style: const TextStyle(
                                            fontFamily: 'Arial',
                                            fontSize: 14,
                                            color: Color(0xff423310),
                                            fontWeight: FontWeight.w700,
                                            height: 1.5,
                                          ),
                                          textHeightBehavior:
                                              const TextHeightBehavior(
                                                  applyHeightToFirstAscent:
                                                      false),
                                          softWrap: false,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Flexible(
                                          child: SizedBox(
                                            child: Text(
                                              listData[index]['comment'],
                                              style: const TextStyle(
                                                fontFamily: 'Arial',
                                                fontSize: 14,
                                                color: Color(0xff423310),
                                                fontWeight: FontWeight.w700,
                                                height: 1.5,
                                              ),
                                              textHeightBehavior:
                                                  const TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              softWrap: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );

                            // return Text(
                            //   ' my Name is ${data.docs[index]['likes_num'] ?? ""} + my Name is ${(data.docs[index]['List_commint'] as List<dynamic>).join(",")} + my Name is ${data.docs[index]['owner_img'] ?? ""}  + my Name is ${data.docs[index]['post_owner'] ?? ""}  ',
                            //   style: TextStyle(color: AppColors.primaryColor),
                            // );
                          }),
                    );
                  })),
          const Spacer(),
        ],
      ),
    );
  }
}
