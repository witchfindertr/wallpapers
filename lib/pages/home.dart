import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpapers/category_pages/anime.dart';
import 'package:wallpapers/category_pages/cars.dart';
import 'package:wallpapers/category_pages/nature.dart';
import 'package:wallpapers/widgets/featured_wallpapers.dart';
import 'package:wallpapers/widgets/image_viewer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        scrolledUnderElevation: 0,
        title: const Text('Wallpapers'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('images').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final randomizedList = (snapshot.data!).docs;
                    randomizedList.shuffle();
                    return CarouselSlider.builder(
                      itemCount: randomizedList.length,
                      itemBuilder: ((context, index, realIndex) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => ImageViewer(
                                    url: randomizedList[index]['url'],
                                  )),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  randomizedList[index]['url'].toString(),
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return SizedBox(
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey.shade200,
                                          highlightColor: Colors.grey.shade400,
                                          child: Container(
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      options: CarouselOptions(
                        height: 220,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 800,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      color: Colors.lightBlue,
                    );
                  }
                }),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('category_images')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        //Anime Category
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: GestureDetector(
                              onTap: (() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => const Anime()),
                                    ),
                                  )),
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      snapshot.data!.docs[0]['anime']
                                          .toString(),
                                    ),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Anime',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        //Cars Category
                        Expanded(
                          child: GestureDetector(
                            onTap: (() => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => const Cars()),
                                  ),
                                )),
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    snapshot.data!.docs[0]['cars'].toString(),
                                  ),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Cars',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        //Nature Category
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: (() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => const Nature()),
                                    ),
                                  )),
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      snapshot.data!.docs[0]['nature']
                                          .toString(),
                                    ),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Nature',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Featured',
                style: TextStyle(fontSize: 20),
              ),
            ),
            //Featured Wallpapers
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('images').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final randomizedList = (snapshot.data!).docs;
                    randomizedList.shuffle();
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: randomizedList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ImageViewer(
                                      url: randomizedList[index]['url'],
                                    )),
                              ),
                            ),
                            child: MyImages(
                              url: randomizedList[index]['url'].toString(),
                            ),
                          );
                        });
                  } else {
                    return Container();
                  }
                })
          ],
        ),
      ),
    );
  }
}
