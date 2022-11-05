import 'package:flutter/material.dart';

const apiV1 = 'https://api-museum-muhammadiyah.sandboxindonesia.id/api/';

const urlGalleryList = 'webcontent/gallery/';
String urlGallerySearch(var term) {
  return 'webcontent/gallery/?search=$term';
}

String urlGallerySlug(var slug) {
  return 'webcontent/gallery/$slug';
}
