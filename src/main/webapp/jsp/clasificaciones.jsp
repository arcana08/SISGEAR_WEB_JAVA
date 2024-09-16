<%@include file="conexion.jsp" %>
<%
if (request.getParameter("listar").equals("listar")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT cl.idclasificaciones, cl.cla_nombre, c.idcategorias, c.cat_nombre FROM clasificaciones cl, categorias c where cl.idcategorias=c.idcategorias;");
        while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><i class="fa fa-edit" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjs('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>', '<% out.print(rs.getString(4)); %>')"></i>
        <i class="fa fa-trash" style="color:red" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="$('#iedit').val('<% out.print(rs.getString(1)); %>')"></i>
        <button class="btn btn-success btn-add" 
                onclick="window.open('reportesv/Rclasificaciones_1.jsp?id=<% out.print(rs.getString(1)); %>', '_blank')">
            <i class="fas fa-print"></i>
        </button>
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
} else if (request.getParameter("listar").equals("cargar")) {
    String nombre = request.getParameter("nombre").toUpperCase();
    String cate = request.getParameter("cate").toUpperCase();
    
    try {
        Statement st = conn.createStatement();
        String query = "SELECT * from clasificaciones where cla_nombre = '" + nombre + "' AND idcategorias = '" + cate + "'";
        ResultSet rs = st.executeQuery(query);

        if (rs.next()) {
            // El departamento ya existe
            out.println("<div class='alert alert-danger' role='alert'>Los datos ya existen</div>");
        } else {
            try {
                query = "INSERT into clasificaciones(cla_nombre, idcategorias) values ('" + nombre + "', '" + cate + "')";
                int filasAfectadas = st.executeUpdate(query);
                
                if (filasAfectadas > 0) {
                    // Datos insertados correctamente
                    out.println("<div class='alert alert-success' role='alert'>Datos insertados correctamente</div>");
                } else {
                    // Error al insertar los datos
                    out.println("<div class='alert alert-danger' role='alert'>Error al insertar los datos</div>");
                }
            } catch (Exception e) {
                out.println("error PSQL " + e.getMessage());
            }
        }
    } catch (Exception e) {
        out.println("error PSQL " + e.getMessage());
    }
}else if (request.getParameter("listar").equals("modificar")) {
    String nombre = request.getParameter("nombre").toUpperCase();
    String cate = request.getParameter("cate");
    String pkid = request.getParameter("pkid");
    try {
        Statement st = conn.createStatement();
        String query = "SELECT * from clasificaciones where cla_nombre = '" + nombre + "' AND idcategorias = '" + cate + "' and idclasificaciones!='"+pkid+"'";
        ResultSet rs = st.executeQuery(query);

        if (rs.next()) {
            // El departamento ya existe
            out.println("<div class='alert alert-danger' role='alert'>Los datos ya existen existen</div>");
        } else {
            try {
                query = "update clasificaciones set cla_nombre = '"+nombre+"',idcategorias = '"+cate+"' where idclasificaciones = '"+pkid+"'";
                int filasAfectadas = st.executeUpdate(query);
                
                if (filasAfectadas > 0) {
                    // Datos insertados correctamente
                    out.println("<div class='alert alert-success' role='alert'>Datos modificados correctamente</div>");
                } else {
                    // Error al insertar los datos
                    out.println("<div class='alert alert-danger' role='alert'>Error al modificar los datos</div>");
                }
            } catch (Exception e) {
                out.println("error PSQL " + e.getMessage());
            }
        }
    } catch (Exception e) {
        out.println("error PSQL " + e.getMessage());
    }
}else if (request.getParameter("listar").equals("eliminar")) {
    String pkid = request.getParameter("pk");
    
    try {
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("delete from clasificaciones where idclasificaciones ='"+pkid+"'");
        //setTimeout(function () {
            out.println("<div class='alert alert-success' role='alert'>Datos eliminados correctamente</div>");
        //}, 2000);
        
    } catch (Exception e) {
        out.println("<div class='alert alert-danger' role='alert'>Los datos son utilizados en otra tabla</div>");
    }
}else if (request.getParameter("listar").equals("listarp")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM categorias;");
        while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjsp('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>')"></i></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}
%>