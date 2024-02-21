<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- Para utilizar las sesiones -->
<%@ page import="es.studium.GestionDomesticaMVC.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gestión Doméstica</title>
</head>

<body>
	<h2>Editar Tienda</h2>
	
	<%
    Tienda tienda = (Tienda) session.getAttribute("tienda");
    
    if (tienda != null) 
    {
	%>
	
	<form action="ServletActualizarTienda" method="POST">
		<!-- Oculto para pasar el idTienda -->
		<input type="hidden" name="idTienda" value="<%= tienda.getIdTienda() %>">		
		<label>Nombre:</label> <input type="text" name="nombreTienda" value="<%= tienda.getNombreTienda() %>" required>
		<br>				      	
		<br>
		<input type="submit" value="Aceptar">
	</form>
	
	<form action="tiendas.jsp" method="get">
    	<button type="submit">Volver</button>
	</form>
	<%
    } 
	else 
	{
        out.println("<p>No se encontró la tienda seleccionada.</p>");
    }
	%>
	
</body>
</html>