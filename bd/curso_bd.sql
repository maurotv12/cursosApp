-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-07-2025 a las 16:21:05
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `curso_bd`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos_adicionales`
--

CREATE TABLE `archivos_adicionales` (
  `id` int(11) NOT NULL,
  `idCurso` int(11) DEFAULT NULL,
  `nombreArchivo` varchar(255) DEFAULT NULL,
  `rutaArchivo` text DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `fechaRegistro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `fechaRegistro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`, `descripcion`, `fechaRegistro`) VALUES
(1, 'Stop Motion', 'La animación en volumen​ o animación fotograma a fotograma​ es una técnica de animación que consiste en aparentar el movimiento de objetos estáticos por medio de una serie de imágenes fijas sucesivas.', '2025-07-14 11:21:58'),
(2, 'Animación 3D', 'La animación 3D usa gráficos por computadora para que parezca que los objetos se mueven en un espacio tridimensional.', '2025-07-14 11:21:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `id` int(11) NOT NULL,
  `urlAmiga` varchar(100) NOT NULL,
  `nombre` varchar(300) NOT NULL,
  `descripcion` text NOT NULL,
  `banner` varchar(300) DEFAULT NULL,
  `promoVideo` varchar(150) DEFAULT NULL,
  `valor` int(11) NOT NULL,
  `idCategoria` int(11) DEFAULT NULL,
  `idPersona` int(11) DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'activo',
  `fechaRegistro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`id`, `urlAmiga`, `nombre`, `descripcion`, `banner`, `promoVideo`, `valor`, `idCategoria`, `idPersona`, `estado`, `fechaRegistro`) VALUES
(1, 'peliculas-y-cortometrajes', 'NIÑOS QUE HACEN PELICULAS Y CORTOMETRAJES EN CALIBELULA', 'Calibélula vivirá un nuevo encuentro con niños y adolescentes, orientados bajo el liderazgo de procesos como La Escuela Audiovisual, Belén de los Andaquies, en el Caquetá, Mi Primer corto Infantil de México y Subí que te veo de Argentina.\r\n', 'App/vistas/img/cursos/1 (1).png', 'videosPromos/PROMO-diverti-motion.mp4', 80000, 2, 1, 'activo', '2025-07-14 16:21:17'),
(2, 'peliculas-y-cortometrajes-en', 'NIÑOS QUE HACEN PELICULAS Y CORTOMETRAJES EN CALIBELULA', 'Calibélula vivirá un nuevo encuentro con niños y adolescentes, orientados bajo el liderazgo de procesos como La Escuela Audiovisual, Belén de los Andaquies, en el Caquetá, Mi Primer corto Infantil de México y Subí que te veo de Argentina.\r\n', 'App/vistas/img/cursos/1 (2).png', 'videosPromos/PROMO-diverti-motion.mp4', 70000, 2, 1, 'activo', '2025-07-14 16:23:59'),
(3, 'talleres-libelulitos', 'Talleres Libelulit@s y convocatoria a realizadores cinematográficos', 'La magia del cine y el audiovisual regresan a Cali para el mundo, a partir del 30 de abril, cuando se hará el lanzamiento oficial del 5º- Festival Internacional de Cine Infantil y Juvenil, Calibélula, con la apertura de la convocatoria dirigida a directores, realizadores y productores para que envíen sus producciones cinematográficas antes del 15 de Junio, a través de Festhome y Google Drive. La convocatoria también estará dirigida a instituciones educativas, niños y jóvenes en general para que participen de los talleres de Libelulit@s que se dictáran gratuitamente a partir del mes de mayo.', 'App/vistas/img/cursos/1 (3).png', 'videosPromos/PROMO-diverti-motion.mp4', 100000, 2, 1, 'activo', '2025-07-14 16:24:30'),
(4, 'curso-php', 'COMO HACER UNA PAGINA WEB', 'Pagina web en PHP y JS', 'App/vistas/img/cursos/1 (5).jpg', 'videosPromos/PROMO-diverti-motion.mp4', 90000, 2, 1, 'activo', '2025-07-14 16:25:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gestionpagos`
--

CREATE TABLE `gestionpagos` (
  `id` int(11) NOT NULL,
  `idInscripcion` int(11) DEFAULT NULL,
  `valorPagado` int(11) NOT NULL,
  `mediodePago` varchar(100) NOT NULL,
  `fechaPago` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fechaRegistro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripciones`
--

CREATE TABLE `inscripciones` (
  `id` int(11) NOT NULL,
  `idCurso` int(11) DEFAULT NULL,
  `idEstudiante` int(11) DEFAULT NULL,
  `estado` varchar(100) DEFAULT 'pendiente',
  `finalizado` tinyint(1) DEFAULT 0,
  `fechaRegistro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_ingreso`
--

CREATE TABLE `log_ingreso` (
  `id` int(11) NOT NULL,
  `usuarioId` int(11) DEFAULT NULL,
  `ipUsuario` varchar(45) DEFAULT NULL,
  `navegador` varchar(255) DEFAULT NULL,
  `fechaR` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `log_ingreso`
--

INSERT INTO `log_ingreso` (`id`, `usuarioId`, `ipUsuario`, `navegador`, `fechaR`) VALUES
(1, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-10 14:18:20'),
(2, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-10 14:37:58'),
(3, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 11:37:56'),
(4, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 11:45:47'),
(5, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 11:51:54'),
(6, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 14:53:20'),
(7, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 14:57:04'),
(8, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 15:05:46'),
(9, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-15 08:23:45'),
(10, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-15 08:26:59'),
(11, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-15 08:42:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id` int(11) NOT NULL,
  `idRemitente` int(11) DEFAULT NULL,
  `idDestinatario` int(11) DEFAULT NULL,
  `asunto` varchar(150) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `leido` tinyint(1) DEFAULT 0,
  `fechaEnvio` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `id` int(11) NOT NULL,
  `usuarioLink` varchar(100) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `verificacion` int(11) NOT NULL DEFAULT 0,
  `foto` varchar(100) DEFAULT 'vistas/img/usuarios/default/default.png',
  `profesion` varchar(300) DEFAULT NULL,
  `telefono` varchar(100) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `perfil` text DEFAULT NULL,
  `Pais` varchar(200) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT 1,
  `fechaRegistro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id`, `usuarioLink`, `nombre`, `email`, `password`, `verificacion`, `foto`, `profesion`, `telefono`, `direccion`, `perfil`, `Pais`, `estado`, `fechaRegistro`) VALUES
(1, 'clienteRegistro', 'Mauricio Muñoz', 'mauriciomuozsanchez12@gmail.com', '$2y$10$XJjXQcSuxiVhdhkovif7B.YfVKNSkVEK2Tl0ZBJa48CDWKY3.r80a', 0, 'vistas/img/usuarios/default/default.png', 'Contador', '3135529157', 'cra26k8121', 'Colombia', 'Colombia', 1, '2025-07-10 19:18:15'),
(2, 'clienteRegistro', 'Derly Pipicano', 'm-mau55@hotmail.com', '$2y$10$AlrkWRiRR2kIBFLn7qA.nux7d6//Va6PB818ZJK7NnrENSAv8a6kS', 0, 'vistas/img/usuarios/default/default.png', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-15 13:42:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona_roles`
--

CREATE TABLE `persona_roles` (
  `idPersona` int(11) NOT NULL,
  `idRol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persona_roles`
--

INSERT INTO `persona_roles` (`idPersona`, `idRol`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `requisitos_curso`
--

CREATE TABLE `requisitos_curso` (
  `id` int(11) NOT NULL,
  `idCurso` int(11) DEFAULT NULL,
  `descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`) VALUES
(1, 'admin'),
(3, 'estudiante'),
(2, 'instructor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secciones`
--

CREATE TABLE `secciones` (
  `id` int(11) NOT NULL,
  `idCurso` int(11) DEFAULT NULL,
  `nombre` varchar(300) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `duracion` varchar(100) DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL,
  `tipo` varchar(200) DEFAULT NULL,
  `fechaRegistro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `secciones`
--

INSERT INTO `secciones` (`id`, `idCurso`, `nombre`, `descripcion`, `duracion`, `url`, `tipo`, `fechaRegistro`) VALUES
(1, NULL, 'PROMOCIONAL Diverti Motion', 'PROMOCIONAL Diverti Motion', '28 Segundos', 'videosPromos/PROMO-diverti-motion.mp4', 'video', '2025-07-14 16:35:16'),
(2, NULL, 'PROMOCIONAL Diverti Motion', 'PROMOCIONAL Diverti Motion', '28 Segundos', 'videosPromos/PROMO-diverti-motion.mp4', 'Video', '2025-07-14 16:35:16');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `archivos_adicionales`
--
ALTER TABLE `archivos_adicionales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCurso` (`idCurso`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCategoria` (`idCategoria`),
  ADD KEY `idPersona` (`idPersona`);

--
-- Indices de la tabla `gestionpagos`
--
ALTER TABLE `gestionpagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idInscripcion` (`idInscripcion`);

--
-- Indices de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCurso` (`idCurso`),
  ADD KEY `idEstudiante` (`idEstudiante`);

--
-- Indices de la tabla `log_ingreso`
--
ALTER TABLE `log_ingreso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuarioId` (`usuarioId`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idRemitente` (`idRemitente`),
  ADD KEY `idDestinatario` (`idDestinatario`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `persona_roles`
--
ALTER TABLE `persona_roles`
  ADD PRIMARY KEY (`idPersona`,`idRol`),
  ADD KEY `idRol` (`idRol`);

--
-- Indices de la tabla `requisitos_curso`
--
ALTER TABLE `requisitos_curso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCurso` (`idCurso`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `secciones`
--
ALTER TABLE `secciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCurso` (`idCurso`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `archivos_adicionales`
--
ALTER TABLE `archivos_adicionales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `gestionpagos`
--
ALTER TABLE `gestionpagos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `log_ingreso`
--
ALTER TABLE `log_ingreso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `requisitos_curso`
--
ALTER TABLE `requisitos_curso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `secciones`
--
ALTER TABLE `secciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `archivos_adicionales`
--
ALTER TABLE `archivos_adicionales`
  ADD CONSTRAINT `archivos_adicionales_ibfk_1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`id`);

--
-- Filtros para la tabla `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`id`),
  ADD CONSTRAINT `curso_ibfk_2` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`id`);

--
-- Filtros para la tabla `gestionpagos`
--
ALTER TABLE `gestionpagos`
  ADD CONSTRAINT `gestionpagos_ibfk_1` FOREIGN KEY (`idInscripcion`) REFERENCES `inscripciones` (`id`);

--
-- Filtros para la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  ADD CONSTRAINT `inscripciones_ibfk_1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`id`),
  ADD CONSTRAINT `inscripciones_ibfk_2` FOREIGN KEY (`idEstudiante`) REFERENCES `persona` (`id`);

--
-- Filtros para la tabla `log_ingreso`
--
ALTER TABLE `log_ingreso`
  ADD CONSTRAINT `log_ingreso_ibfk_1` FOREIGN KEY (`usuarioId`) REFERENCES `persona` (`id`);

--
-- Filtros para la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`idRemitente`) REFERENCES `persona` (`id`),
  ADD CONSTRAINT `mensajes_ibfk_2` FOREIGN KEY (`idDestinatario`) REFERENCES `persona` (`id`);

--
-- Filtros para la tabla `persona_roles`
--
ALTER TABLE `persona_roles`
  ADD CONSTRAINT `persona_roles_ibfk_1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`id`),
  ADD CONSTRAINT `persona_roles_ibfk_2` FOREIGN KEY (`idRol`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `requisitos_curso`
--
ALTER TABLE `requisitos_curso`
  ADD CONSTRAINT `requisitos_curso_ibfk_1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`id`);

--
-- Filtros para la tabla `secciones`
--
ALTER TABLE `secciones`
  ADD CONSTRAINT `secciones_ibfk_1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
