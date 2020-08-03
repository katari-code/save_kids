import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/category.dart';
import 'package:save_kids/models/channel.dart';
import 'package:save_kids/services/repository.dart';

class AddChannelBloc extends BlocBase {
  Repository _repository = Repository<Category>(collection: 'category');
  final _searchResult = BehaviorSubject<String>();
  final _channelIds = BehaviorSubject<List<String>>();
  final _channelList = BehaviorSubject<List<Channel>>();
  Function(String) get changeSearchResult => _searchResult.sink.add;
  Function(List) get changeChannelList => _channelList.sink.add;
  changeChannelIds(String id) {
    if (_channelIds.value == null) {
      _channelIds.value = [];
    }
    if (!_channelIds.value.contains(id)) {
      _channelIds.value.add(id);
    }

    return _channelIds.sink.add(_channelIds.value);
  }

  Stream<String> get searchResult =>
      _searchResult.stream.transform(_validateSearchResult);
  // Stream<List<Channel>> get channels=> _ch
  Stream<List<Channel>> get channels => _channelList.stream;
  Stream<List<String>> get channelIds => _channelIds.stream;

  final _validateSearchResult = StreamTransformer<String, String>.fromHandlers(
      handleData: (search, sink) {
    if (search.length > 1) {
      sink.add(search.trim());
    } else {
      sink.addError('search should be more than 5');
    }
  });

  Future getChannelBySearch() async {
    //! we need to add page token so we could scroll more channels
    changeChannelList(
        await _repository.getChannelsBySearch(_searchResult.value));
  }

  Future addChannels() async {
    //check if the name exists already in the db
    List<Category> result = await _repository
        .getDocumentByQuery(Category(), 'name', _searchResult.value)
        .first;

    if (result.length == 0) {
      Category _category =
          Category(name: _searchResult.value, channelIds: _channelIds.value);

      return await _repository.addDocument(_category);
    } else {
      result.first.channelIds.addAll(_channelIds.value);
      result.first.channelIds = result.first.channelIds.toSet().toList();

      return await _repository.setDocument(result.first, result.first.id);
    }
  }

  @override
  void dispose() async {
    await _searchResult.drain();
    _searchResult.close();
    await _channelList.drain();
    _channelList.close();
    await _channelIds.drain();
    _channelIds.close();
    super.dispose();
  }
}
