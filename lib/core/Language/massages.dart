import 'package:get/get.dart';

class Messages extends Translations{
  Map<String,Map<String ,String>> languages;
  Messages({required this.languages });

  @override 
  Map<String,Map<String,String>> get keys{
    return languages;
  }
} 