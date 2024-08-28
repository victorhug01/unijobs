mixin ValidationMixinClass{
  String? isNotEmpyt(String? value, [String? message]){
    if(value!.isEmpty) return message ?? "Campo em Branco!";
    return null;
  }
}