<%@include file="header.jsp" %>
<!DOCTYPE html>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ARMAS</title>
    <link rel="stylesheet" href="css/estilos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/jquery.dataTables.min.css"> 
</head>

<body>
    <div class="container text-center">
        <div class="row">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="col-form-label">LISTADO DE ARMAS</h1>
                <div>
                    <div class="search-bar">
                        <input type="text" class="form-control" id="buscador" placeholder="Buscar...">
                        <button class="btn btn-success btn-add" id="nuevo" data-bs-toggle="modal" data-bs-target="#exampleModal1" title="Agregar Nuevo">
                            <i class="fas fa-plus"></i> AGREGAR
                        </button>
                    </div>
                </div>
            </div>
            <table class="table table-striped" id="resultado">
                <thead>
                    <tr>
                        <th>CODIGO</th>
                        <th>CLASIFICACION</th>
                        <th>TIPO</th>
                        <th>CALIBRE</th>
                        <th>MARCA</th>
                        <th>MODELO</th>
                        <th>SERIE</th>
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
                        <h1 class="col-form-label">FORMULARIO DE ARMAS</h1>
                        <input type="hidden" id="listar" name="listar" value="cargar">
                        <input type="hidden" id="pkid" name="pkid" value="">
                    </div>
                    <div class="modal-body">
                        <div class="form-group row">
                            <label for="nombre" class="col-sm-4 col-form-label text-sm-right">SERIE</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="nombre" id="nombre" placeholder="Nombre">
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="pais" class="col-sm-4 col-form-label text-sm-right">CLASIFICACION</label>
                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input type="hidden" class="form-control" name="clas" id="clas" placeholder="click para asignar">
                                    <input data-bs-target="#exampleModal2" data-bs-toggle="modal" type="text" class="form-control" name="nclas" id="nclas" onclick="" placeholder="click para asignar" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="pais" class="col-sm-4 col-form-label text-sm-right">TIPO</label>
                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input type="hidden" class="form-control" name="tip" id="tip" placeholder="click para asignar">
                                    <input data-bs-target="#exampleModal3" data-bs-toggle="modal" type="text" class="form-control" name="ntip" id="ntip" onclick="" placeholder="click para asignar" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="pais" class="col-sm-4 col-form-label text-sm-right">CALIBRE</label>
                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input type="hidden" class="form-control" name="cal" id="cal" placeholder="click para asignar">
                                    <input data-bs-target="#exampleModal4" data-bs-toggle="modal" type="text" class="form-control" name="ncal" id="ncal" onclick="" placeholder="click para asignar" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="pais" class="col-sm-4 col-form-label text-sm-right">MARCA-MODELO</label>
                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input type="hidden" class="form-control" name="mod" id="mod" placeholder="click para asignar">
                                    <input data-bs-target="#exampleModal5" data-bs-toggle="modal" type="text" class="form-control" name="nmod" id="nmod" onclick="" placeholder="click para asignar" readonly>
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
    <!-- lista CLASI-->
    <div class="modal fade" id="exampleModal2" aria-hidden="true" aria-labelledby="exampleModal2" tabindex="-1">
        <div class="modal-dialog" style="max-width: 600px;"> 
            <div class="row">
                <div class="modal-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1 class="col-form-label">LISTADO DE CLASIFICACIONES</h1>
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
                                <th>CLASIFICACION</th>
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
                        <h1 class="col-form-label">LISTADO DE TIPOS</h1>
                        <div>
                            <div class="search-bar">
                                <input type="text" class="form-control" id="buscadort" placeholder="Buscar...">
                                <button class="btn btn-success btn-add" data-bs-toggle="modal" id="salirpais"  data-bs-target="#exampleModal1" title="volver al formulario">
                                    <i class="fas fa-times"></i> cancelar
                                </button>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped" id="resultadot">
                        <thead>
                            <tr>
                                <th>CODIGO</th>
                                <th>TIPOS</th>
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
    <div class="modal fade" id="exampleModal4" aria-hidden="true" aria-labelledby="exampleModal2" tabindex="-1">
        <div class="modal-dialog">
            <div class="row">
                <div class="modal-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1 class="col-form-label">LISTADO DE CALIBRES</h1>
                        <div>
                            <div class="search-bar">
                                <input type="text" class="form-control" id="buscadorc" placeholder="Buscar...">
                                <button class="btn btn-success btn-add" data-bs-toggle="modal" id="salirpais"  data-bs-target="#exampleModal1" title="volver al formulario">
                                    <i class="fas fa-times"></i> cancelar
                                </button>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped" id="resultadoc">
                        <thead>
                            <tr>
                                <th>CODIGO</th>
                                <th>CALIBRE</th>
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
    <div class="modal fade" id="exampleModal5" aria-hidden="true" aria-labelledby="exampleModal2" tabindex="-1">
        <div class="modal-dialog">
            <div class="row">
                <div class="modal-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1 class="col-form-label">LISTADO DE MODELOS</h1>
                        <div>
                            <div class="search-bar">
                                <input type="text" class="form-control" id="buscadorm" placeholder="Buscar...">
                                <button class="btn btn-success btn-add" data-bs-toggle="modal" id="salirpais"  data-bs-target="#exampleModal1" title="volver al formulario">
                                    <i class="fas fa-times"></i> cancelar
                                </button>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped" id="resultadom">
                        <thead>
                            <tr>
                                <th>CODIGO</th>
                                <th>MARCA</th>
                                <th>MODELO</th>
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
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

