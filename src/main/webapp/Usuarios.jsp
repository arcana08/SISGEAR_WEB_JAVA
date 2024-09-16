<%@include file="header.jsp" %>
<!DOCTYPE html>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>USUARIOS</title>
    <link rel="stylesheet" href="css/estilos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/jquery.dataTables.min.css"> 
</head>

<body>
    <div class="container text-center">
        <div class="row">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="col-form-label">LISTADO DE USUARIOS</h1>
                <div>
                    <div class="search-bar">
                        <input type="text" class="form-control" id="buscador" placeholder="Buscar...">
                        <button class="btn btn-success btn-add" id="nuevo" data-bs-toggle="modal" data-bs-target="#exampleModal1" title="Agregar Nuevo">
                            <i class="fas fa-plus"></i> AGREGAR
                        </button>
                        <a class="btn btn-primary btn-print" id="imprimir" href="reportesv/Rusuarios.jsp" target="_blank" title="Imprimir Reporte">
                            <i class="fas fa-print"></i> IMPRIMIR
                        </a>
                    </div>
                </div>
            </div>
            <table class="table table-striped" id="resultado">
                <thead>
                    <tr>
                        <th>CODIGO</th>
                        <th>USUARIO</th>
                        <th>NOMBRE Y APELLIDO</th>
                        <th>CI</th>
                        <th>ROL</th>
                        <th>ACCION</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- resultado del slect  -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- carga datos -->
    <div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="max-width: 600px;">
            <div class="modal-content">
                <form id="form">
                    <div class="modal-header">
                        <h1 class="col-form-label">FORMULARIO DE USUARIOS</h1>
                        <input type="hidden" id="listar" name="listar" value="cargar">
                        <input type="hidden" id="pkid" name="pkid" value="">
                    </div>
                    <div class="modal-body">
                        <div class="form-group row">
                            <label for="nombre" class="col-sm-4 col-form-label text-sm-right">NOMBRE DE USUARIO</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="nombre" id="nombre" placeholder="Nombre">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="nombre" class="col-sm-4 col-form-label text-sm-right">CLAVE</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="clave" id="clave" placeholder="***">
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="pais" class="col-sm-4 col-form-label text-sm-right">PERSONA</label>
                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input type="hidden" class="form-control" name="per" id="per" placeholder="click para asignar">
                                    <input data-bs-target="#exampleModal2" data-bs-toggle="modal" type="text" class="form-control" name="nper" id="nper" onclick="" placeholder="click para asignar" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="pais" class="col-sm-4 col-form-label text-sm-right">ROL</label>
                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input type="hidden" class="form-control" name="rol" id="rol" placeholder="click para asignar">
                                    <input data-bs-target="#exampleModal3" data-bs-toggle="modal" type="text" class="form-control" name="nrol" id="nrol" onclick="" placeholder="click para asignar" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                <div id="mensaje"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">CANCELAR</button>
                    <input type="button" class="btn btn-success" id="boton" value="PROCESAR">
                </div>
            </div>
        </div>
    </div>
    <!-- lista -->
    <div class="modal fade" id="exampleModal2" aria-hidden="true" aria-labelledby="exampleModal2" tabindex="-1">
        <div class="modal-dialog">
            <div class="row">
                <div class="modal-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1 class="col-form-label">LISTADO DE PERSONAS</h1>
                        <div>
                            <div class="search-bar">
                                <input type="text" class="form-control" id="buscadorp" placeholder="Buscar...">
                                <button class="btn btn-success btn-add" data-bs-toggle="modal" id="salirpais"  data-bs-target="#exampleModal1" title="volver al formulario">
                                    <i class="fas fa-times"></i> cancelar
                                </button>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped" id="resultadop">
                        <thead>
                            <tr>
                                <th>CODIGO</th>
                                <th>NOMBRE</th>
                                <th>CI</th>
                                <th>SELECCIONAR</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="exampleModal3" aria-hidden="true" aria-labelledby="exampleModal3" tabindex="-1">
        <div class="modal-dialog">
            <div class="row">
                <div class="modal-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1 class="col-form-label">LISTADO DE ROLES</h1>
                        <div>
                            <div class="search-bar">
                                <input type="text" class="form-control" id="buscadorpp" placeholder="Buscar...">
                                <button class="btn btn-success btn-add" data-bs-toggle="modal" id="salirpais"  data-bs-target="#exampleModal1" title="volver al formulario">
                                    <i class="fas fa-times"></i> cancelar
                                </button>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped" id="resultadopp">
                        <thead>
                            <tr>
                                <th>CODIGO</th>
                                <th>ROL</th>
                                <th>SELECCIONAR</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- eliminar dtos -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">ELIMINAR REGISTRO</h5>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="listare" name="listare" value="eliminar">
                    <input type="hidden" id="iedit" name="iedit" value="">
                    EN VERDAD DESEA ELIMINAR EL REGISTRO?
                </div>
                <div id="mensaje2"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">CANCELAR</button>
                    <button type="button" class="btn btn-primary" id="btneliminar" >ELIMINAR</button>
                </div>
            </div>
        </div>
    </div>
