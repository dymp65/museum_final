import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:museum/blocs/blocs.dart';
import 'package:museum/models/models.dart';
import 'package:museum/ui/pages/informasi/informationDetailScreen.dart';
import 'package:museum/ui/pages/pencarian/searchScreen.dart';

// Future<List<InformasiMuseum>> fetchMuseumData() async {
//   final response = await http.get(Uri.parse(
//       'https://api-museum-muhammadiyah.sandboxindonesia.id/api/webcontent/gallery/'));

//   var jsonData = jsonDecode(response.body);

//   List<InformasiMuseum> dataMuseum = [];

//   for (var u in jsonData.data) {
//     InformasiMuseum museum = InformasiMuseum(
//       slug: u['slug'],
//       theme: u['theme'],
//       theme_data: u['theme_Data'],
//       title: u['title'],
//       thumbnail: u['thumbnail'],
//       active: u['active'],
//       description: u['description'],
//       image: u['image'],
//     );

//     dataMuseum.add(museum);
//   }

//   return dataMuseum;
// }

class InformationScreen extends StatefulWidget {
  InformationScreen({Key? key}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  bool _grid = false;
  ThemeDataModel _model =
      ThemeDataModel(id: 7, name: "logo institusi pemilik arsip");
  List<InformationModel> _informasi = [
    InformationModel(
      slug: "kitlv",
      theme: 7,
      title: "KITLV",
      thumbnail:
          "https://api-museum-muhammadiyah.sandboxindonesia.id/media/gallery/thumb_21-KITLV-2.jpeg",
      active: true,
      image: '',
      description: '',
    ),
    InformationModel(
      slug: "jambore-hw-1-abad-muhammadiyah-suara-muhammadiyah",
      theme: 6,
      title: "Jambore HW 1 Abad Muhammadiyah - Suara Muhammadiyah",
      thumbnail:
          "https://api-museum-muhammadiyah.sandboxindonesia.id/media/gallery/thumb_20-Jambore_HW_1_Abad_Muhammadiyah_-_Suara_Muhammadiyah.jpeg",
      active: true,
      image: '',
      description: '',
    ),
    InformationModel(
      slug: "pawai-ta_aruf-1-abad-muhammadiyah-suara-muhammadiy",
      theme: 5,
      title: "Pawai Ta_aruf 1 Abad Muhammadiyah - Suara Muhammadiyah",
      thumbnail:
          "https://api-museum-muhammadiyah.sandboxindonesia.id/media/gallery/thumb_19-Pawai_Ta_aruf_1_Abad_Muhammadiyah_-_Suara_Muhammadiyah.jpeg",
      active: true,
      image: '',
      description: '',
    ),
    InformationModel(
        slug: "pembukaan-muktamar-1-abad-muhammadiyah-suara-muham",
        theme: 4,
        title: "Pembukaan Muktamar 1 Abad Muhammadiyah - Suara Muhammadiyah",
        thumbnail:
            "https://api-museum-muhammadiyah.sandboxindonesia.id/media/gallery/thumb_18-Pembukaan_Muktamar_1_Abad_Muhammadiyah_-_Suara_Muhammadiyah.jpeg",
        active: true,
        description: '',
        image: ''),
  ];

  @override
  void initState() {
    super.initState();
    // futureMuseum = fetchMuseumData();
    context.read<InformationCubit>().fetchInformation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InformationCubit, InformationState>(
      listener: (context, state) {
        if (state is InformationFetch) {
          // _informasi = state.information;
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xffF5F6F8),
        body: _informationBuilder(),
      ),
    );
  }

  Widget _informationBuilder() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: const Text(
            'Informasi Museum',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xff232933),
            ),
          ),
          actions: [
            InkWell(
              onTap: () => setState(() {
                _grid = false;
              }),
              child: SvgPicture.asset(_grid
                  ? 'assets/icons/single-grid.svg'
                  : 'assets/icons/single-grid-active.svg'),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () => setState(() {
                _grid = true;
              }),
              child: SvgPicture.asset(_grid
                  ? 'assets/icons/multi-grid-active.svg'
                  : 'assets/icons/multi-grid.svg'),
            ),
            const SizedBox(width: 16),
          ],
          // title: Text('Informasi Museum'),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              InkWell(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchScreen())),
                child: _searchInformation(),
              ),
            ],
          ),
        ),
        _grid ? _sliverStaggeredBuilder() : _sliverListbuilder(),
        const SliverToBoxAdapter(
          child: SizedBox(height: 62),
        ),
      ],
    );
  }

  Widget _sliverListbuilder() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InformationDetailScreen(
                informasi: _informasi[index],
              ),
            ),
          ),
          child: _singleGrid(
            _informasi[index].thumbnail,
            _informasi[index].title,
            _informasi[index].description,
          ),
        );
      }, childCount: _informasi.length),
    );
  }

  Widget _sliverStaggeredBuilder() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverStaggeredGrid.countBuilder(
        crossAxisCount: 4,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 8.0,
        staggeredTileBuilder: (index) =>
            StaggeredTile.count(2, index.isEven ? 3 : 2),
        itemBuilder: (context, index) {
          var item = _informasi[index];

          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InformationDetailScreen(
                  informasi: item,
                ),
              ),
            ),
            child: _cardItem(item.thumbnail, item.title),
          );
        },
        itemCount: _informasi.length,
      ),
    );
  }

  Widget _sliverListbuilderBloc() {
    return BlocBuilder<InformationCubit, InformationState>(
      builder: (context, state) {
        if (state is InformationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is InformationFetch) {
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InformationDetailScreen(
                      informasi: _informasi[index],
                    ),
                  ),
                ),
                child: _singleGrid(
                  _informasi[index].thumbnail,
                  _informasi[index].title,
                  _informasi[index].description,
                ),
              );
            }, childCount: _informasi.length),
          );
        }

        return SliverToBoxAdapter(child: Center(child: Text('Belum ada data')));
      },
    );
  }

  Widget _sliverStaggeredBuilderBloc() {
    return BlocBuilder<InformationCubit, InformationState>(
      builder: (context, state) {
        if (state is InformationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is InformationFetch) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverStaggeredGrid.countBuilder(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 8.0,
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(2, index.isEven ? 3 : 2),
              itemBuilder: (context, index) {
                var item = _informasi[index];

                return _cardItem(item.thumbnail, item.title);
              },
              itemCount: _informasi.length,
            ),
          );
        }

        return const SliverToBoxAdapter(
            child: Center(child: Text('Belum ada data')));
      },
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
              image: NetworkImage(image),
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
            gradient: const LinearGradient(
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
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: const TextStyle(
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

  Widget _searchInformation() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Cari koleksi museum disini'),
          Icon(Icons.search),
        ],
      ),
    );
  }

  Widget _singleGrid(String image, String title, String desc) {
    return Stack(
      children: [
        Container(
          // padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
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
          margin: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width - 32,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                child: Text(
                  desc,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InformasiMuseum {
  String? slug;
  int? theme;
  InformasiMuseumTheme? theme_data; //
  String? title;
  String? thumbnail;
  bool? active;
  String? description;
  String? image;

  InformasiMuseum({
    this.slug,
    this.theme,
    this.theme_data,
    this.title,
    this.thumbnail,
    this.active,
    this.description,
    this.image,
  });

  factory InformasiMuseum.fromJson(Map<String, dynamic> json) {
    return InformasiMuseum(
      slug: json['userId'],
      theme: json['theme'],
      theme_data: json['theme_Data'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      active: json['active'],
      description: json['description'],
      image: json['image'],
    );
  }
}

class InformasiMuseumTheme {
  int? id;
  String? name;

  InformasiMuseumTheme({
    this.id,
    this.name,
  });

  factory InformasiMuseumTheme.fromJson(Map<String, dynamic> json) {
    return InformasiMuseumTheme(
      id: json['id'],
      name: json['name'],
    );
  }
}