<script>
    $(document).ready(function () {
        rellenardatos();
        rellenardatosp();
        rellenardatospp();
        rellenardatosc();
        rellenardatosm();

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
        $("#buscadorc").on('keyup', function () {
            var value = $(this).val().toLowerCase();
            $("#resultadoc tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
        $("#buscadorm").on('keyup', function () {
            var value = $(this).val().toLowerCase();
            $("#resultadom tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
        
        $("#buscadort").on('keyup', function () {
            var value = $(this).val().toLowerCase();
            $("#resultadot tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
    });

    function rellenardatos() {
        $.ajax({
            data: {listar: 'listar'},
            url: 'jsp/armas.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultado tbody").html(response);
            }
        });
    }

    function procesarFormulario() {
        var nombre = $("#nombre").val().trim();
        var clas = $("#clas").val().trim();
        var tip = $("#tip").val().trim();
        var cal = $("#cal").val().trim();
        var mod = $("#mod").val().trim();
        var tt = /^[a-zA-Z0-9 _ñÑ]+$/; 
        if (nombre === '' || clas === ''|| tip === ''|| cal === mod=== '') {
            $("#mensaje").html('<div class="alert alert-danger" role="alert">Por favor, completa todos los campos antes de enviar.</div>');
            setTimeout(function () {
                $("#mensaje").html("");
            }, 2000);
            return;
        }
        if (!tt.test(nombre)) {
            $("#mensaje").html('<div class="alert alert-danger" role="alert">Por favor, utiliza solo caracteres alfanuméricos o guiones bajos</div>');
            setTimeout(function () {
                $("#mensaje").html("");
            }, 3000);
            return;
        }
        var formdata = $("#form").serialize();
        $.ajax({
            data: formdata,
            url: 'jsp/armas.jsp',
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
            url: 'jsp/armas.jsp',
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
        $("#clas").val("");
        $("#nclas").val("");
        $("#tip").val("");
        $("#ntip").val("");
        $("#cal").val("");
        $("#ncal").val("");
        $("#mod").val("");
        $("#nmod").val("");
    }

    function rellenarjs(p,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10) {
        $("#pkid").val(p);
        $("#nombre").val(p1);
        $("#clas").val(p2);
        $("#nclas").val(p3);
        $("#tip").val(p4);
        $("#ntip").val(p5);
        $("#cal").val(p6);
        $("#ncal").val(p7);
        $("#mod").val(p8);
        $("#nmod").val(p9+" - "+p10);
        $("#listar").val("modificar");
    }
    function rellenardatosp() {
        $.ajax({
            data: {listar: 'listarp'},
            url: 'jsp/armas.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultadop tbody").html(response);
            }
        });
    }
    function rellenarjsp(a, b) {
        $("#clas").val(a);
        $("#nclas").val(b);
    }
    function rellenardatospp() {
        $.ajax({
            data: {listar: 'listart'},
            url: 'jsp/armas.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultadot tbody").html(response);
            }
        });
    }
    function rellenarjst(a, b) {
        $("#tip").val(a);
        $("#ntip").val(b);
    }
    function rellenardatosc() {
        $.ajax({
            data: {listar: 'listarc'},
            url: 'jsp/armas.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultadoc tbody").html(response);
            }
        });
    }
    function rellenarjsc(a, b) {
        $("#cal").val(a);
        $("#ncal").val(b);
    }
    function rellenardatosm() {
        $.ajax({
            data: {listar: 'listarm'},
            url: 'jsp/armas.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultadom tbody").html(response);
            }
        });
    }
    function rellenarjsm(a, b, c) {
        $("#mod").val(a);
        $("#nmod").val(c+" - "+b);
    }
</script>

<%@include file="footer.jsp" %>