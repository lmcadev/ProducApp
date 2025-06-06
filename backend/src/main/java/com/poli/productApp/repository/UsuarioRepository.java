package com.poli.productApp.repository;

import com.poli.productApp.model.usuario.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;


public interface UsuarioRepository extends JpaRepository<Usuario, Long> {


    Optional<Usuario> findByCorreo(String correo);
    Optional<Usuario> findById(Long id);
    boolean existsByCorreo(String correo);
    boolean existsById(Long id);
    void deleteById(Long id);


    
}

