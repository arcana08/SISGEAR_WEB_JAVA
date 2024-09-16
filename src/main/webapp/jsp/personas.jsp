<%@include file="conexion.jsp" %>
<%@ page import="java.sql.*, java.time.LocalDate, java.time.Period, java.time.format.DateTimeFormatter" %>
<%
if (request.getParameter("listar").equals("listar")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT p.idpersonas,p.per_nombre,p.per_apellido,p.per_ci,p.per_fechanac,p.per_direccion,c.ciu_nombre,b.barr_nombre,b.idbarrios FROM personas p,barrios b,ciudades c where p.idbarrios=b.idbarrios and b.idciudades=c.idciudades;");
        while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %> <% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(7)); %> - <% out.print(rs.getString(8)); %></td>
    <td><i class="fa fa-edit" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjs('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>', '<% out.print(rs.getString(4)); %>', '<% out.print(rs.getString(5)); %>', '<% out.print(rs.getString(6)); %>', '<% out.print(rs.getString(7)); %>', '<% out.print(rs.getString(8)); %>', '<% out.print(rs.getString(9)); %>')"></i>
        <i class="fa fa-trash" style="color:red" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="$('#iedit').val('<% out.print(rs.getString(1)); %>')"></i>
        <button class="btn btn-success btn-add" 
                onclick="window.open('reportesv/Rpersonas_1.jsp?id=<% out.print(rs.getString(1)); %>', '_blank')">
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
    String apellido = request.getParameter("apellido").toUpperCase();
    String ci = request.getParameter("ci");
    String edad = request.getParameter("edad");
    String direccion = request.getParameter("direccion").toUpperCase();
    String local = request.getParameter("local");
    
    try {
        Statement st = conn.createStatement();
        String query = "SELECT * from personas where per_ci = '"+ci+"'";
        ResultSet rs = st.executeQuery(query);

        if (rs.next()) {
            
            out.println("<div class='alert alert-danger' role='alert'>Los datos ya existen</div>");
        } else {
            try {
                query = "insert into personas(per_nombre,per_apellido,per_ci,per_fechanac,per_direccion,idbarrios)values('"+nombre+"','"+apellido+"','"+ci+"','"+edad+"','"+direccion+"','"+local+"')";
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
    String apellido = request.getParameter("apellido").toUpperCase();
    String ci = request.getParameter("ci");
    String edad = request.getParameter("edad");
    String local = request.getParameter("local");
    String direccion = request.getParameter("direccion").toUpperCase();
    String pkid = request.getParameter("pkid");
    
    try {
        Statement st = conn.createStatement();
        String query = "SELECT * from personas where per_ci = '"+ci+"' and idpersonas!='"+pkid+"'";
        ResultSet rs = st.executeQuery(query);

        if (rs.next()) {
            
            out.println("<div class='alert alert-danger' role='alert'>Los datos ya existen</div>");
        } else {
            try {
                query ="update personas set per_nombre = '"+nombre+"', per_apellido = '"+apellido+"', per_ci = '"+ci+"', per_fechanac = '"+edad+"', per_direccion = '"+direccion+"', idbarrios= '"+local+"' where idpersonas = '"+pkid+"'";
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
        st.executeUpdate("delete from personas where idpersonas = '"+pkid+"'");
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
        rs = st.executeQuery("SELECT b.idbarrios,c.ciu_nombre,b.barr_nombre FROM barrios b,ciudades c where b.idciudades=c.idciudades;");
        while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjsp('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>')"></i></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}
%>