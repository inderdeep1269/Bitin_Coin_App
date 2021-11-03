import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bitin_coin_app/constants/data.dart';
import 'package:bitin_coin_app/model/bitin_model.dart';

class MinerPage extends StatefulWidget {
  const MinerPage({Key? key}) : super(key: key);

  @override
  _MinerPageState createState() => _MinerPageState();
}

class _MinerPageState extends State<MinerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: null,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              const Divider(),
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 1.5),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: (friends[index].userIsActive)
                                      ? Colors.green
                                      : Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            title: Text(friends[index].userName,
                                style: const TextStyle(fontSize: 20)),
                            horizontalTitleGap: 0.0,
                            minLeadingWidth: 50,
                          ),
                          const Divider(),
                        ],
                      );
                    }),
              ),
            ],
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
