import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:save_kids/models/channel.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/interfaces/i_firestore_converter.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/services/auth_service_provider.dart';
import 'package:save_kids/services/firestore_provider.dart';
import 'package:save_kids/services/schedule_provider.dart';
import 'package:save_kids/services/youtube_api_provider.dart';
import 'package:save_kids/util/preference/prefs_singleton.dart';

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
      if (type is Child) type.id = result.documentID;
      return type;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Stream<T> getDocument(T type, String id) {
    try {
      _fireStoreProvider = FireStoreProvider<T>(
          type, Firestore.instance.collection(collection),
          id: id);

      return _fireStoreProvider.document;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future deleteDocument(T type, String id) async {
    try {
      _fireStoreProvider = FireStoreProvider<T>(
        type,
        Firestore.instance.collection(collection),
        id: id,
      );
      await _fireStoreProvider.deleteDocument();
      return true;
    } catch (e) {
      logger.e(e);
      return false;
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

  Stream<List<Schedule>> getSchedules(String childId, DateTime dateTime) {
    try {
      return ScheduleProvider().getSchedules(childId, dateTime);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  //session
  Stream<Parent> get authSession {
    return _authServiceProvider.user;
  }

  Future<bool> get isEmailVerified {
    return _authServiceProvider.isEmailVerified;
  }

  Future<FirebaseUser> get currentUser {
    return _authServiceProvider.currentUser;
  }

  Future<bool> get sendEmailVerification async {
    FirebaseUser user = await currentUser;
    if (user != null) {
      await _authServiceProvider.verifyEmail(user);
      return true;
    }
    return false;
  }

  Future<bool> resetPassword(String email) async {
    return await _authServiceProvider.resetPassword(email);
  }

  Future<bool> confirmResetPassword(String code, String password) async {
    return await _authServiceProvider.confirmResetPassword(code, password);
  }

  Future updateCurrentUser(Parent parent) async {
    try {
      FirebaseUser user = await currentUser;
      await _authServiceProvider.updateCurrentUser(user, parent);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  //sign in
  Future<dynamic> signIn(String email, String password) async {
    try {
      final result = await _authServiceProvider.signIn(email, password);
      _fireStoreProvider = FireStoreProvider<T>(
          Parent(), Firestore.instance.collection(collection),
          id: result.id);
      return await _fireStoreProvider.document.first;
    } catch (e) {
      logger.e(e);
      return e;
    }
  }

  Future<Parent> signInWithGoogle() async {
    try {
      return await _authServiceProvider.signInWithGoogle();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  //sign up
  Future<dynamic> signUp(parent) async {
    try {
      final Parent result = await _authServiceProvider.signUp(
        parent.email,
        parent.password,
      );

      _fireStoreProvider = FireStoreProvider<T>(
          parent, Firestore.instance.collection(collection),
          id: result.id);
      await _fireStoreProvider.setData();
      logger.i("Parent ${result.id} has been added");
      return parent;
    } catch (e) {
      logger.e(e);
      return e;
    }
  }

  //logout
  Future<void> logout() async {
    await _authServiceProvider.signOut();
  }

  Future<Map> getVideosBySearch(String search, {String pageToken}) async {
    _youtubeApi = YoutubeApiProvider<Video>();
    try {
      return _youtubeApi.fetchBySearchCategory(
          mapper: Video(), search: search, type: 'video', pageToken: pageToken);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<Map> getChannelsBySearch(String search, {String pageToken}) async {
    _youtubeApi = YoutubeApiProvider<Channel>();

    try {
      return _youtubeApi.fetchBySearchCategory(
          mapper: Channel(),
          search: search,
          type: 'channel',
          pageToken: pageToken);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<List<Video>> getVideos(List<String> videos) async {
    _youtubeApi = YoutubeApiProvider<Video>();
    try {
      return _youtubeApi.fethList(
          collection: videos, type: 'video', mapper: Video());
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<Channel> getChannel(String channel) async {
    _youtubeApi = YoutubeApiProvider<Channel>();
    try {
      return await _youtubeApi.fetchChannel(channelId: channel);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<Map> getPlayList(String pageToken, String playListId) async {
    _youtubeApi = YoutubeApiProvider<Channel>();
    try {
      return await _youtubeApi.fetchVideosFromPlaylist(
          playlistId: playListId, pageToken: pageToken);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<bool> verifyAccount(String email, String password) async {
    try {
      FirebaseUser user = await currentUser;
      if (user.email == email) {
        final result = await signIn(email, password);
        if (result is Parent) {
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<bool> verifyAccountWithGoogle() async {
    try {
      FirebaseUser user = await currentUser;
      Parent parent = await signInWithGoogle();
      if (parent != null && parent.email == user.email) {
        return true;
      }
      return false;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
