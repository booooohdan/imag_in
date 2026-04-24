import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:imag_in/core/utils/enums/consumer_state.dart';
import 'package:imag_in/features/photo/models/photo.dart';
import 'package:image_picker/image_picker.dart';

class GalleryProvider extends ChangeNotifier {
  static const _baseUrl = 'https://picsum.photos/v2/list';
  static const _pageSize = 30;

  final _dio = Dio();

  List<Photo> _photos = [];
  List<Photo> get photos => _photos;

  ConsumerState _state = ConsumerState.loading;
  ConsumerState get state => _state;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  int _page = 1;

  Future<void> pickAndAddPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo != null) {
      _photos = [Photo.local(photo.path), ..._photos];
      notifyListeners();
    }
  }

  Future<void> fetchFirstPage() async {
    _state = ConsumerState.loading;
    _photos = [];
    _page = 1;
    _hasMore = true;
    notifyListeners();
    await _fetch();
  }

  Future<void> loadMore() async {
    if (_isFetching || !_hasMore) {
      return;
    }
    await _fetch();
  }

  Future<void> _fetch() async {
    _isFetching = true;
    notifyListeners();

    try {
      final response = await _dio.get<List<dynamic>>(
        _baseUrl,
        queryParameters: {'page': _page, 'limit': _pageSize},
      );

      final newPhotos = (response.data ?? [])
          .map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList();

      _photos = [..._photos, ...newPhotos];
      _hasMore = newPhotos.length == _pageSize;
      _page++;
      _state = ConsumerState.success;
    } on DioException catch (error) {
      log('❌ gallery fetch error: $error');
      if (_photos.isEmpty) {
        _state = ConsumerState.error;
      }
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }
}
