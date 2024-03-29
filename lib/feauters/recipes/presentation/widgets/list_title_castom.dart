import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListTileCastom extends StatelessWidget {
  int index = 0;
  String title = '';
  String subtitle = '';
  String img = '';
  ListTileCastom(
      {super.key,
      required this.index,
      required this.title,
      required this.subtitle,
      required this.img});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 0, color: const Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          //
          child: Row(
            children: [
              // Image.asset(img),
              SizedBox(
                height: 130,
                width: 130,
                child: CachedNetworkImage(
                  imageUrl: img,
                  placeholder: (context, url) => const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 8, 148, 26),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            subtitle,
                            maxLines: 2,
                            // softWrap: true,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF2ECC71)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
