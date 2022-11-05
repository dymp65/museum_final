import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<IsiMuseum> _isiMuseum = [
    IsiMuseum(
      image: 'assets/images/temp-1.png',
      title: 'Lukisan “Holy Colours"',
      desc:
          'Rhoncus feugiat viverra sit eget cras donec quam bibendum. Lorem dictum eu praesent.',
    ),
    IsiMuseum(
      image: 'assets/images/temp-2.png',
      title: 'Perhiasan Kuno"',
      desc: 'Perhisan Kuno.',
    ),
    IsiMuseum(
      image: 'assets/images/temp-1.png',
      title: 'Lukisan “Holy Colours"',
      desc:
          'Rhoncus feugiat viverra sit eget cras donec quam bibendum. Lorem dictum eu praesent.',
    ),
    IsiMuseum(
      image: 'assets/images/temp-2.png',
      title: 'Perhiasan Kuno"',
      desc: 'Perhisan Kuno.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6F8),
      body: _searchBuilder(),
    );
  }

  Widget _searchBuilder() {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            centerTitle: false,
            title: _searchInformation(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Terakhir dilihat',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Clear',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xffE95656),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverStaggeredGrid.countBuilder(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 8.0,
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(2, index.isEven ? 3 : 2),
              itemBuilder: (context, index) {
                var item = _isiMuseum[index];

                return _cardItem(item.image, item.title);
              },
              itemCount: _isiMuseum.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchInformation() {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari koleksi museum disini',
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }

  Widget _cardItem(String image, String title) {
    return Stack(
      children: [
        Container(
          // padding: const EdgeInsets.all(8),
          // margin: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Container(
          // margin: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black,
                Colors.transparent,
              ],
            ),
          ),
        ),
        Container(
          // margin: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.width - 32,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IsiMuseum {
  var image;
  String title;
  String desc;

  IsiMuseum({this.image, required this.title, required this.desc});
}
