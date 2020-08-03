import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:save_kids/models/channel.dart';
import 'package:save_kids/models/i_firestore_converter.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/services/auth_service_provider.dart';
import 'package:save_kids/services/firestore_provider.dart';
import 'package:save_kids/services/youtube_api_provider.dart';

class Repository<T extends FireStoreConverter> {
  final String collection;
  final AuthServiceProvider _authServiceProvider = AuthServiceProvider();
  final Logger logger = Logger();

  Repository({this.collection});

  YoutubeApiProvider _youtubeApi;
  FireStoreProvider _fireStoreProvider;

  Future<T> addDocument(T type) async {
    try {
      _fireStoreProvider = FireStoreProvider<T>(
        type,
        Firestore.instance.collection(collection),
      );
      final result = await _fireStoreProvider.addDocument;
      logger.i("Parent ${result.documentID} has been added");
      return type;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Stream<List<T>> getDocumentByQuery(T type, String query, String queryId) {
    try {
      _fireStoreProvider = FireStoreProvider<T>(
        type,
        Firestore.instance.collection(collection),
      );
      return _fireStoreProvider.documentList(query, queryId);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<T> setDocument(T type, String documentId) async {
    try {
      _fireStoreProvider = FireStoreProvider<T>(
          type, Firestore.instance.collection(collection),
          id: documentId);
      await _fireStoreProvider.setData();
      return type;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  //session
  //sign in
  Future<Parent> signIn(String email, String password) async {
    try {
      final result = await _authServiceProvider.signIn(email, password);
      _fireStoreProvider = FireStoreProvider<T>(
          Parent(), Firestore.instance.collection(collection),
          id: result.id);
      return await _fireStoreProvider.document.first;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  //sign up
  Future<Parent> signUp(parent) async {
    try {
      final Parent result =
          await _authServiceProvider.signUp(parent.email, parent.password);

      _fireStoreProvider = FireStoreProvider<T>(
          parent, Firestore.instance.collection(collection),
          id: result.id);
      await _fireStoreProvider.setData();
      logger.i("Parent ${result.id} has been added");
      return parent;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<List<Video>> getVideosBySearch(String search) async {
    _youtubeApi = YoutubeApiProvider<Video>();
    try {
      return _youtubeApi.fetchBySearch(
          mapper: Video(), search: search, type: 'video');
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<List<Channel>> getChannelsBySearch(String search) async {
    _youtubeApi = YoutubeApiProvider<Channel>();
    try {
      return _youtubeApi.fetchBySearch(
          mapper: Channel(), search: search, type: 'channel');
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  //logout
}
