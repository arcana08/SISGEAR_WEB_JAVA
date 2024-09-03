<%@include file="conexion.jsp" %>
<%
if (request.getParameter("listar").equals("listar")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT b.idbarrios, b.barr_nombre, c.idciudades,c.ciu_nombre,d.iddepartamentos, d.dep_nombre,p.idpaises,p.pai_nombre from departamentos d, ciudades c,paises p, barrios b where d.idpaises=p.idpaises and c.iddepartamentos=d.iddepartamentos and b.idciudades=c.idciudades;");
        while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(8)); %></td>
    <td><i class="fa fa-edit" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjs('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>','<% out.print(rs.getString(4)); %>','<% out.print(rs.getString(6)); %>','<% out.print(rs.getString(8)); %>')"></i>
        <i class="fa fa-trash" style="color:red" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="$('#iedit').val('<% out.print(rs.getString(1)); %>')"></i></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}  else if (request.getParameter("listar").equals("cargar")) {
    String nombre = request.getParameter("nombre").toUpperCase();
    String ciudad = request.getParameter("dep").toUpperCase();
    nombre = nombre.replace("'", "''");
    
    try {
        Statement st = conn.createStatement();
        String query = "SELECT * from barrios where barr_nombre = '"+nombre+"' and idciudades = '"+ciudad+"'";
        ResultSet rs = st.executeQuery(query);

        if (rs.next()) {
            
            out.println("<div class='alert alert-danger' role='alert'>Los datos ya existen</div>");
        } else {
            try {
                query = "insert into barrios(barr_nombre, idciudades) values ('"+nombre+"', '"+ciudad+"')";
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
    String ciudad = request.getParameter("dep");
    String pkid = request.getParameter("pkid");
    nombre = nombre.replace("'", "''");
    try {
        Statement st = conn.createStatement();
        String query = "SELECT * from barrios where barr_nombre = '"+nombre+"' and idciudades = '"+ciudad+"'";
        ResultSet rs = st.executeQuery(query);

        if (rs.next()) {
            // El departamento ya existe
            out.println("<div class='alert alert-danger' role='alert'>Los datos ya existen existen</div>");
        } else {
            try {
                query = "update barrios set barr_nombre = '"+nombre+"',idciudades = '"+ciudad+"' where idbarrios = '"+pkid+"'";
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
        st.executeUpdate("delete from barrios where idbarrios = '"+pkid+"'");
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
        rs = st.executeQuery("SELECT c.idciudades,c.ciu_nombre,d.iddepartamentos, d.dep_nombre,p.idpaises,p.pai_nombre from departamentos d, ciudades c,paises p where d.idpaises=p.idpaises and c.iddepartamentos=d.iddepartamentos;");
        while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjsp('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>','<% out.print(rs.getString(4)); %>','<% out.print(rs.getString(6)); %>')"></i></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}
%>