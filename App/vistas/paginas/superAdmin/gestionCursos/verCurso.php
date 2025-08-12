<?php
// Iniciar sesión una sola vez al principio
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Verificar acceso (administradores o profesores)
if (!ControladorGeneral::ctrUsuarioTieneAlgunRol(['admin', 'superadmin', 'profesor'])) {
    echo '<div class="alert alert-danger">No tienes permisos para acceder a esta página.</div>';
    return;
}

require_once "controladores/cursos.controlador.php";

// Obtener el identificador del curso de la URL (puede ser ID o URL amigable)
$identificadorCurso = isset($_GET['identificador']) ? $_GET['identificador'] : (isset($_GET['id']) ? $_GET['id'] : null);

if (!$identificadorCurso) {
    echo '<div class="alert alert-danger">Curso no encontrado.</div>';
    return;
}

// Usar el controlador para cargar todos los datos necesarios
$datosVisualizacion = ControladorCursos::ctrCargarEdicionCurso($identificadorCurso);

// Verificar si hubo error
if ($datosVisualizacion['error']) {
    echo '<div class="alert alert-danger">' . $datosVisualizacion['mensaje'] . '</div>';
    return;
}

// Extraer los datos para la vista
$curso = $datosVisualizacion['curso'];
$categorias = $datosVisualizacion['categorias'];
$profesores = $datosVisualizacion['profesores'];
$secciones = $datosVisualizacion['secciones'];
$contenidoSecciones = $datosVisualizacion['contenidoSecciones'];

// Verificar permisos de profesor (solo puede ver sus propios cursos)
$esProfesor = ControladorGeneral::ctrUsuarioTieneAlgunRol(['profesor']);
$esAdmin = ControladorGeneral::ctrUsuarioTieneAlgunRol(['admin', 'superadmin']);

if ($esProfesor && !$esAdmin && $curso['id_persona'] != $_SESSION['idU']) {
    echo '<div class="alert alert-danger">No tienes permisos para ver este curso.</div>';
    return;
}

// Obtener datos del profesor y categoría
$profesor = null;
$categoria = null;

foreach ($profesores as $prof) {
    if ($prof['id'] == $curso['id_persona']) {
        $profesor = $prof;
        break;
    }
}

foreach ($categorias as $cat) {
    if ($cat['id'] == $curso['id_categoria']) {
        $categoria = $cat;
        break;
    }
}

// Incluir CSS para la página
echo '<link rel="stylesheet" href="/cursosApp/App/vistas/assets/css/pages/verCurso.css?v=' . time() . '">';
?>

