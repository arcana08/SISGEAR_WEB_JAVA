<%@include file="header.jsp" %>
<!DOCTYPE html>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PAISES</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/jquery.dataTables.min.css"> 
    <link rel="stylesheet" href="css/estilos.css">
</head>

<body>
    <div class="container text-center">
        <div class="row">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="col-form-label">LISTADO DE PAISES</h1>
                <div>
                    <div class="search-bar">
                        <input type="text" class="form-control" id="buscador" placeholder="Buscar...">
                        <button class="btn btn-success btn-add" id="nuevo" data-bs-toggle="modal" data-bs-target="#exampleModal1" title="Agregar Nuevo">
                            <i class="fas fa-plus"></i> AGREGAR
                        </button>
                        <a class="btn btn-primary btn-print" id="imprimir" href="reportesv/Rpaises.jsp" target="_blank" title="Imprimir Reporte">
                            <i class="fas fa-print"></i> IMPRIMIR
                        </a>
                    </div>
                </div>
            </div>
            <table class="table table-striped" id="resultado">
                <thead>
                    <tr>
                        <th>CODIGO</th>
                        <th>PAIS</th>
                        <th>ACCION</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="max-width: 600px;">
            <div class="modal-content">
                <form id="form">
                    <div class="modal-header">
                        <h1 class="col-form-label">FORMULARIO DE PAISES</h1>
                        <input type="hidden" id="listar" name="listar" value="cargar">
                        <input type="hidden" id="pkid" name="pkid" value="">
                    </div>
                    <div class="modal-body">
                        <div class="form-group row">
                            <label for="datos" class="col-sm-4 col-form-label">PAIS</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="nombre" id="nombre" placeholder="Nombre">
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
    });

    function rellenardatos() {
        $.ajax({
            data: {listar: 'listar'},
            url: 'jsp/paises.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultado tbody").html(response);
            }
        });
    }

    function procesarFormulario() {
        var nombre = $("#nombre").val().trim();
        if (nombre === '') {
            $("#mensaje").html('<div class="alert alert-danger" role="alert">Por favor, completa todos los campos antes de enviar.</div>');
            setTimeout(function () {
                $("#mensaje").html("");
            }, 2000);
            return;
        }
        var formdata = $("#form").serialize();
        $.ajax({
            data: formdata,
            url: 'jsp/paises.jsp',
            type: 'post',
            success: function (response) {
                $("#mensaje").html(response);
                if (response.indexOf("Los datos ya existen") !== -1) {
                    setTimeout(function () {
                        $("#mensaje").html("");
                    }, 2000);
                } else {
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
            url: 'jsp/paises.jsp',
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
    }

    function rellenarjs(a, b) {
        $("#pkid").val(a);
        $("#nombre").val(b);
        $("#listar").val("modificar");
    }
</script>

<%@include file="footer.jsp" %>