import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../entities/entities.dart';

class ImagePlayerPage extends StatelessWidget {
  final List<FileEntity> images;
  final List<File> files;
  final int initialIndex;

  ImagePlayerPage({
    this.images = const [],
    this.files = const [],
    this.initialIndex = 0,
  }) : assert(images.isNotEmpty || files.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: Feedback.wrapForTap(() => Navigator.of(context).pop(), context),
        child: Container(
          color: Colors.black,
          child: CarouselSlider(
            items: images.isNotEmpty
                ? images
                    .map((image) => CachedNetworkImage(
                          imageUrl: image.url,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ))
                    .toList()
                : files
                    .map((image) => Image.file(
                          image,
                          fit: BoxFit.contain,
                        ))
                    .toList(),
            viewportFraction: 1.0,
            height: screenSize.height,
            initialPage: initialIndex,
          ),
        ),
      ),
    );
  }
}
