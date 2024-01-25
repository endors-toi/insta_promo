import 'package:flutter/material.dart';

showMsg(BuildContext context,
    {String msg = '', String title = '', int success = 0}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: success == 0
          ? Color.fromARGB(255, 2, 88, 4)
          : success == 1
              ? Color.fromARGB(255, 153, 1, 1)
              : Color.fromARGB(255, 255, 238, 0),
      title: Text(title,
          style: TextStyle(
              color: success != 2 ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold)),
      actions: [
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: success != 2 ? Colors.white : Colors.black),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/images/like.png', width: 50),
                Text('OKAP',
                    style: TextStyle(
                        fontSize: 20,
                        color: success != 2 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
