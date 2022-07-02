// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hogo_app/utils/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../widgets/chat_widget.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../provider/auth_provider.dart';

class forumScreen extends StatefulWidget {
  // const forumScreen({Key? key}) : super(key: key);

  @override
  _forumScreenState createState() => _forumScreenState();
}

class _forumScreenState extends State<forumScreen> {
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

  String finalData = "";
  int likes_num = 0;
  int comment_num = 0;
  String owner_img = "";
  String post_owner = "";
  String post_text = "";
  int list_comment_number = 0;
  bool like = false;
  String like_states = "assets/images/2.png";
  int Myindex = 0;

  types.User? user;

  @override
  void didChangeDependencies() {
    user = Provider.of<Auth>(context).user;
    super.didChangeDependencies();
  }

  var postController = TextEditingController();
  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection("posts").snapshots();
  @override
  Widget build(BuildContext context) {
    CollectionReference postsAdd =
        FirebaseFirestore.instance.collection('posts');
// test
    print("user?.imageUrl ${user?.imageUrl}");
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            child: Card(
              elevation: 5,
              color: AppColors.white,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Row(
                  children: [
                    if ((user?.imageUrl as String).isEmpty ||
                        !((user?.imageUrl) as String).contains("https://"))
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
                        child: const CircleAvatar(
                          radius: 25,
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
                            "${user?.imageUrl}",
                            //   fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    const SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      // height: 42,
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: TextFormField(
                        maxLines: 5,
                        minLines: 1,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          hintText: 'Type post',
                          hintStyle: TextStyle(color: AppColors.primaryColor),

                          //   border: OutlineInputBorder(),
                        ),
                        controller: postController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        postsAdd
                            .add({
                              'comment_num': comment_num,
                              'likes_num': likes_num,
                              'like_states': false,
                              'owner_img':
                                  user?.imageUrl ?? "assets/images/man.jpeg",
                              'post_owner': "${user?.firstName} ",
                              'post_text': postController.text,
                              "comment": [],
                              'list_comment_number': list_comment_number,
                            })
                            .then((value) => print("Student data Added"))
                            .catchError(
                                (error) => print("Student couldn't be added."));
                        postController.clear();
                        // Navigator.pushNamed(context, FormScreen.roudName);
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
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        softWrap: false,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: posts,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text("wrnong");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("loading");
                    }

                    final data = snapshot.requireData;
                    list_comment_number = data.size;

                    // print(data.docs[0]['likes_num'] ?? "no data");
                    return SizedBox(
                      height: 76.h,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.size,
                          itemBuilder: (Context, index) {
                            Myindex = index;
                            print("data.docs ${data.docs[index].reference.id}");
                            double scale = 1.0;
                            return ChatWidget(
                                data: data, index: index, context: context);

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
