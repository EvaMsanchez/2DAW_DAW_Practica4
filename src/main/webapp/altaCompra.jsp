<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- Para utilizar las sesiones -->

<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gestión Domética</title>
	<!-- Alertify -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script>
</head>

<body>
	<h2>Nueva Compra</h2>
	
	<form action="ServletAltaCompra" method="POST">
		<label>Fecha:</label> <input type="date" name="fecha" value="<%= session.getAttribute("fechaActualEditable") %>" required>
		<br>
		
		<label>Tienda:</label>
		<select name="tiendas" required>
			<%= session.getAttribute("tiendas") %>
		</select>
		
		<br>
		<label>Importe:</label> <input type="number" step="0.01" name="importe" required>
		<br>
		<br>
		
		<input type="hidden" name="mostrarFecha" value="<%= session.getAttribute("mostrarFecha") %>">
		<input type="hidden" name="paginaOrigen" value="<%= session.getAttribute("paginaOrigen") %>">
		<input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
		<input type="submit" value="Aceptar">
		<input type="reset" value="Limpiar">
	</form>	
	<form action="<%= (session.getAttribute("paginaOrigen").equals("informes")) ? "informes.jsp" : "principal.jsp" %>" method="get">
    	<button type="submit">Volver</button>
	</form>

</body>
</html>
