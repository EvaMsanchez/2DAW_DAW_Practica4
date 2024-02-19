<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %> <!-- Para utilizar las sesiones -->
<%@ page import="es.studium.GestionDomesticaMVC.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gestión Doméstica</title>
</head>

<body>
	<h2>Nueva Tienda</h2>
	

	
	<form action="ServletAltaTienda" method="POST">
	
		Nombre : <input type="text" name="nombre"  required>
		<br>				      	
		<br>
		<input type="submit" value="Aceptar">
	</form>
	<form action="tiendas.jsp" method="get">
    	<button type="submit">Volver</button>
	</form>
	

	 
	 
	
</body>
</html>