import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unijobs/src/responsive/display_responsive.dart';
import 'package:unijobs/src/theme/theme_color.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _future = Supabase.instance.client.from('postagem').select();
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 25),
            height: 80,
            alignment: Alignment.bottomLeft,
            child: const Text(
              'Últimas vagas atualizadas',
              style: TextStyle(fontSize: 20),
            ),
          ),
          FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final dataPost = snapshot.data!;
              return GridView.builder(
                shrinkWrap: true,
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
                itemCount: dataPost.length,
                itemBuilder: ((context, index) {
                  final allPosts = dataPost[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: ColorSchemeManagerClass.colorSecondary
                      ),
                    ),
                    elevation: 2.0,
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
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allPosts['empresa'],
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
                              Text(
                                allPosts['titulo'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                allPosts['subtitulo'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                allPosts['descricao'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height:
                                    responsive.isMobile || responsive.isTablet
                                        ? 30
                                        : 45,
                                width: responsive.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Função para exibir o diálogo com informações do card
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
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
