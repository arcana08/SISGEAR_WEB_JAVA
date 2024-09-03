<%@include file="conexion.jsp" %>
<%
if (request.getParameter("listar").equals("listar")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT u.idusuarios, u.usu_nombre, u.usu_contraseña, p.idpersonas, p.per_nombre, p.per_apellido, p.per_ci, r.idroles, r.rol_nombre FROM usuarios u, personas p, roles r where u.idroles=r.idroles and u.idpersonas=p.idpersonas;");
        while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(5)); %> <% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(7)); %></td>
    <td><% out.print(rs.getString(9)); %></td>
    <td><i class="fa fa-edit" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjs('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>', '<% out.print(rs.getString(4)); %>', '<% out.print(rs.getString(5)); %>', '<% out.print(rs.getString(7)); %>', '<% out.print(rs.getString(8)); %>', '<% out.print(rs.getString(9)); %>')"></i>
        <i class="fa fa-trash" style="color:red" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="$('#iedit').val('<% out.print(rs.getString(1)); %>')"></i></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
} else if (request.getParameter("listar").equals("cargar")) {
    String nombre = request.getParameter("nombre");
    String clave = request.getParameter("clave");
    String per = request.getParameter("per");
    String rol = request.getParameter("rol");
    String pkid = request.getParameter("pkid");
    
    try {
        Statement st = conn.createStatement();
        String query = "SELECT * from usuarios where idpersonas = '" + per + "' AND idroles = '" + rol + "'";
        ResultSet rs = st.executeQuery(query);

        if (rs.next()) {
            // El departamento ya existe
            out.println("<div class='alert alert-danger' role='alert'>Los datos ya existen</div>");
        } else {
            try {
                query = "INSERT into usuarios(usu_nombre, usu_contraseña, idpersonas, idroles) values ('" + nombre + "', '" + clave + "', '" + per + "', '" + rol + "')";
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
    String nombre = request.getParameter("nombre");
    String clave = request.getParameter("clave");
    String per = request.getParameter("per");
    String rol = request.getParameter("rol");
    String pkid = request.getParameter("pkid");
    try {
        Statement st = conn.createStatement();
        String query = "SELECT * from usuarios where idpersonas = '" + per + "' AND idroles = '" + rol + "' and idusuarios!='"+pkid+"'";
        ResultSet rs = st.executeQuery(query);

        if (rs.next()) {
            // El departamento ya existe
            out.println("<div class='alert alert-danger' role='alert'>Los datos ya existen existen</div>");
        } else {
            try {
                query = "update usuarios set usu_nombre = '"+nombre+"',usu_contraseña = '"+clave+"',idpersonas = '"+per+"',idroles = '"+rol+"' where idusuarios = '"+pkid+"'";
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
        st.executeUpdate("delete from usuarios where idusuarios ='"+pkid+"'");
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
        rs = st.executeQuery("SELECT p.idpersonas,p.per_nombre,p.per_apellido,p.per_ci from personas p;");
        while (rs.next()) {
%>      
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %> <% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjsp('<% out.print(rs.getString(1)); %>','<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(4)); %>')"></i></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}else if (request.getParameter("listar").equals("listarpp")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT idroles, rol_nombre from roles ;");
        while (rs.next()) {
%>      
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjspp('<% out.print(rs.getString(1)); %>','<% out.print(rs.getString(2)); %>')"></i></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}
%>