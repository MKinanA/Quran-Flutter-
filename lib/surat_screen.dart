import 'package:flutter/material.dart';
import 'package:quran/surat_list.dart';

class SuratScreen extends StatelessWidget {
  final Surat surat;
  const SuratScreen({Key? key, required this.surat}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${surat.number}. ${surat.nameLt}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                    )
                  ),
                  Text(
                    surat.name,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                    )
                  )
                ]
              )
            ),
            const SizedBox(
              width: 2.0,
            ),
            const BookmarkButton()
          ]
        )
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final Ayat ayat = surat.ayat[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${ayat.number}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                    )
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ayat.content,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Noto Naskh Arabic'
                      )
                    )
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    ayat.contentLt,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                    )
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    ayat.contentTr,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                    )
                  )
                ]
              )
            )
          );
        },
        itemCount: surat.ayat.length
      )
    );
  }
}

class BookmarkButton extends StatefulWidget {
  const BookmarkButton({Key? key}) : super(key: key);
 
  @override
  BookmarkButtonState createState() =>  BookmarkButtonState();
}
 
class BookmarkButtonState extends State<BookmarkButton> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_border
        ),
      onPressed: () {
        setState(() {
          isBookmarked = !isBookmarked;
        });
      },
    );
  }
}