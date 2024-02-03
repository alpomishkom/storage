import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storeych/pages/home/service/service.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  File file = File('');

  Future<String> upload() async {
    await Storege.upload(Storege.path, await imagesFail());
    return '';
  }

  Future<File> imagesFail() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      File file1 = File(xFile.path);
      file = file1;
    }
    return file;
  }

  List<String> getList = [];

  Future<void> getAll() async {
    getList = await Storege.gedAll(Storege.path);
    setState(() {});
  }

  @override
  void initState() {
    getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.abc_sharp),
            ),
            Tab(
              icon: Icon(Icons.abc_sharp),
            ),
            Tab(
              icon: Icon(Icons.abc_sharp),
            ),
          ]),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.824,
              child: TabBarView(
                children: [
                  Container(
                    color: Colors.red,
                    child: ListView.builder(
                        itemCount: getList.length,
                        itemBuilder: (_, index) {
                          return Card(
                            child: ListTile(
                              title: Text(getList[index].toString()),
                              trailing: IconButton(
                                  onPressed: () async {
                                   await Storege.delet(
                                      getList.length.toString(),
                                    );
                                   await getAll().then((value) {
                                      setState(() {

                                      });
                                    });
                                  },
                                  icon: Icon(Icons.delete)),
                            ),
                          );
                        }),
                  ),
                  Container(
                    color: Colors.green,
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await upload();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
