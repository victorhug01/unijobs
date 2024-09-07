import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unijobs/src/responsive/display_responsive.dart';
import 'package:unijobs/src/theme/theme_color.dart';

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
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
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
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final allPosts = filteredData[index];
                    return Card(
                      elevation: 20.0,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const FlutterLogo(),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(allPosts['empresa'],
                                          overflow: TextOverflow.ellipsis),
                                        Text(
                                          allPosts['local'],
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(allPosts['titulo'],
                                          overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 5),
                                Text(allPosts['subtitulo'],
                                          overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 15),
                                Text(
                                  allPosts['descricao'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  height:
                                      responsive.isMobile || responsive.isTablet
                                          ? 30
                                          : 45,
                                  width: responsive.width,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Exibir o diálogo ao clicar no botão
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(allPosts['titulo']),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  Text('Empresa: ${allPosts['empresa']}'),
                                                  Text('Local: ${allPosts['local']}'),
                                                  Text('Descrição: ${allPosts['descricao']}'),
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
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      foregroundColor:
                                          ColorSchemeManagerClass.colorWhite,
                                      backgroundColor:
                                          ColorSchemeManagerClass.colorBlack,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: const Text('Saiba mais'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
