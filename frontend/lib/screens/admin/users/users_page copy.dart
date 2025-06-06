import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/data_service_test.dart';
import 'package:frontend/widgets/buttons/customizable_modal_options.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/lists/admin/user/user_list.dart';
import 'package:frontend/widgets/searches/search_input.dart';

void mostrarOpcionesUsuario(BuildContext context, dynamic user) {
  ModalOptionsCustomizable.mostrar(
    context: context,
    titulo: 'Usuario: ${user.nombre}',
    acciones: [
      AccionModal(
        icono: Icons.edit,
        titulo: 'Editar Rol',
        alPresionar: () {
          // Lógica para editar Rol
          print('Editar usuario: ${user.nombre}');
        },
      ),
      AccionModal(
        icono: Icons.edit,
        titulo: 'Editar',
        alPresionar: () {
          // Lógica para editar usuario
          print('Editar usuario: ${user.nombre}');
        },
      ),
      AccionModal(
        icono: Icons.delete,
        titulo: 'Eliminar',
        alPresionar: () {
          // Lógica para eliminar usuario
          print('Eliminar usuario: ${user.nombre}');
        },
      ),
    ],
  );
}

class AdminUserStateManagement extends StatefulWidget {
  @override
  _AdminUserStateManagementState createState() =>
      _AdminUserStateManagementState();
}

class _AdminUserStateManagementState extends State<AdminUserStateManagement> {
  List<User> usuarios = UserService.users;
  List<User> usuariosFiltrados = [];

  @override
  Widget build(BuildContext context) {
    // Contenido de la pantalla
    Widget contenidoPantalla = Column(
      children: [
        // Campo de búsqueda
        SearchInput(hintText: 'Buscar Usuario...', espacioInferior: true),

        // Botón agregar
        CustomButton(
          texto: 'Agregar Usuario',
          onPressed: () {
            //Lógica aquí
            print('Botón Agregar Usuario Presionado');
          },
        ),

        // Lista de usuarios
        Expanded(
          child: ListUser(
            users: usuarios,
            onTap: (user) {
              //Logica al tocar
              print('Usuario seleccionado: ${user.nombre}');
            },
            onLongPress: (user) {
              //Logica al mantener presionado
              mostrarOpcionesUsuario(context, user);
            },
          ),
        ),
      ],
    );

    // Usar el widget reutilizable
    return BaseScreen(
      titulo: 'Gestión de Usuarios',
      contenido: contenidoPantalla,
      colorHeader: const Color(0xFF4A90E2),
    );
  }
}
