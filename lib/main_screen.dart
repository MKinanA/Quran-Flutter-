import 'package:flutter/material.dart';
import 'package:quran/surat_list.dart';
import 'package:quran/surat_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Al-Quran',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0
              )
            ),
            Text(
              'القرآن',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                fontFamily: 'Noto Naskh Arabic'
              )
            )
          ]
        )
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final Surat surat = suratList[index];
          final int bookmarks;
          bookmarks = 10;
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SuratScreen(surat: surat);
              }));
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${surat.number}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  surat.nameLt,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                Text(
                                  surat.nameTr,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal
                                  )
                                )
                              ]
                            ),
                            Text(
                              surat.name,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Noto Naskh Arabic'
                              )
                            )
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${surat.ayatCount} ayat, ${surat.origin}',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal
                              )
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '$bookmarks',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal
                                  )
                                ),
                                const Icon(
                                  Icons.bookmark_border,
                                  size: 20.0
                                )
                              ],
                            )
                          ]
                        )
                      ]
                    )
                  )
                ]
              )
            )
          );
        },
        itemCount: suratList.length,
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 0.0
            ),
            child: Divider()
          );
        }
      )
    );
  }
}