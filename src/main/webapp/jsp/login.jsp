<%@include file="conexion.jsp" %>
<%
String action = request.getParameter("action");

if ("login".equals(action)) {
    String user = request.getParameter("user");
    String psw = request.getParameter("psw");

    HttpSession sesion = request.getSession();
    boolean usuarioValido = false;

    try {
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM usuarios WHERE usu_nombre=? AND usu_contraseña=?");
        ps.setString(1, user);
        ps.setString(2, psw);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            usuarioValido = true;
            sesion.setAttribute("logueado", "1");
            sesion.setAttribute("user", rs.getString("usu_nombre"));
            sesion.setAttribute("id", rs.getString("idusuarios"));
            out.print("success");
        }

        if (!usuarioValido) {
            out.print("failure");
        }
    } catch (SQLException e) {
        out.print("Error en la consulta: " + e.getMessage());
    }
} else if ("checkSession".equals(action)) {
    HttpSession sesion = request.getSession(false); 
    if (sesion == null || sesion.getAttribute("logueado") == null) {
        out.print("inactive");
    } else {
        out.print("active");
    }
} else if ("logout".equals(action)) {
    HttpSession sesion = request.getSession(false);
    if (sesion != null) {
        sesion.invalidate();  
        out.print("success");
    } else {
        out.print("No session to invalidate");
    }
}
%>
