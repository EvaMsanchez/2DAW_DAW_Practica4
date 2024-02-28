<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- Para utilizar las sesiones -->
<%@ page import="es.studium.GestionDomesticaMVC.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gestión Domética</title>
	<link rel="stylesheet" href="css/estilos.css">
	<!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="body">
	<div class="container-fluid d-flex justify-content-center">
	<div class="col-md-5 col-lg-4 mx-auto my-4 card p-4 sombra">
		<h2 class="text-center titulo mb-0 rounded fw-bold">Editar Compra</h2>
		
		<%
	    Compra compra = (Compra) session.getAttribute("compra");
	    
	    if (compra != null) 
	    {
		%>
		<div class="form-group">
			<form action="ServletActualizarCompra" method="POST">
				<label class="col-form-label mt-4">Fecha</label> 
				<input class="form-control" type="date" name="fecha" value="<%= compra.getFecha() %>" required>
				
				<label class="col-form-label mt-4">Tienda</label>
				<select name="tiendas" class="form-select">
			       	<%= session.getAttribute("tiendas") %>
		      	</select>

				<label class="col-form-label mt-4">Importe</label> 
				<input class="form-control" type="number" step="0.01" name="importe" value="<%= compra.getImporte() %>" required>
				<br>
				<br>
				
				<div class="d-grid mb-2">
					<input type="hidden" name="mostrarFecha" value="<%= session.getAttribute("mostrarFecha") %>">
					<input type="hidden" name="paginaOrigen" value="<%= session.getAttribute("paginaOrigen") %>">
					<input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
					<input type="hidden" name="idCompra" value="<%= compra.getIdCompra() %>">
					<button type="submit" class="btn btn-success">Aceptar</button>
				</div>
			</form>
		</div>	
		
		<form action="<%= (session.getAttribute("paginaOrigen").equals("informes")) ? "informes.jsp" : "principal.jsp" %>" method="get">
	    	<div class="d-grid">
	    		<button type="submit" class="btn btn-dark" >Cancelar</button>
			</div>
		</form>
				
		<%
	    } 
		else 
		{
	        out.println("<p>No se encontró la compra seleccionada.</p>");
	    }
		%>
		</div>
	</div>
</body>
</html>