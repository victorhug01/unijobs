import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unijobs/src/responsive/display_responsive.dart';
import 'package:unijobs/src/theme/theme_color.dart';
import 'dart:ui';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _future = Supabase.instance.client.from('postagem').select();
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataPost = snapshot.data!;
          final filteredData = dataPost
              .where((post) =>
                  post['empresa']
                      .toLowerCase()
                      .contains(_searchText.toLowerCase()) ||
                  post['local']
                      .toLowerCase()
                      .contains(_searchText.toLowerCase()) ||
                  post['titulo']
                      .toLowerCase()
                      .contains(_searchText.toLowerCase()) ||
                  post['subtitulo']
                      .toLowerCase()
                      .contains(_searchText.toLowerCase()) ||
                  post['descricao']
                      .toLowerCase()
                      .contains(_searchText.toLowerCase()))
              .toList();

          return Column(
            children: [
              Form(
                child: Container(
                  padding: const EdgeInsets.all(30.0),
                  width: responsive.isMobile ? double.infinity : 550,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Buscar",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final allPosts = filteredData[index];
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(allPosts['titulo']),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Text(
                                              'Empresa: ${allPosts['empresa']}'),
                                          Text('Local: ${allPosts['local']}'),
                                          Text(
                                              'Descrição: ${allPosts['descricao']}'),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('Fechar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10.0, sigmaY: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: ColorSchemeManagerClass
                                                  .colorSecondary,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const FlutterLogo(),
                                                    const SizedBox(width: 15),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          allPosts['empresa'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  ColorSchemeManagerClass.colorBlack),
                                                        ),
                                                        Text(
                                                          allPosts['local'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  ColorSchemeManagerClass.colorBlack),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                 Icon(
                                                  Icons.circle,
                                                  color: ColorSchemeManagerClass.colorCorrect,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  allPosts['titulo'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: ColorSchemeManagerClass.colorBlack),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  allPosts['subtitulo'],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: ColorSchemeManagerClass.colorBlack),
                                                ),
                                                const SizedBox(height: 15),
                                                Text(
                                                  allPosts['descricao'],
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: ColorSchemeManagerClass.colorBlack),
                                                ),
                                                const SizedBox(height: 15),
                                                SizedBox(
                                                  height: responsive.isMobile ||
                                                          responsive.isTablet
                                                      ? 30
                                                      : 45,
                                                  width: responsive.width,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                allPosts[
                                                                    'titulo']),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: [
                                                                  Text(
                                                                      'Empresa: ${allPosts['empresa']}'),
                                                                  Text(
                                                                      'Local: ${allPosts['local']}'),
                                                                  Text(
                                                                      'Descrição: ${allPosts['descricao']}'),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                child: const Text(
                                                                    'Fechar'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 0.0,
                                                      foregroundColor:
                                                          ColorSchemeManagerClass
                                                              .colorWhite,
                                                      backgroundColor:
                                                          ColorSchemeManagerClass
                                                              .colorBlack,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                        'Saiba mais'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: filteredData.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: responsive.isMobile
                            ? 1
                            : responsive.isTablet
                                ? 2
                                : responsive.isTabletLarge
                                    ? 3
                                    : responsive.isDesktop
                                        ? 4
                                        : responsive.isDesktopLarge
                                            ? 6
                                            : 6,
                        childAspectRatio: 16 / 20,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
