import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpapers/widgets/image_viewer.dart';

class Nature extends StatelessWidget {
  const Nature({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Nature'),
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('images')
                .where('category', isEqualTo: 'nature')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: MasonryGridView.count(
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    crossAxisCount: 2,
                    itemBuilder: ((context, index) {
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
                    }),
                  ),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
