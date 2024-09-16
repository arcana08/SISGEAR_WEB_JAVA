<%@include file="header.jsp" %>
<!DOCTYPE html>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SERVICIOS</title>

</head>

<body>
    <div class="container text-center">
        <div class="row">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="col-form-label">LISTADO DE SERVICIOS</h1>
                <div>
                    <div class="search-bar">
                        <input type="text" class="form-control" id="buscador" placeholder="Buscar...">
                        <button class="btn btn-success btn-add" id="nuevo" data-bs-toggle="modal" data-bs-target="#exampleModal1" title="Agregar Nuevo">
                            <i class="fas fa-plus"></i> AGREGAR
                        </button>
                        <a class="btn btn-primary btn-print" id="imprimir" href="reportesv/Rservicios.jsp" target="_blank" title="Imprimir Reporte">
                            <i class="fas fa-print"></i> IMPRIMIR
                        </a>
                    </div>
                </div>
            </div>
            <table class="table table-striped" id="resultado">
                <thead>
                    <tr>
                        <th>CODIGO</th>
                        <th>PERSONAL</th>
                        <th>ESTADO</th>
                        <th>INICIO</th>
                        <th>FIN</th>
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
        <div class="modal-dialog " style="max-width: 1000px; max-height: 90vh; overflow-y: auto">
            <div class="modal-content">
                <form id="form">
                    <div class="modal-header">
                        <h1 class="col-form-label">FORMULARIO DE SERVICIOS</h1>
                        <input type="hidden" id="listar" name="listar" value="cargar">
                        <input type="hidden" id="pkid" name="pkid" value="">
                    </div>
                    <div class="modal-body d-flex">
                        <div class="left-column" style="width: 400px; border-right: 1px solid #ccc; padding-right: 10px;">
                            <div class="form-group mt-3">
                                <label for="pais" class="col-form-label text-left">PERSONAL</label>
                                <div class="input-group">
                                    <input type="hidden" class="form-control" name="per" id="per" placeholder="click para asignar">
                                    <input data-bs-target="#exampleModal2" data-bs-toggle="modal" type="text" class="form-control mt-2" name="nper" id="nper" placeholder="click para asignar" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="right-column flex-grow-1 px-3">
                            <div class="form-group mt-3">
                                <label for="field1" class="col-form-label text-left">ARTICULOS</label>

                                <div class="form-row align-items-center mb-2">
                                    <div class="col-auto">
                                        <input type="hidden" class="form-control" name="arm" id="arm" placeholder="click para asignar">
                                        <input data-bs-target="#exampleModal3" data-bs-toggle="modal" type="text" class="form-control" name="narm" id="narm" placeholder="click para buscar Armas" readonly>
                                    </div>
                                    <div class="col-auto">
                                        <input type="hidden" class="form-control" name="cantarm" id="cantarm" value="1">
                                    </div>
                                    <div class="col-auto">
                                        <input type="button" class="btn btn-success" id="botonar" style="margin-left: 100px" value="ASIGNAR">
                                    </div>
                                </div>

                                <div class="form-row align-items-center mb-2">
                                    <div class="col-auto">
                                        <input type="hidden" class="form-control" name="mun" id="mun" placeholder="click para asignar">
                                        <input data-bs-target="#exampleModal4" data-bs-toggle="modal" type="text" class="form-control" name="nmun" id="nmun" placeholder="click para buscar Municiones" readonly>
                                    </div>
                                    <div class="col-auto">
                                        <input type="text" class="form-control" name="cantmun" id="cantmun" style="width: 100px" placeholder="cantidad" value="">
                                    </div>
                                    <div class="col-auto">
                                        <input type="button" class="btn btn-success" id="botonmun" value="ASIGNAR">
                                    </div>
                                </div>

                                <div class="form-row align-items-center">
                                    <div class="col-auto">
                                        <input type="hidden" class="form-control" name="acc" id="acc" placeholder="click para asignar">
                                        <input data-bs-target="#exampleModal5" data-bs-toggle="modal" type="text" class="form-control" name="nacc" id="nacc" placeholder="click para buscar Accesorios" readonly>
                                    </div>
                                    <div class="col-auto">
                                        <input type="text" class="form-control" name="cantacc" id="cantacc" style="width: 100px" placeholder="cantidad" value="">
                                    </div>
                                    <div class="col-auto">
                                        <input type="button" class="btn btn-success" id="botonacc" value="ASIGNAR">
                                    </div>
                                </div>
                            </div>
                            <div class="right-column mt-3">
                                <div class="form-group">
                                    <label for="field2" class="col-form-label text-left">SECTION 2</label>
                                    <div>
                                        <table class="table table-striped" id="detalles">
                                            <thead>
                                                <tr>
                                                    <th>CODIGO</th>
                                                    <th>ARTICULO</th>
                                                    <th>CANTIDAD</th>
                                                    <th>ELIMINAR</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="mensaje"></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" id="btncancelar" data-bs-dismiss="modal">CANCELAR</button>
                        <input type="button" class="btn btn-success" id="boton" value="PROCESAR">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="exampleModald" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog " style="max-width: 1000px; max-height: 90vh; overflow-y: auto">
            <div class="modal-content">
                <form id="form">
                    <div class="modal-header">
                        <h1 class="col-form-label">FORMULARIO DE SERVICIOS</h1>
                        <input type="hidden" id="listar" name="listar" value="fin">
                        <input type="hidden" id="pkidd" name="pkidd" value="">
                    </div>
                    <div class="modal-body d-flex">
                        <div class="left-column" style="width: 400px; border-right: 1px solid #ccc; padding-right: 10px;">
                            <div class="form-group mt-3">
                                <label for="pais" class="col-form-label text-left">PERSONAL</label>
                                <div class="input-group">
                                    <input type="hidden" class="form-control" name="perd" id="perd" placeholder="">
                                    <input  type="text" class="form-control mt-2" name="nperd" id="nperd" placeholder="" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="right-column flex-grow-1 px-3">
                            <div class="right-column mt-3">
                                <div class="form-group">
                                    <label for="field2" class="col-form-label text-left">SECTION 2</label>
                                    <div>
                                        <table class="table table-striped" id="detalles2">
                                            <thead>
                                                <tr>
                                                    <th>CODIGO</th>
                                                    <th>ARTICULO</th>
                                                    <th>CANTIDAD</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="mensajee"></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" id="btncancelare" data-bs-dismiss="modal">CANCELAR</button>
                        <input type="button" class="btn btn-success" id="btntermina" data-bs-toggle="modal" data-bs-target="#modalfinalizar" value="FINALIZAR SEVICIO">
                        <input type="button" class="btn btn-primary" id="btnanula" data-bs-toggle="modal" data-bs-target="#modalanular" value="ANULAR SEVICIO">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- lista CLASI-->
    <div class="modal fade" id="exampleModal2" aria-hidden="true" aria-labelledby="exampleModal2" tabindex="-1">
        <div class="modal-dialog" style="max-width: 600px;"> 
            <div class="row">
                <div class="modal-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1 class="col-form-label">LISTADO DE PERSONALES</h1>
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
        <div class="modal-dialog" style="max-width: 700px;"> 
            <div class="row">
                <div class="modal-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1 class="col-form-label">LISTADO DE ARMAS</h1>
                        <div>
                            <div class="search-bar">
                                <input type="text" class="form-control" id="buscadort" placeholder="Buscar...">
                                <button class="btn btn-success btn-add" data-bs-toggle="modal" id="salirpais"  data-bs-target="#exampleModal1" title="volver al formulario">
                                    <i class="fas fa-times"></i> cancelar
                                </button>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped" id="resultadosa">
                        <thead>
                            <tr>
                                <th>CODIGO</th>
                                <th>TIPO</th>
                                <th>CALIBRE</th>
                                <th>MARCA</th>
                                <th>MODELO</th>
                                <th>SERIE</th>
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
        <div class="modal-dialog" style="max-width: 700px;">
            <div class="row">
                <div class="modal-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1 class="col-form-label">LISTADO DE MUNICIONES</h1>
                        <div>
                            <div class="search-bar">
                                <input type="text" class="form-control" id="buscadorc" placeholder="Buscar...">
                                <button class="btn btn-success btn-add" data-bs-toggle="modal"  data-bs-target="#exampleModal1" title="volver al formulario">
                                    <i class="fas fa-times"></i> cancelar
                                </button>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped" id="resultadomun">
                        <thead>
                            <tr>
                                <th>CODIGO</th>
                                <th>TIPO</th>
                                <th>MARCA</th>
                                <th>CANTIDAD</th>
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
        <div class="modal-dialog" style="max-width: 700px;">
            <div class="row">
                <div class="modal-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1 class="col-form-label">LISTADO DE ACCESORIOS</h1>
                        <div>
                            <div class="search-bar">
                                <input type="text" class="form-control" id="buscadorm" placeholder="Buscar...">
                                <button class="btn btn-success btn-add" data-bs-toggle="modal" id="salirpais"  data-bs-target="#exampleModal1" title="volver al formulario">
                                    <i class="fas fa-times"></i> cancelar
                                </button>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped" id="resultadoacc">
                        <thead>
                            <tr>
                                <th>CODIGO</th>
                                <th>TIPO</th>
                                <th>MARCA</th>
                                <th>MODELO</th>
                                <th>CANTIDAD</th>
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
    <!-- confirmar accion -->
    <div class="modal fade" id="modalfinalizar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    EN VERDAD DESEA FINALIZAR EL SERVICIO?
                </div>
                <div id="mensaje2"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModald">CANCELAR</button>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModald" id="btnfin" >FINALIZAR</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalanular" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    EN VERDAD DESEA ANULAR EL SERVICIO?
                </div>
                <div id="mensaje2"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModald">CANCELAR</button>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModald" id="btnanular" >ANULAR</button>
                </div>
            </div>
        </div>
    </div>
