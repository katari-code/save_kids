abstract class Mapper<T> {
  T fromSearchMap(Map<String, dynamic> map);
  T fromIdsMap(Map<String, dynamic> map);
}
