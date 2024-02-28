<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gestión Doméstica</title>
	<link rel="stylesheet" href="css/estilos.css">
	<!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<!-- Alertify -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script>
</head>

<body class="body_login">
	<div class="container d-flex align-items-center justify-content-center">
    <div class="card sombraLogin p-4">
        <h2 class="text-center mb-4">Login</h2>
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
			<div class="mb-3">
                <input class="form-control" type="text" name="usuario" placeholder="Usuario" required>
            </div>
            <div class="mb-3">
                <input class="form-control" type="password" name="password" placeholder="Contraseña" required>
            </div>
			<div class="d-grid gap-2">
                <button class="btn btn-success" type="submit">Aceptar</button>
                <button  class="btn btn-dark" type="reset">Cancelar</button>
            </div>
		</form>
	</div>
	</div>
</body>
</html>
