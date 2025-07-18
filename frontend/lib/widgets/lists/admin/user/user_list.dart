import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/utils/role_color.dart';

class ListUser extends StatelessWidget {
  final List<User> users;
  final Function(User)? onEdit;
  final Function(User)? onEditRole;
  final Function(User)? onDelete;

  const ListUser({
    Key? key,
    required this.users,
    this.onEdit,
    this.onEditRole,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      itemCount: users.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final user = users[index];
        return _buildUserCard(user);
      },
    );
  }

  Widget _buildUserCard(User user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameAndRole(user),
          const SizedBox(height: 8),
          _buildCorreoConIconos(user),
          _buildContactInfoWithoutCorreo(user),
          const SizedBox(height: 10),
          _buildSpecialtySection(user),
          const SizedBox(height: 10),
          _buildInsuranceRow(user),
          const SizedBox(height: 6),
          _buildUserId(user),
        ],
      ),
    );
  }

  // ✅ Nombre y Rol en la misma fila
  Widget _buildNameAndRole(User user) {
    return Row(
      children: [
        Expanded(
          child: Text(
            user.nombre,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: getRoleColor(user.rol),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            user.rol ?? 'Sin rol',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ✅ Correo a la izquierda, íconos a la derecha
  Widget _buildCorreoConIconos(User user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            user.correo,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
        if (onEditRole != null)
          IconButton(
            icon: const Icon(Icons.admin_panel_settings, color: Colors.blue),
            tooltip: 'Editar Rol',
            onPressed: () => onEditRole?.call(user),
          ),
        if (onEdit != null)
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.green),
            tooltip: 'Editar',
            onPressed: () => onEdit?.call(user),
          ),
        if (onDelete != null)
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            tooltip: 'Eliminar',
            onPressed: () => onDelete?.call(user),
          ),
      ],
    );
  }

  Widget _buildContactInfoWithoutCorreo(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactText(user.telefono),
        _buildContactText(user.direccion),
      ],
    );
  }

  Widget _buildContactText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
      ),
    );
  }

  Widget _buildSpecialtySection(User user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Especialidad: ${user.especialidad?.nombre ?? "No asignada"}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            (user.especialidad != null &&
                    user.especialidad!.descripcion.isNotEmpty)
                ? user.especialidad!.descripcion
                : 'Sin descripción',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceRow(User user) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'EPS: ${user.suguroSocial ?? 'Sin EPS'}',
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Expanded(
          child: Text(
            'ARL: ${user.arl ?? 'Sin ARL'}',
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildUserId(User user) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'ID: ${user.id}',
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
