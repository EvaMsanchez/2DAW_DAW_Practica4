<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gestión Doméstica</title>
	<!-- Alertify -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script>
</head>

<body>
	<h2>Login</h2>
	
    <%
	    String error = (String) session.getAttribute("error");
	    if (error != null) 
	    {
	%>
		    <script>
		        alertify.error("<%= error %>");
		    </script>
	<% 
	        session.removeAttribute("error");
	    } 
    %>
    
    <form action="ServletLogin" method="POST">
		<input type="text" name="usuario" placeholder="usuario" required>
		<br>
		<input type="password" name="password" placeholder="contraseña" required>
		<br>
		<br>
		<input type="submit" value="Aceptar">
        <input type="reset" value="Cancelar">
	</form>

</body>
</html>
