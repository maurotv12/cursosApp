<?php

/**
@grcarvajal grcarvajal@gmail.com **Gildardo Restrepo Carvajal**
26/05/2022 Plataforma Cursos Registro
 */

require_once $_SERVER['DOCUMENT_ROOT'] . "/cursosapp/publico/controladores/ruta.controlador.php";
require_once $_SERVER['DOCUMENT_ROOT'] . "/cursosapp/App/controladores/usuarios.controlador.php";


////Modelos
require_once $_SERVER['DOCUMENT_ROOT'] . "/cursosapp/App/modelos/usuarios.modelo.php";

$plantilla = new ControladorRuta();
$plantilla->ctrPlantilla();
