import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
              flex: 1,
              // ignore: avoid_unnecessary_containers
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
                          child: Image.asset("assets/images/man.jpeg"),
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
                margin: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        hintText: 'johan',
                        hintStyle: TextStyle(color: Color(0xff423310)),
                        filled: true,
                        fillColor: Color.fromARGB(64, 157, 149, 128),
                        //   border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          // borderSide: BorderSide(width: 1,color:Color(0xff38056e))
                        ),
                        hintText: 'Johan@gmail.com',
                        hintStyle: TextStyle(color: Color(0xff423310)),
                        filled: true,
                        fillColor: Color.fromARGB(64, 157, 149, 128),
                        //   border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          // borderSide: BorderSide(width: 1,color:Color(0xff38056e))
                        ),
                        hintText: '***********',
                        hintStyle: TextStyle(color: Color(0xff423310)),
                        filled: true,
                        fillColor: Color.fromARGB(64, 157, 149, 128),
                        //   border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          // borderSide: BorderSide(width: 1,color:Color(0xff38056e))
                        ),
                        hintText: 'language',
                        hintStyle: TextStyle(color: Color(0xff423310)),
                        filled: true,
                        fillColor: Color.fromARGB(64, 157, 149, 128),

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
                    child: const Center(
                      child: Text(
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
                ],
              )),
        ],
      ),
    );
  }
}
