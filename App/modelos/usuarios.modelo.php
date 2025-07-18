<?php

/**
@grcarvajal grcarvajal@gmail.com **Gildardo Restrepo Carvajal**
26/04/2022 aplicación PAWers citas de acompañamiento con mascotas
Modelo de usuarios login, registro y recuperar contraseña
 */
require_once "conexion.php";

class ModeloUsuarios

{

	/*=============================================
	Registro de usuarios
=============================================*/
	public static function mdlRegistroUsuario($tabla, $datos)
	{
		$foto = "vistas/img/usuarios/default/default.png";
		$estado = 1;
		$stmt = Conexion::conectar()->prepare("INSERT INTO $tabla(`usuarioLink`, `nombre`, `email`, `password`, `verificacion`, `foto`, `estado`) VALUES (:usuarioLink, :nombre, :email, :password, :verificacion, :foto, :estado)");
		$stmt->bindParam(":usuarioLink", $datos["usuario"], PDO::PARAM_STR);
		$stmt->bindParam(":nombre", $datos["nombre"], PDO::PARAM_STR);
		$stmt->bindParam(":email", $datos["email"], PDO::PARAM_STR);
		$stmt->bindParam(":password", $datos["password"], PDO::PARAM_STR);
		$stmt->bindParam(":verificacion", $datos["verificacion"], PDO::PARAM_STR);
		$stmt->bindParam(":foto", $foto, PDO::PARAM_STR);
		$stmt->bindParam(":estado", $estado, PDO::PARAM_STR);
		if ($stmt->execute()) {
			return "ok";
		} else {
			return print_r(Conexion::conectar()->errorInfo());
		}
		$stmt->close();
		$stmt = null;
	}

	/*================================================================
	Registro de log de login ingreso del cliente a la aplicacion
=================================================================*/
	public static function mdlRegistroIngresoUsuarios($idU, $navU, $ipU)
	{
		$tabla = "log_ingreso";
		$stmt = Conexion::conectar()->prepare("INSERT INTO $tabla (id_persona, navegador, ip_usuario) VALUES (:idU, :navU, :ipU)");
		$stmt->bindParam(":idU", $idU, PDO::PARAM_INT);
		$stmt->bindParam(":navU", $navU, PDO::PARAM_STR);
		$stmt->bindParam(":ipU", $ipU, PDO::PARAM_STR);
		$stmt->execute();
		return print_r("Ingresando....");
		$stmt->close();
		$stmt = null;
	}


	/*=============================================
	Mostrar Usuarios
==============================================*/

	public static function mdlMostrarUsuarios($tabla, $item, $valor)
	{
		if ($item != null && $valor != null) {
			$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE $item = :$item");
			$stmt->bindParam(":" . $item, $valor, PDO::PARAM_STR);
			$stmt->execute();
			return $stmt->fetch();
		} else {
			$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla");
			$stmt->execute();
			return $stmt->fetchAll();
		}
		$stmt->close();
		$stmt = null;
	}

	/*=============================================
	Actualizar usuario
	=============================================*/

	public static function mdlActualizarUsuario($tabla, $id, $item, $valor)
	{
		$stmt = Conexion::conectar()->prepare("UPDATE $tabla SET $item = :$item WHERE id = :id_usuario");

		$stmt->bindParam(":" . $item, $valor, PDO::PARAM_STR);
		$stmt->bindParam(":id_usuario", $id, PDO::PARAM_INT);
		if ($stmt->execute()) {
			return "ok";
		} else {
			return print_r(Conexion::conectar()->errorInfo());
		}
		$stmt->close();

		$stmt = null;
	}

	/*=============================================
Actualizar usuario completar datos perfil
=============================================*/
	public static function mdlActualizarPerfilUsuario($tabla, $datos)
	{

		$stmt = Conexion::conectar()->prepare("UPDATE $tabla SET nombre = :nombre, email = :email, pais = :pais, ciudad = :ciudad, contenido = :contenido WHERE id = :idUsuario");

		$stmt->bindParam(":nombre", $datos["nombre"], PDO::PARAM_STR);
		$stmt->bindParam(":email", $datos["email"], PDO::PARAM_STR);
		$stmt->bindParam(":pais", $datos["pais"], PDO::PARAM_STR);
		$stmt->bindParam(":ciudad", $datos["ciudad"], PDO::PARAM_STR);
		$stmt->bindParam(":contenido", $datos["contenido"], PDO::PARAM_STR);
		$stmt->bindParam(":idUsuario", $datos["id"], PDO::PARAM_INT);
		if ($stmt->execute()) {
			return "ok";
		} else {
			return print_r(Conexion::conectar()->errorInfo());
		}
		$stmt->close();
		$stmt = null;
	}
	public static function mdlActualizarRol($idPersona, $nuevoRol)
	{
		$conexion = Conexion::conectar();

		// 1. Obtener el ID del rol por nombre
		$stmtRol = $conexion->prepare("SELECT id FROM roles WHERE nombre = :nombre");
		$stmtRol->bindParam(":nombre", $nuevoRol, PDO::PARAM_STR);
		$stmtRol->execute();
		$rol = $stmtRol->fetch(PDO::FETCH_ASSOC);

		if (!$rol) {
			return false; // El rol no existe
		}

		$idRol = $rol["id"];

		// 2. Eliminar roles anteriores (si solo se permite un rol por persona)
		$stmtDelete = $conexion->prepare("DELETE FROM persona_roles WHERE id_persona = :idPersona");
		$stmtDelete->bindParam(":idPersona", $idPersona, PDO::PARAM_INT);
		$stmtDelete->execute();

		// 3. Insertar nuevo rol
		$stmtInsert = $conexion->prepare("INSERT INTO persona_roles (id_persona, id_rol) VALUES (:idPersona, :idRol)");
		$stmtInsert->bindParam(":idPersona", $idPersona, PDO::PARAM_INT);
		$stmtInsert->bindParam(":idRol", $idRol, PDO::PARAM_INT);

		return $stmtInsert->execute();
	}
}
