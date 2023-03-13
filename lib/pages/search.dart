import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpapers/widgets/image_viewer.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _search;

  late String name = '';

  @override
  void initState() {
    _search = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Container(
          height: 35,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              controller: _search,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Colors.grey,
                  ),
                  hintText: 'Search'),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('images').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0,),
                child: MasonryGridView.count(
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  crossAxisCount: 2,
                  itemBuilder: ((context, index) {
                    var data = snapshot.data!.docs[index].data();
                    if (data['name']
                        .toString()
                        .toLowerCase()
                        .contains(name.toLowerCase())) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => ImageViewer(
                                url: snapshot.data!.docs[index]['url'])),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            snapshot.data!.docs[index]['url'].toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
