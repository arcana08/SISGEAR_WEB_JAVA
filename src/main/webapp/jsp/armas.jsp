<%@include file="conexion.jsp" %>
<%
if (request.getParameter("listar").equals("listar")) {
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
    <td><% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(7)); %></td>
    <td><% out.print(rs.getString(8)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><i class="fa fa-edit" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjs('<% out.print(rs.getString(1)); %>','<% out.print(rs.getString(2)); %>','<% out.print(rs.getString(10)); %>','<% out.print(rs.getString(4)); %>','<% out.print(rs.getString(11)); %>','<% out.print(rs.getString(5)); %>','<% out.print(rs.getString(12)); %>','<% out.print(rs.getString(6)); %>','<% out.print(rs.getString(13)); %>','<% out.print(rs.getString(7)); %>','<% out.print(rs.getString(8)); %>')"></i>
        <i class="fa fa-trash" style="color:red" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="$('#iedit').val('<% out.print(rs.getString(1)); %>')"></i>
        <button class="btn btn-success btn-add" 
                onclick="window.open('reportesv/Rarmas_1.jsp?id=<% out.print(rs.getString(1)); %>', '_blank')">
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
    String nombre = request.getParameter("nombre");
    String clas = request.getParameter("clas");
    String tip = request.getParameter("tip");
    String cal = request.getParameter("cal");
    String mod = request.getParameter("mod");
    String pkid = request.getParameter("pkid");
    
    try {
        Statement st = conn.createStatement();
        String query = "SELECT * from articulo where art_serie = '" + nombre + "' AND idmodelos = '" + mod + "'";
        ResultSet rs = st.executeQuery(query);

        if (rs.next()) {
            // El departamento ya existe
            out.println("<div class='alert alert-danger' role='alert'>Los datos ya existen</div>");
        } else {
            try {
                query = "INSERT INTO articulo(idmodelos, idclasificaciones, idcalibres, idtipo, art_serie, art_cantidad) values ('" + mod + "','" + clas + "', '" + cal + "', '" + tip + "', '" + nombre + "',1)";
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
    String clas = request.getParameter("clas");
    String tip = request.getParameter("tip");
    String cal = request.getParameter("cal");
    String mod = request.getParameter("mod");
    String pkid = request.getParameter("pkid");
    try {
        Statement st = conn.createStatement();
        String query = "SELECT * from articulo where art_serie = '" + nombre + "' AND idmodelos = '" + mod + "'and idarticulo!='" + pkid + "'";
        ResultSet rs = st.executeQuery(query);

        if (rs.next()) {
            // El departamento ya existe
            out.println("<div class='alert alert-danger' role='alert'>Los datos ya existen existen</div>");
        } else {
            try {
                query = "update articulo set art_serie = '"+nombre+"',idclasificaciones = '"+clas+"',idtipo = '"+tip+"',idcalibres = '"+cal+"',idmodelos = '"+mod+"' where idarticulo = '"+pkid+"'";
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
        st.executeUpdate("delete from articulo where idarticulo ='"+pkid+"'");
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
        rs = st.executeQuery("SELECT idclasificaciones, cla_nombre from clasificaciones where idcategorias=1;");
        while (rs.next()) {
%>      
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td> 
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjsp('<% out.print(rs.getString(1)); %>','<% out.print(rs.getString(2)); %>')"></i></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}else if (request.getParameter("listar").equals("listart")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT idtipos, tip_nombre from tipos ;");
        while (rs.next()) {
%>      
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjst('<% out.print(rs.getString(1)); %>','<% out.print(rs.getString(2)); %>')"></i></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}else if (request.getParameter("listar").equals("listarc")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT idcalibres, cal_nombre from calibres ;");
        while (rs.next()) {
%>      
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjsc('<% out.print(rs.getString(1)); %>','<% out.print(rs.getString(2)); %>')"></i></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}else if (request.getParameter("listar").equals("listarm")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT m.idmodelos, m.mod_nombre, mc.mar_nombre from modelos m, marcas mc where m.idmarcas=mc.idmarcas ;");
        while (rs.next()) {
%>      
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><i class="fa fa-check" style="color:green" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="rellenarjsm('<% out.print(rs.getString(1)); %>','<% out.print(rs.getString(2)); %>','<% out.print(rs.getString(3)); %>')"></i></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL " + e);
    }
}
%> 
