<%@include file="conexion.jsp" %>
<%@ page import="java.util.ArrayList, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String listar = request.getParameter("listar");



if ("listar".equals(listar)) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT s.idservicios, p.per_nombre, p.per_ci, s.estado, s.fecha_inicio, s.fecha_fin FROM servicios s, personas p WHERE s.idpersonas = p.idpersonas ORDER BY CASE WHEN s.estado = 'activo' THEN 0 ELSE 1 END, s.fecha_inicio ASC;");
        while (rs.next()) {
%>      
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %> <% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><i class="fa fa-eye" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModald" onclick="rellenarjs('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>')"></i>
        <button class="btn btn-success btn-add" 
                onclick="window.open('reportesv/Rservicios_1.jsp?id=<% out.print(rs.getString(1)); %>', '_blank')">
            <i class="fas fa-print"></i>
        </button>
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
} else if ("cargar".equals(listar)) {
    String perString = request.getParameter("per");
    int per = Integer.parseInt(perString);
    List<String[]> detalles = new ArrayList<>();
    int index = 0;

    while (request.getParameter("detalles[" + index + "][codigo]") != null) {
    String codigoStr = request.getParameter("detalles[" + index + "][codigo]");
    String cantidadStr = request.getParameter("detalles[" + index + "][cantidad]");

    
    int codigo = Integer.parseInt(codigoStr);
    int cantidad = Integer.parseInt(cantidadStr);

    detalles.add(new String[]{String.valueOf(codigo), String.valueOf(cantidad)});

    index++;
    }

    try {
        conn.setAutoCommit(false);

        String query = "INSERT INTO servicios (estado, idpersonas) VALUES ('pendiente', ?)";
        try (PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, per);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int idServicio = rs.getInt(1);

                query = "INSERT INTO detalle_servicio(idservicios, idarticulo, cantidad) VALUES (?, ?, ?)";
                try (PreparedStatement psDetalle = conn.prepareStatement(query)) {
                    for (String[] detalle : detalles) {
                        int codigo = Integer.parseInt(detalle[0]); 
                        int cantidad = Integer.parseInt(detalle[1]); 

                        psDetalle.setInt(1, idServicio);
                        psDetalle.setInt(2, codigo); 
                        psDetalle.setInt(3, cantidad); 
                        psDetalle.addBatch();
                    }

                    int[] resultados = psDetalle.executeBatch();

                    boolean exito = true;
                    for (int res : resultados) {
                        if (res == PreparedStatement.EXECUTE_FAILED) {
                            exito = false;
                            break;
                        }
                    }

                    if (exito) {
                        query = "UPDATE servicios SET estado = 'activo' WHERE idservicios = ?";
                        try (PreparedStatement psUpdate = conn.prepareStatement(query)) {
                            psUpdate.setInt(1, idServicio);
                            psUpdate.executeUpdate();
                        }

                        conn.commit();
                        out.println("<div class='alert alert-success' role='alert'>Datos insertados correctamente</div>");
                    } else {
                        conn.rollback();
                        out.println("{\"status\":\"error\",\"message\":\"Error al insertar los datos\"}");
                    }
                }
            } else {
                conn.rollback();
                out.println("{\"status\":\"warning\",\"message\":\"No se pudo obtener el ID del nuevo servicio\"}");
            }
        }
    } catch (SQLException e) {
        try {
            conn.rollback();
        } catch (SQLException rollbackEx) {
            out.println("{\"status\":\"error\",\"message\":\"Error al hacer rollback: " + rollbackEx.getMessage() + "\"}");
        }
        out.println("{\"status\":\"error\",\"message\":\"Error PSQL: " + e.getMessage() + "\"}");
    } finally {
        try {
            conn.setAutoCommit(true);
        } catch (SQLException e) {
            out.println("{\"status\":\"error\",\"message\":\"Error al restaurar auto-commit: " + e.getMessage() + "\"}");
        }
    }
}else if ("listard".equals(listar)) {
    String pkid = request.getParameter("pkid");
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT s.idservicios, d.idarticulo, d.cantidad, a.art_serie, t.tip_nombre, cal.cal_nombre, c.idcategorias, m.mar_nombre "
        + "FROM detalle_servicio d, servicios s, articulo a, tipos t, calibres cal, clasificaciones c, marcas m, modelos mo "
        + "WHERE d.idservicios = s.idservicios AND a.idcalibres = cal.idcalibres AND a.idtipo = t.idtipos and mo.idmarcas=m.idmarcas and a.idmodelos=mo.idmodelos "
        + "AND c.idclasificaciones = a.idclasificaciones AND d.idarticulo = a.idarticulo AND d.idservicios = '"+pkid+"'");
        
        while (rs.next()) {
            int idcategoria = rs.getInt(7);

            if (idcategoria == 1) {
%>
<tr>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(5)); %> <% out.print(rs.getString(8)); %> <% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
</tr>
<%
            } else if (idcategoria == 2) {
%>
<tr>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(5)); %> <% out.print(rs.getString(8)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
</tr>
<%
            } else if (idcategoria == 5) {
%>
<tr>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(8)); %> <% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
</tr>
<%
            } else {
%>
<tr>
    <td colspan="3">Categoría no definida</td>
</tr>
<%
            }
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}
else if ("finalizar".equals(listar)) {
    String pkid = request.getParameter("pkid");
    try {
        int id = Integer.parseInt(pkid);
        String sql = "UPDATE servicios SET estado = 'finalizado' WHERE idservicios = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id); 
        
        int rowsUpdated = ps.executeUpdate();
        
        if (rowsUpdated > 0) {
            out.println("<div class='alert alert-success' role='alert'>Servicio finalizado correctamente</div>");
        } else {
            out.println("<div class='alert alert-danger' role='alert'>No se encontró el servicio a finalizar</div>");
        }
        
    }  catch (Exception e) {
        out.println("<div class='alert alert-danger' role='alert'>Error al finalizar el servicio: " + e.getMessage() + "</div>");
    }
}else if ("anular".equals(listar)) {
    String pkid = request.getParameter("pkid");
    try {
        int id = Integer.parseInt(pkid);
        String sql = "UPDATE servicios SET estado = 'anulado' WHERE idservicios = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id); 
        
        int rowsUpdated = ps.executeUpdate();
        
        if (rowsUpdated > 0) {
            out.println("<div class='alert alert-success' role='alert'>Servicio anulado correctamente</div>");
        } else {
            out.println("<div class='alert alert-danger' role='alert'>No se encontró el servicio a anular</div>");
        }
        
    }  catch (Exception e) {
        out.println("<div class='alert alert-danger' role='alert'>Error al anular el servicio: " + e.getMessage() + "</div>");
    }
}
else if ("listarp".equals(listar)) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT p.idpersonas,p.per_nombre,p.per_apellido,p.per_ci from personas p;");
        while (rs.next()) {
%>      
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %> <% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjsp('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(4)); %>')"></i></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}else if ("listara".equals(listar)) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("select a.idarticulo,a.art_serie,ct.cat_nombre,cf.cla_nombre,t.tip_nombre,"
        + "c.cal_nombre,mc.mar_nombre,m.mod_nombre,a.art_cantidad,a.idclasificaciones,a.idtipo,a.idcalibres,a.idmodelos from articulo a,modelos m,marcas mc,tipos t,"
        + "calibres c,clasificaciones cf,categorias ct where a.idtipo=t.idtipos and a.idclasificaciones=cf.idclasificaciones"
        + " and cf.idcategorias=ct.idcategorias and a.idcalibres=c.idcalibres and a.idmodelos=m.idmodelos and m.idmarcas=mc.idmarcas and ct.idcategorias=1;");
        while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(7)); %></td>
    <td><% out.print(rs.getString(8)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjsa('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(5)); %>', '<% out.print(rs.getString(2)); %>')"></i>
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
} if ("listarmun".equals(listar)) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("select a.idarticulo,a.art_cantidad,ct.cat_nombre,cf.cla_nombre,t.tip_nombre,"
        + "c.cal_nombre,mc.mar_nombre,m.mod_nombre,a.art_cantidad,a.idclasificaciones,a.idtipo,a.idcalibres,a.idmodelos from articulo a,modelos m,marcas mc,tipos t,"
        + "calibres c,clasificaciones cf,categorias ct where a.idtipo=t.idtipos and a.idclasificaciones=cf.idclasificaciones"
        + " and cf.idcategorias=ct.idcategorias and a.idcalibres=c.idcalibres and a.idmodelos=m.idmodelos and m.idmarcas=mc.idmarcas and ct.idcategorias=5;");
        while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(7)); %></td>
    <td><% out.print(rs.getString(9)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjsmun('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(7)); %>', '<% out.print(rs.getString(6)); %>')"></i>
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}if ("listaracc".equals(listar)) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("select a.idarticulo,a.art_cantidad,ct.cat_nombre,cf.cla_nombre,t.tip_nombre,"
        + "c.cal_nombre,mc.mar_nombre,m.mod_nombre,a.art_cantidad,a.idclasificaciones,a.idtipo,a.idcalibres,a.idmodelos from articulo a,modelos m,marcas mc,tipos t,"
        + "calibres c,clasificaciones cf,categorias ct where a.idtipo=t.idtipos and a.idclasificaciones=cf.idclasificaciones"
        + " and cf.idcategorias=ct.idcategorias and a.idcalibres=c.idcalibres and a.idmodelos=m.idmodelos and m.idmarcas=mc.idmarcas and ct.idcategorias=2;");
        while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(7)); %></td>
    <td><% out.print(rs.getString(8)); %></td>
    <td><% out.print(rs.getString(9)); %></td>
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjsacc('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(5)); %>', '<% out.print(rs.getString(5)); %>')"></i>
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}
%>
