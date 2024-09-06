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
      appBar: AppBar(
        leadingWidth: 235,
        toolbarHeight: 100,
        leading: Container(
          alignment: Alignment.bottomRight,
          child: const Text(
            'Últimas postagens',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final dataPost = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
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
                              ?6
                              :6,
              childAspectRatio: 16 / 20,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: dataPost.length,
            itemBuilder: ((context, index) {
              final allPosts = dataPost[index];
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
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(allPosts['empresa'],
                                    overflow: TextOverflow.ellipsis,),
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
                                    overflow: TextOverflow.ellipsis,),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(allPosts['subtitulo'],
                                    overflow: TextOverflow.ellipsis,),
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
                            height: responsive.isMobile || responsive.isTablet
                                ? 30
                                : 45,
                            width: responsive.width,
                            child: ElevatedButton(
                              onPressed: () {},
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
    );
  }
}
