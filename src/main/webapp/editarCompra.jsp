<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- Para utilizar las sesiones -->
<%@ page import="es.studium.GestionDomesticaMVC.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gestión Domética</title>
</head>

<body>
	<h2>Editar Compra</h2>
	
	<%
    Compra compra = (Compra) session.getAttribute("compra");
    
    if (compra != null) 
    {
	%>
	<form action="ServletActualizarCompra" method="POST">
		<label>Fecha:</label> <input type="date" name="fecha" value="<%= compra.getFecha() %>" required>
		<br>
		
		<label>Tienda:</label>
		<select name="tiendas">
	       	<%= session.getAttribute("tiendas") %>
      	</select>
      	
		<br>
		<label>Importe:</label> <input type="number" step="0.01" name="importe" value="<%= compra.getImporte() %>" required>
		<br>
		<br>
		
		<input type="hidden" name="mostrarFecha" value="<%= session.getAttribute("mostrarFecha") %>">
		<input type="hidden" name="paginaOrigen" value="<%= session.getAttribute("paginaOrigen") %>">
		<input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
		<input type="hidden" name="idCompra" value="<%= compra.getIdCompra() %>">
		<input type="submit" value="Aceptar">
	</form>
	<form action="<%= (session.getAttribute("paginaOrigen").equals("informes")) ? "informes.jsp" : "principal.jsp" %>" method="get">
    	<button type="submit">Volver</button>
	</form>
	<%
    } 
	else 
	{
        out.println("<p>No se encontró la compra seleccionada.</p>");
    }
	%>
	
</body>
</html>