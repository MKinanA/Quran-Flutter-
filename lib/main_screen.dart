import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quran/surat_list.dart';
import 'package:quran/surat_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatelessWidget {
  final SharedPreferences db;
  const MainScreen({Key? key, required this.db}) : super(key: key);
 
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
      drawer: const Drawer(
        child: SizedBox()
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          if (index < 1) {
            return const SizedBox();
          } else if (index > suratList.length) {
            return Container(
              margin: const EdgeInsets.only(
                top: 256.0,
                bottom: 16.0
              ),
              width: double.infinity,
              child: const Center(
                child: Text(
                  barakallah,
                  style: TextStyle(
                    fontFamily: 'LPMQ Isep Misbah',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w100
                  ),
                  textAlign: TextAlign.center
                )
              )
            );
          } else {
            return SuratCard(
              surat: suratList[index - 1],
              db: db
            );
          }
        },
        itemCount: suratList.length + 2,
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

class SuratCard extends StatefulWidget {
  final Surat surat;
  final SharedPreferences db;
  const SuratCard({Key? key, required this.surat, required this.db}) : super(key: key);

  @override
  SuratCardState createState() => SuratCardState();
}

class SuratCardState extends State<SuratCard> {
  int bookmarks = 0;

  void updateBookmarks() {
    setState(() {
      bookmarks = 0;
    });
    for (int ayatNum = 1; ayatNum <= widget.surat.ayatCount; ayatNum++) {
      if (widget.db.getBool('${widget.surat.number}:$ayatNum') ?? () {
        widget.db.setBool('${widget.surat.number}:$ayatNum', false);
        return false;
      }()) {
        setState(() {
          bookmarks ++;
        });
        log('found bookmark on ${widget.surat.number}:$ayatNum');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    updateBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SuratScreen(surat: widget.surat, db: widget.db, updateCard: updateBookmarks);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${widget.surat.number}',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(
              width: 16.0
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
                            widget.surat.nameLt,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Text(
                            widget.surat.nameTr,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal
                            )
                          )
                        ]
                      ),
                      Text(
                        widget.surat.name,
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
                        '${widget.surat.ayatCount} ayat, ${widget.surat.origin}',
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
  }
}