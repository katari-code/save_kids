import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:save_kids/models/channel.dart';
import 'package:save_kids/services/repository.dart';

class ChannelBloc extends BlocBase {
  final _searchResult = BehaviorSubject<String>();
  final _channelList = BehaviorSubject<List<Channel>>();
  Function(String) get changeSearchResult => _searchResult.sink.add;
  Function(List) get changeChannelList => _channelList.sink.add;
  addChosenChannel(String channelId) {
    List<Channel> videos = _channelList.value.map((channel) {
      if (channel.id == channelId) {
        Channel editedChannel = channel..chosen = !channel.chosen;
        return editedChannel;
      }
      return channel;
    }).toList();
    return changeChannelList(videos);
  }

  Stream<String> get searchResult =>
      _searchResult.stream.transform(_validateSearchResult);
  Stream<List<Channel>> get channels => _channelList.stream;

  final _validateSearchResult = StreamTransformer<String, String>.fromHandlers(
      handleData: (search, sink) {
    if (search.length > 1) {
      sink.add(search.trim());
    } else {
      // sink.addError('search should be more than 5');
    }
  });

  Future getChannelBySearch() async {
    changeChannelList(
        await Repository().getChannelsBySearch(_searchResult.value));
  }

  List<Channel> returnChosenChannels() {
    return _channelList.value
        .where((element) => element.chosen == true)
        .toList();
  }

  @override
  void dispose() async {
    await _searchResult.drain();
    _searchResult.close();
    await _channelList.drain();
    _channelList.close();
    super.dispose();
  }
}