</body>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

<script>
    $(document).ready(function () {
        rellenardatos();
        rellenardatosp();
        rellenardatospp();

        $("#boton").on('click', function () {
            procesarFormulario();
        });
        $("#nuevo").on('click', function () {
            resetFormulario();
        });
        $("#btneliminar").on('click', function () {
            eliminarRegistro();
        });

        $("#buscador").on('keyup', function () {
            var value = $(this).val().toLowerCase();
            $("#resultado tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });

        $("#buscadorp").on('keyup', function () {
            var value = $(this).val().toLowerCase();
            $("#resultadop tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
        
        $("#buscadorpp").on('keyup', function () {
            var value = $(this).val().toLowerCase();
            $("#resultadopp tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
    });

    function rellenardatos() {
        $.ajax({
            data: {listar: 'listar'},
            url: 'jsp/usuarios.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultado tbody").html(response);
            }
        });
    }

    function procesarFormulario() {
        var nombre = $("#nombre").val().trim();
        var clave = $("#clave").val().trim();
        var rol = $("#rol").val().trim();
        var per = $("#per").val().trim();
        var tt = /^[a-zA-Z0-9 _ñÑ]+$/; 
        if (!tt.test(nombre) || !tt.test(clave)) {
            $("#mensaje").html('<div class="alert alert-danger" role="alert">Por favor, utiliza solo caracteres alfanuméricos o guiones bajos</div>');
            setTimeout(function () {
                $("#mensaje").html("");
            }, 3000);
            return;
        }
        if (nombre === '' || clave === ''|| per === ''|| rol === '') {
            $("#mensaje").html('<div class="alert alert-danger" role="alert">Por favor, completa todos los campos antes de enviar.</div>');
            setTimeout(function () {
                $("#mensaje").html("");
            }, 2000);
            return;
        }
        var formdata = $("#form").serialize();
        $.ajax({
            data: formdata,
            url: 'jsp/usuarios.jsp',
            type: 'post',
            success: function (response) {
                $("#mensaje").html(response);
                if (response.indexOf("Los datos ya existen") !== -1) {
                    setTimeout(function () {
                        $("#mensaje").html("");
                    }, 2000);
                }else {
                    rellenardatos();
                    resetFormulario();
                    setTimeout(function () {
                        $("#exampleModal1").modal('hide');
                        $("#mensaje").html("");
                    }, 2000);
                }
            }
        });
    }

    function eliminarRegistro() {
        var listare = $("#listare").val().trim();
        var pk = $("#iedit").val().trim();
        $.ajax({
            data: {listar: listare, pk: pk},
            url: 'jsp/usuarios.jsp',
            type: 'post',
            success: function (response) {
                $("#mensaje2").html(response);
                if (response.indexOf("Los datos son utilizados en otra tabla") !== -1) {
                    setTimeout(function () {
                        $("#mensaje2").html("");
                    }, 3000);
                } else {
                    rellenardatos();
                    setTimeout(function () {
                        $("#exampleModal").modal('hide');
                        $("#mensaje2").html("");
                    }, 2000);
                }
            }
        });
    }

    function resetFormulario() {
        $("#listar").val("cargar");
        $("#pkid").val("");
        $("#nombre").val("");
        $("#clave").val("");
        $("#per").val("");
        $("#nper").val("");
        $("#rol").val("");
        $("#nrol").val("");
    }

    function rellenarjs(u1,u2,u3,p1,p2,p3,r1,r2) {
        $("#pkid").val(u1);
        $("#nombre").val(u2);
        $("#clave").val(u3);
        $("#per").val(p1);
        $("#nper").val(p2+"-"+p3);
        $("#rol").val(r1);
        $("#nrol").val(r2);
        $("#listar").val("modificar");
    }
    function rellenardatosp() {
        $.ajax({
            data: {listar: 'listarp'},
            url: 'jsp/usuarios.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultadop tbody").html(response);
            }
        });
    }
    function rellenarjsp(b, c, a) {
        $("#per").val(b);
        $("#nper").val(c+"-"+a);
    }
    function rellenardatospp() {
        $.ajax({
            data: {listar: 'listarpp'},
            url: 'jsp/usuarios.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultadopp tbody").html(response);
            }
        });
    }
    function rellenarjspp(b, c) {
        $("#rol").val(b);
        $("#nrol").val(c);
    }
</script>

<%@include file="footer.jsp" %>