</body>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script-->
<!--script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
<!--script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script-->

<script>
    $(document).ready(function () {
        rellenardatos();
        rellenardatosp();
        rellenardatosa();
        rellenardatosmun();
        rellenardatoacc();

        $("#boton").on('click', function () {
            procesarformulario();
            rellenardatos();
        });
        $("#nuevo").on('click', function () {
            resetFormulario();
        });
        $("#btncancelar").on('click', function () {
            resetFormulario();
        });
        $("#btncancelare").on('click', function () {
            resetFormulario();
        });
        $("#btnfin").on('click', function () {
            finalizarservicio();
            rellenardatos();
        });
        $("#btnanular").on('click', function () {
            anularservicio();
            rellenardatos();
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

        $("#botonar").on('click', function () {

            var codigo = $("#arm").val();
            var detalle = $("#narm").val();
            var cantidad = $("#cantarm").val();

            if (codigo && detalle && cantidad) {
                // nueva fila
                var table = $("#detalles tbody");
                var newRow = $("<tr>");

                $("<td>").text(codigo).appendTo(newRow);
                $("<td>").text(detalle).appendTo(newRow);
                $("<td>").text(cantidad).appendTo(newRow);
                $("<td>").html('<button class="btn btn-link"><i class="fa fa-trash"></i></button>').appendTo(newRow);
                table.append(newRow);

                // limpiar inputs
                $("#arm").val('');
                $("#narm").val('');
                $("#cantarm").val('1');

                newRow.find(".fa-trash").click(function () {
                    $(this).closest('tr').remove();
                });
            }
        });

        $("#botonmun").on('click', function () {

            var codigo = $("#mun").val();
            var detalle = $("#nmun").val();
            var cantidad = $("#cantmun").val();

            if (codigo && detalle && cantidad) {
                // nueva fila
                var table = $("#detalles tbody");
                var newRow = $("<tr>");

                $("<td>").text(codigo).appendTo(newRow);
                $("<td>").text(detalle).appendTo(newRow);
                $("<td>").text(cantidad).appendTo(newRow);
                $("<td>").html('<button class="btn btn-link"><i class="fa fa-trash"></i></button>').appendTo(newRow);
                table.append(newRow);

                // limpiar inputs
                $("#mun").val('');
                $("#nmun").val('');
                $("#cantmun").val('');

                newRow.find(".fa-trash").click(function () {
                    $(this).closest('tr').remove();
                });
            }
        });

        $("#botonacc").on('click', function () {

            var codigo = $("#acc").val();
            var detalle = $("#nacc").val();
            var cantidad = $("#cantacc").val();

            if (codigo && detalle && cantidad) {
                // nueva fila
                var table = $("#detalles tbody");
                var newRow = $("<tr>");

                $("<td>").text(codigo).appendTo(newRow);
                $("<td>").text(detalle).appendTo(newRow);
                $("<td>").text(cantidad).appendTo(newRow);
                $("<td>").html('<button class="btn btn-link"><i class="fa fa-trash"></i></button>').appendTo(newRow);
                table.append(newRow);

                // limpiar inputs
                $("#acc").val('');
                $("#nacc").val('');
                $("#cantacc").val('');

                newRow.find(".fa-trash").click(function () {
                    $(this).closest('tr').remove();
                });
            }
        });
    });

    function rellenardatos() {
        $.ajax({
            data: {listar: 'listar'},
            url: 'jsp/servicios.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultado tbody").html(response);
            }
        });
    }

    function rellenardetalles() {
        var pkid = $("#pkidd").val().trim();
        $.ajax({
            data: {listar: 'listard', pkid: pkid},
            url: 'jsp/servicios.jsp',
            type: 'POST',
            success: function (response) {
                $("#detalles2 tbody").html(response);
            }
        });
    }

    function finalizarservicio() {
        var pkid = $("#pkidd").val().trim();
        $.ajax({
            data: {listar: 'finalizar', pkid: pkid},
            url: 'jsp/servicios.jsp',
            type: 'POST',
            success: function (response) {
                $("#mensajee").html(response);
                setTimeout(function () {
                    $("#exampleModald").modal('hide');
                    $("#mensajee").html("");
                    rellenardatos();
                }, 1500);
            }
        });
    }
    
    function anularservicio() {
        var pkid = $("#pkidd").val().trim();
        $.ajax({
            data: {listar: 'anular', pkid: pkid},
            url: 'jsp/servicios.jsp',
            type: 'POST',
            success: function (response) {
                $("#mensajee").html(response);
                setTimeout(function () {
                    $("#exampleModald").modal('hide');
                    $("#mensajee").html("");
                    rellenardatos();
                }, 1500);
            }
        });
    }

    function procesarformulario() {
        var detalles = [];
        var per = $("#per").val().trim();

        $("#detalles tbody tr").each(function () {
            var codigo = $(this).find("td").eq(0).text();
            var cantidad = $(this).find("td").eq(2).text();

            if (codigo) {
                detalles.push({
                    codigo: codigo,
                    cantidad: cantidad
                });
            }
        });

        if (detalles.length > 0) {
            var formData = new FormData();
            formData.append("per", per);

            detalles.forEach(function (detalle, index) {
                formData.append("detalles[" + index + "][codigo]", detalle.codigo);
                formData.append("detalles[" + index + "][cantidad]", detalle.cantidad);
            });

            $.ajax({
                data: {listar: 'cargar', per: per, detalles: detalles},
                url: 'jsp/servicios.jsp',
                type: 'post',
                success: function (response) {
                    $("#mensaje").html(response);
                    setTimeout(function () {
                        $("#exampleModal1").modal('hide');
                        $("#mensaje").html("");
                        rellenardatos();
                    }, 1500);
                },
                error: function (xhr, status, error) {
                    console.error('Error al insertar datos: ', xhr.responseText);
                    alert('Error al insertar datos: ' + xhr.responseText);
                }
            });
        } else {
            $("#mensaje").html();
            setTimeout(function () {
                $("#mensaje").html("");
            }, 1500);
            alert('No hay detalles para insertar');
        }
    }

    function resetFormulario() {
        $("#listar").val("cargar");
        $("#pkid").val("");
        $("#nper").val("");
        $("#nperd").val("");
        $("#per").val("");
        $("#perd").val("");
        $("#clas").val("");
        $("#nclas").val("");
        $("#tip").val("");
        $("#ntip").val("");
        $("#cal").val("");
        $("#ncal").val("");
        $("#mod").val("");
        $("#nmod").val("");
        $("#detalles tbody").html("");
        $("#detalles2 tbody").html("");
    }

    function rellenarjs(p, p1, p2) {
        $("#pkidd").val(p);
        $("#nperd").val(p1 + " " + p2);
        rellenardetalles();

    }
    function rellenardatosp() {
        $.ajax({
            data: {listar: 'listarp'},
            url: 'jsp/servicios.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultadop tbody").html(response);
            }
        });
    }
    function rellenarjsp(a, b, c) {
        $("#per").val(a);
        $("#nper").val(b + ' ' + c);
    }
    function rellenardatosa() {
        $.ajax({
            data: {listar: 'listara'},
            url: 'jsp/servicios.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultadosa tbody").html(response);
            }
        });
    }
    function rellenarjsa(a, b, c) {
        $("#arm").val(a);
        $("#narm").val(b + ' - ' + c);
    }
    function rellenardatosmun() {
        $.ajax({
            data: {listar: 'listarmun'},
            url: 'jsp/servicios.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultadomun tbody").html(response);
            }
        });
    }
    function rellenarjsmun(a, b, c) {
        $("#mun").val(a);
        $("#nmun").val(b + ' ' + c);
    }
    function rellenardatoacc() {
        $.ajax({
            data: {listar: 'listaracc'},
            url: 'jsp/servicios.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultadoacc tbody").html(response);
            }
        });
    }
    function rellenarjsacc(a, b) {
        $("#acc").val(a);
        $("#nacc").val(b);
    }

</script>

<%@include file="footer.jsp" %>