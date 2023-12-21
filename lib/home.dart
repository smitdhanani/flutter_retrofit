import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_retofit/models/model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("Home"),
      ),
      body: _body(),
    );
  }

  FutureBuilder _body() {
    final apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
        future: apiService.getPosts(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<PostModel> posts = snapshot.data!;
            return _posts(posts);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }

  Widget _posts(List<PostModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(children: [
            Text(
              posts[index].title.toString(),
              style: const TextStyle(fontSize: 25),
            ),
          ]),
        );
      },
    );
  }
}