<!-- Vista del curso -->
<div class="ver-curso-container">
    <!-- Header del curso -->
    <div class="curso-header">
        <div class="row align-items-center">
            <div class="col-md-8">
                <div class="breadcrumb-custom">
                    <?php if ($esAdmin): ?>
                        <a href="/cursosApp/App/listadoCursos" class="breadcrumb-link">
                            <i class="bi bi-arrow-left"></i> Volver al listado
                        </a>
                    <?php else: ?>
                        <a href="/cursosApp/App/profesores/gestionCursosPr/listadoCursosProfe" class="breadcrumb-link">
                            <i class="bi bi-arrow-left"></i> Volver a mis cursos
                        </a>
                    <?php endif; ?>
                </div>
                <h1 class="curso-titulo"><?= htmlspecialchars($curso['nombre']) ?></h1>
                <div class="curso-meta">
                    <span class="badge badge-categoria"><?= htmlspecialchars($categoria['nombre'] ?? 'Sin categoría') ?></span>
                    <span class="badge badge-estado badge-<?= $curso['estado'] ?>"><?= htmlspecialchars($curso['estado']) ?></span>
                    <span class="curso-precio">$<?= number_format($curso['valor'] ?? 0, 0, ',', '.') ?></span>
                </div>
            </div>
            <div class="col-md-4 text-end">
                <?php if ($esAdmin || ($esProfesor && $curso['id_persona'] == $_SESSION['idU'])): ?>
                    <a href="/cursosApp/App/<?= $esAdmin ? 'editarCurso' : 'editarCursoProfe' ?>/<?= $curso['url_amiga'] ?>"
                        class="btn btn-primary">
                        <i class="bi bi-pencil"></i> Editar Curso
                    </a>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Video principal y contenido -->
        <div class="col-lg-8">
            <div class="video-container">
                <?php if (!empty($curso['promo_video'])): ?>
                    <div class="video-wrapper">
                        <video id="videoPlayer" controls class="main-video">
                            <source src="<?= $curso['promo_video'] ?>" type="video/mp4">
                            Tu navegador no soporta videos.
                        </video>
                        <div class="video-overlay">
                            <div class="video-title">Video promocional</div>
                        </div>
                    </div>
                <?php elseif (!empty($curso['banner'])): ?>
                    <div class="image-wrapper">
                        <img src="<?= $curso['banner'] ?>" alt="Banner del curso" class="main-image">
                        <div class="image-overlay">
                            <div class="image-title">Vista previa del curso</div>
                        </div>
                    </div>
                <?php else: ?>
                    <div class="placeholder-wrapper">
                        <div class="placeholder-content">
                            <i class="bi bi-play-circle"></i>
                            <p>Sin contenido multimedia</p>
                        </div>
                    </div>
                <?php endif; ?>
            </div>

            <!-- Información del curso -->
            <div class="curso-info">
                <div class="info-tabs">
                    <ul class="nav nav-tabs" id="cursoTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="descripcion-tab" data-bs-toggle="tab"
                                data-bs-target="#descripcion" type="button" role="tab">
                                Descripción
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="aprendizaje-tab" data-bs-toggle="tab"
                                data-bs-target="#aprendizaje" type="button" role="tab">
                                Lo que aprenderás
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="requisitos-tab" data-bs-toggle="tab"
                                data-bs-target="#requisitos" type="button" role="tab">
                                Requisitos
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="profesor-tab" data-bs-toggle="tab"
                                data-bs-target="#profesor" type="button" role="tab">
                                Instructor
                            </button>
                        </li>
                    </ul>
                    <div class="tab-content" id="cursoTabsContent">
                        <div class="tab-pane fade show active" id="descripcion" role="tabpanel">
                            <div class="content-section">
                                <h5>Acerca de este curso</h5>
                                <p><?= nl2br(htmlspecialchars($curso['descripcion'])) ?></p>

                                <?php if (!empty($curso['para_quien'])): ?>
                                    <h6>¿Para quién es este curso?</h6>
                                    <ul class="lista-puntos">
                                        <?php foreach (explode("\n", $curso['para_quien']) as $punto): ?>
                                            <?php if (trim($punto)): ?>
                                                <li><?= htmlspecialchars(trim($punto)) ?></li>
                                            <?php endif; ?>
                                        <?php endforeach; ?>
                                    </ul>
                                <?php endif; ?>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="aprendizaje" role="tabpanel">
                            <div class="content-section">
                                <h5>Al finalizar este curso serás capaz de:</h5>
                                <?php if (!empty($curso['lo_que_aprenderas'])): ?>
                                    <ul class="lista-aprendizaje">
                                        <?php foreach (explode("\n", $curso['lo_que_aprenderas']) as $punto): ?>
                                            <?php if (trim($punto)): ?>
                                                <li>
                                                    <i class="bi bi-check-circle"></i>
                                                    <?= htmlspecialchars(trim($punto)) ?>
                                                </li>
                                            <?php endif; ?>
                                        <?php endforeach; ?>
                                    </ul>
                                <?php else: ?>
                                    <p class="text-muted">No se han definido objetivos de aprendizaje.</p>
                                <?php endif; ?>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="requisitos" role="tabpanel">
                            <div class="content-section">
                                <h5>Requisitos y conocimientos previos</h5>
                                <?php if (!empty($curso['requisitos'])): ?>
                                    <ul class="lista-requisitos">
                                        <?php foreach (explode("\n", $curso['requisitos']) as $requisito): ?>
                                            <?php if (trim($requisito)): ?>
                                                <li>
                                                    <i class="bi bi-arrow-right"></i>
                                                    <?= htmlspecialchars(trim($requisito)) ?>
                                                </li>
                                            <?php endif; ?>
                                        <?php endforeach; ?>
                                    </ul>
                                <?php else: ?>
                                    <p class="text-muted">Este curso no requiere conocimientos previos específicos.</p>
                                <?php endif; ?>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="profesor" role="tabpanel">
                            <div class="content-section">
                                <div class="profesor-info">
                                    <div class="profesor-avatar">
                                        <img src="<?= $profesor['foto'] ?? '/cursosApp/App/vistas/assets/images/default-avatar.png' ?>"
                                            alt="Foto del profesor" class="avatar-img">
                                    </div>
                                    <div class="profesor-datos">
                                        <h5><?= htmlspecialchars($profesor['nombre'] ?? 'Instructor no especificado') ?></h5>
                                        <p class="profesor-email"><?= htmlspecialchars($profesor['email'] ?? '') ?></p>
                                        <!-- Aquí podrías agregar más información del profesor -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sidebar con contenido del curso -->
        <div class="col-lg-4">
            <div class="curso-sidebar">
                <div class="sidebar-header-content">
                    <h4>Contenido del curso</h4>
                    <div class="curso-stats">
                        <span class="stat-item">
                            <i class="bi bi-collection"></i>
                            <?= count($secciones) ?> secciones
                        </span>
                        <span class="stat-item">
                            <i class="bi bi-clock"></i>
                            <!-- Aquí podrías calcular la duración total -->
                            Duración variable
                        </span>
                    </div>
                </div>

                <div class="contenido-lista">
                    <?php if (!empty($secciones)): ?>
                        <div class="accordion" id="seccionesAccordion">
                            <?php foreach ($secciones as $index => $seccion): ?>
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="heading<?= $seccion['id'] ?>">
                                        <button class="accordion-button <?= $index === 0 ? '' : 'collapsed' ?>"
                                            type="button" data-bs-toggle="collapse"
                                            data-bs-target="#collapse<?= $seccion['id'] ?>"
                                            aria-expanded="<?= $index === 0 ? 'true' : 'false' ?>">
                                            <div class="seccion-header">
                                                <span class="seccion-titulo"><?= htmlspecialchars($seccion['titulo']) ?></span>
                                                <span class="seccion-count">
                                                    <?= count($contenidoSecciones[$seccion['id']] ?? []) ?> elementos
                                                </span>
                                            </div>
                                        </button>
                                    </h2>
                                    <div id="collapse<?= $seccion['id'] ?>"
                                        class="accordion-collapse collapse <?= $index === 0 ? 'show' : '' ?>"
                                        data-bs-parent="#seccionesAccordion">
                                        <div class="accordion-body">
                                            <?php if (!empty($seccion['descripcion'])): ?>
                                                <p class="seccion-descripcion"><?= htmlspecialchars($seccion['descripcion']) ?></p>
                                            <?php endif; ?>

                                            <?php if (isset($contenidoSecciones[$seccion['id']]) && !empty($contenidoSecciones[$seccion['id']])): ?>
                                                <div class="contenido-items">
                                                    <?php foreach ($contenidoSecciones[$seccion['id']] as $contenido): ?>
                                                        <div class="contenido-item" data-tipo="<?= $contenido['tipo'] ?>"
                                                            data-url="<?= $contenido['archivo_url'] ?>">
                                                            <div class="item-icon">
                                                                <?php if ($contenido['tipo'] === 'video'): ?>
                                                                    <i class="bi bi-play-circle"></i>
                                                                <?php elseif ($contenido['tipo'] === 'documento'): ?>
                                                                    <i class="bi bi-file-earmark-text"></i>
                                                                <?php else: ?>
                                                                    <i class="bi bi-file"></i>
                                                                <?php endif; ?>
                                                            </div>
                                                            <div class="item-info">
                                                                <span class="item-titulo"><?= htmlspecialchars($contenido['titulo']) ?></span>
                                                                <?php if ($contenido['duracion']): ?>
                                                                    <span class="item-duracion"><?= htmlspecialchars($contenido['duracion']) ?></span>
                                                                <?php endif; ?>
                                                            </div>
                                                            <div class="item-action">
                                                                <button class="btn-preview" onclick="reproducirContenido('<?= $contenido['archivo_url'] ?>', '<?= $contenido['tipo'] ?>', '<?= htmlspecialchars($contenido['titulo']) ?>')">
                                                                    <i class="bi bi-eye"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    <?php endforeach; ?>
                                                </div>
                                            <?php else: ?>
                                                <p class="text-muted">Esta sección aún no tiene contenido.</p>
                                            <?php endif; ?>
                                        </div>
                                    </div>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    <?php else: ?>
                        <div class="empty-content">
                            <i class="bi bi-collection"></i>
                            <h6>Sin contenido disponible</h6>
                            <p>Este curso aún no tiene secciones de contenido configuradas.</p>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Incluir JavaScript para la página -->
<script src="/cursosApp/App/vistas/assets/js/pages/verCurso.js?v=<?= time() ?>"></script>