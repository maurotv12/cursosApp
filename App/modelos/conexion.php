<?php

/**
@grcarvajal grcarvajal@gmail.com **Gildardo Restrepo Carvajal**
12/06/2022 Plataforma Calibelula mostrar Cursos
 */
class Conexion
{

	public static function conectar()
	{
		$link = new PDO(
			"mysql:host=localhost;dbname=cursoo_bd_ac",
			"root",
			""
		);
		$link->exec("set names utf8");
		return $link;

		// Datos de hosting
		// $link = new PDO("mysql:host=localhost;dbname=calibelu_b3luFesC4l1",
		// 			"calibelu_c4l1b3",
		// 			"aB@E%yGVcos");
		//$link->exec("set names utf8");
		//return $link;
	}
}
