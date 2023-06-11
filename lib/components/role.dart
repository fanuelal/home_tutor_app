import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChooseRole extends StatefulWidget {
  const ChooseRole({super.key});

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: [
          // Container(
            
          //   child: CircleAvatar(
          //         radius: 20.0,
          //         backgroundImage: AssetImage('assets/student.jpg'),
          //         // backgroundColor: Colors.white,
          //       ),
          //   color: Colors.amber,
          //   // margin: EdgeInsets.all(25.0),
          //   margin: const EdgeInsets.fromLTRB(85, 30, 20, 20),
          //   height: 200,
          //   width: 200,
            
            
          //   ),





          Container(
            

              color: Colors.amber,
            // margin: EdgeInsets.all(25.0),
            margin: const EdgeInsets.fromLTRB(85, 30, 20, 20),
            height: 200,
            width: 200,

        child: CircleAvatar(
          // radius: 40.0,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          child: CircleAvatar(
            child: Align(
              alignment: Alignment.topCenter,
              
            ),
            radius: 45.0,
            backgroundImage: AssetImage(
              'assets/student.jpg'),
          ),
        ),
        
      
      )]),
      Row(
        children: [
          Container(
              height: 200,
              width: 200,
              color: Colors.pink,
              margin: const EdgeInsets.fromLTRB(85, 30, 20, 20),)
        ],
      )
    ]);
  }
}
