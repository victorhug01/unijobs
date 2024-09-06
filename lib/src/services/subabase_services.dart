import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  Future<Map<String, dynamic>> createUid(
      {required String uid,
      required String name,
      required String email}) async {
    try {
      final existingUser = await Supabase.instance.client
          .from('users')
          .select('*')
          .eq('uid', uid)
          .maybeSingle();

      if (existingUser == null) {
        final newUser = await Supabase.instance.client.from('users').insert({
          'uid': uid,
          'name': name,
          'email': email,
        });
        return {
          'success': true,
          'message':
              'Usuário não encontrado e foi adicionado um novo: $newUser',
        };
      } else {
        return {
          'success': false,
          'message': 'Usuário já existente',
        };
      }
    } catch (error) {
      // Registrar erro em um log ou enviar para uma ferramenta de monitoramento
      // ignore: avoid_print
      print('Erro ao criar usuário: $error');
      return {
        'success': false,
        'message': 'Ocorreu um erro ao criar o usuário.',
      };
    }
  }

  // Future<dynamic>? getDataUser({required String uid}) async{
  //   try {
  //     final getAllData = await Supabase.instance.client
  //         .from('users')
  //         .select('*')
  //         .eq('uid', uid);
  //   } catch (error) {
  //     // ignore: avoid_print
  //     print('Erro ao criar usuário: $error');
  //     return {
  //       'success': false,
  //       'message': 'Ocorreu um erro ao criar o usuário.',
  //     };
  //   }
  // }
}
