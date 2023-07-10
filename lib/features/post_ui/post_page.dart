import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fetch_api/features/post_bloc/post_bloc.dart';
import 'package:flutter_bloc_fetch_api/models/post_models.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostBloc _postBloc = PostBloc();

  @override
  void initState() {
    _postBloc.add(GetPostList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('BLOC API fetch'),
      ),
      body: Card(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: BlocProvider(
            create: (_) => _postBloc,
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is ErrorState) {
                  return Center(child: Text(state.errorMessage!));
                } else if (state is PostInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostLoaded) {
                  return _buildCard(context, state.postModel);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildCard(BuildContext context, List<PostDataModel> _postModel) {
  return ListView.builder(
      itemCount: 9,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   width: 25,
                //   height: 25,
                //   padding: const EdgeInsets.all(15),
                //   decoration: const BoxDecoration(
                //       shape: BoxShape.circle, color: Colors.black),
                //   child: Text("${_postModel[index].id}",
                //       style: const TextStyle(color: Colors.white)),
                // ),
                // const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${_postModel[index].title}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 15),
                      Text('${_postModel[index].body}',
                          textAlign: TextAlign.justify)
                    ],
                  ),
                )
              ],
            ),
          )),
        );
      });
}
