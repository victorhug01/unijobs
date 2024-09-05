import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  Future<String?> createUid({required String uid}) async {
    try {
      final response = await Supabase.instance.client
          .from('users')
          .update({'uid': uid.toString()}).eq('id', 1);
      // ignore: avoid_print
      print(response);

      final responses = await Supabase.instance.client
          .from('users')
          .insert({'uid': 'sffueffgqfxgcrhyy43t', 'name': 'Luiz', 'empresa': 'Aura'});
      // ignore: avoid_print
      print(responses);
    } catch (error) {
      // Lidar com outras exceções
      // ignore: avoid_print
      print('Erro ao atualizar os dados: $error');
    }
    return null;
  }
}
