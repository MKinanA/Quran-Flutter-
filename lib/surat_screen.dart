import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quran/surat_list.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuratScreen extends StatelessWidget {
  final Surat surat;
  final SharedPreferences db;
  final Function updateCard;
  const SuratScreen({Key? key, required this.surat, required this.db, required this.updateCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${surat.number}. ${surat.nameLt}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                    )
                  ),
                  Text(
                    surat.name,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      fontFamily: 'Noto Naskh Arabic'
                    )
                  )
                ]
              )
            ),
            const SizedBox(
              width: 2.0
            )
          ]
        )
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          if (index < 1) {
            return const SizedBox();
          } else if (index > surat.ayat.length) {
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
            final Ayat ayat = surat.ayat[index - 1];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: (
                          {
                            bool sajadah = false,
                            bool ain = false,
                            bool thatMark = false
                          }
                        ) {
                          var list = <Widget>[
                            Text(
                              '${ayat.number}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0
                              )
                            )
                          ];
                          if (sajadah) {
                            list += [
                              const SizedBox(
                                width: 20.0
                              ),
                              const Text(
                                '۩',
                                style: TextStyle(
                                  fontFamily: 'LPMQ Isep Misbah',
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w900,
                                  height: 0.8
                                )
                              )
                            ];
                          }
                          if (ain) {
                            list += [
                              const SizedBox(
                                width: 20.0
                              ),
                              const Text(
                                'ع',
                                style: TextStyle(
                                  fontFamily: 'Noto Naskh Arabic',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w900
                                )
                              )
                            ];
                          }
                          if (thatMark) {
                            list += [
                              const SizedBox(
                                width: 20.0
                              ),
                              const Text(
                                '۞',
                                style: TextStyle(
                                  fontFamily: 'Noto Naskh Arabic',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1
                                )
                              )
                            ];
                          }
                          return list;
                        }(
                          sajadah: ayat.content.contains('۩'),
                          ain: ayat.content.contains(' ࣖ'),
                          thatMark: ayat.content.contains('۞')
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Tooltip(
                            message: 'Copy',
                            child: IconButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(
                                    text: 'Surat ${surat.nameLt} (${surat.number}) ayat ${ayat.number}:\n\n${ayat.content}\n\n${ayat.contentLt}\n\n${ayat.contentTr}'
                                  )
                                );
                                log('Copied to clipboard');
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(
                                      child: Text(
                                        'Ayat ${ayat.number} telah disalin',
                                        style: Theme.of(context).textTheme.bodySmall
                                      )
                                    ),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: Theme.of(context).colorScheme.surface
                                  )
                                );
                              },
                              icon: const Icon(
                                Icons.copy
                              )
                            )
                          ),
                          BookmarkButton(
                            ayatCode: '${surat.number}:${ayat.number}',
                            db: db,
                            updateCard: updateCard
                          )
                        ]
                      )
                    ]
                  ),
                  const SizedBox(
                    height: 16.0
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ayat.content,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'LPMQ Isep Misbah',
                        height: 2.25
                      )
                    )
                  ),
                  const SizedBox(
                    height: 16.0
                  ),
                  Text(
                    ayat.contentLt,
                    style: const TextStyle(
                      fontSize: 14.0
                    )
                  ),
                  const SizedBox(
                    height: 12.0
                  ),
                  Text(
                    ayat.contentTr,
                    style: const TextStyle(
                      fontSize: 14.0
                    )
                  )
                ]
              )
            );
          }
        },
        itemCount: surat.ayat.length + 2,
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0
            ),
            child: Divider()
          );
        }
      )
    );
  }
}

class BookmarkButton extends StatefulWidget {
  final String ayatCode;
  final SharedPreferences db;
  final Function updateCard;
  const BookmarkButton({Key? key, required this.ayatCode, required this.db, required this.updateCard}) : super(key: key);
 
  @override
  BookmarkButtonState createState() =>  BookmarkButtonState();
}

class BookmarkButtonState extends State<BookmarkButton> {
  late bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    setState(() {
      isBookmarked = widget.db.getBool(widget.ayatCode) ?? () {
        widget.db.setBool(widget.ayatCode, false);
        return false;
      }();
    });
    return Tooltip(
      message: 'Bookmark',
      child: IconButton(
        icon: Icon(
          isBookmarked ? Icons.bookmark : Icons.bookmark_border
          ),
        onPressed: () async {
          setState(() {
            isBookmarked = !isBookmarked;
          });
          await widget.db.setBool(widget.ayatCode, isBookmarked);
          widget.updateCard();
        },
      )
    );
  }
}