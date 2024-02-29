<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- Para utilizar las sesiones -->
<%@ page import="es.studium.GestionDomesticaMVC.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gestión Doméstica</title>
	<link rel="stylesheet" href="css/estilos.css">
	<!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="body">
	<div class="container d-flex align-items-center justify-content-center">
		<div class="col-md-5 col-lg-4 mx-auto p-4">
			<h2 class="text-center titulo mb-0 rounded fw-bold">Editar Tienda</h2>
	
			<%
		    Tienda tienda = (Tienda) session.getAttribute("tienda");
		    
		    if (tienda != null) 
		    {
			%>
			<div class="form-group">
				<form action="ServletActualizarTienda" method="POST">
					<!-- Oculto para pasar el idTienda -->
					<input type="hidden" name="idTienda" value="<%= tienda.getIdTienda() %>">		
					<label class="col-form-label mt-3">Nombre</label>
					<input class="form-control" type="text" name="nombreTienda" value="<%= tienda.getNombreTienda() %>" required>
					<br>				      	

					<div class="d-grid mb-2 mt-2">
						<button type="submit" class="btn btn-success">Aceptar</button>
					</div>
				</form>
			</div>	
			
			<form action="tiendas.jsp" method="get">
				<div class="d-grid">
		    		<button type="submit" class="btn btn-dark">Cancelar</button>
		    	</div>	
			</form>
			
			<%
		    } 
			else 
			{
		        out.println("<p>No se encontró la tienda seleccionada.</p>");
		    }
			%>
		</div>		
	</div>
</body>
</html>