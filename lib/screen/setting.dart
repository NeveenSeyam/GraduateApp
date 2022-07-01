import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:hogo_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  static const roudName = "/Setting";

  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  DocumentReference? document;

  types.User? user;
  @override
  void didChangeDependencies() {
    user = Provider.of<Auth>(context).user;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 21,
                        color: Color(0xff423310),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Stack(
                      children: [
                        //   Container(
                        //   width: 109.0,
                        //   height: 104.0,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        //     color: const Color(0xff000000),
                        //     border: Border.all(width: 1.0, color: const Color(0xff707070)),
                        //   ),
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(65.00),
                          child: Image.asset("assets/man.jpeg"),
                        ),
                        // CircleAvatar(
                        //
                        //   child: Image.asset("assets/man.jpeg"),
                        // ),
                      ],
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        hintText: 'johan',
                        hintStyle: TextStyle(color: Color(0xff423310)),
                        filled: true,
                        fillColor: Color(0x40423310),
                        //   border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          // borderSide: BorderSide(width: 1,color:Color(0xff38056e))
                        ),
                        hintText: 'Johan@gmail.com',
                        hintStyle: TextStyle(color: Color(0xff423310)),
                        filled: true,
                        fillColor: Color(0x40423310),
                        //   border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          // borderSide: BorderSide(width: 1,color:Color(0xff38056e))
                        ),
                        hintText: '*****',
                        hintStyle: TextStyle(color: Color(0xff423310)),
                        filled: true,
                        fillColor: Color(0x40423310),
                        //   border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          // borderSide: BorderSide(width: 1,color:Color(0xff38056e))
                        ),
                        hintText: 'language',
                        hintStyle: TextStyle(color: Color(0xff423310)),
                        filled: true,
                        fillColor: Color(0x40423310),
                        //   border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.82,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: const Color(0xfff0aa05),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          document = FirebaseFirestore.instance
                              .collection("users")
                              .doc(Provider.of<Auth>(context, listen: false)
                                  .userId);
                          document!.update({
                            'firstName': "firstName",
                            'lastName': "lastName",
                            'email': "email",
                            'email': "email",
                            'email': "email"
                          });
                        },
                        child: const Text(
                          'save',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
