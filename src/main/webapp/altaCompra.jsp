<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- Para utilizar las sesiones -->

<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gestión Domética</title>
	<link rel="stylesheet" href="css/estilos.css">
	<!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<!-- Alertify -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script>
</head>

<body class="body">
	<div class="container d-flex align-items-center justify-content-center">
		<div class="col-md-5 col-lg-4 mx-auto p-4">
			<h2 class="text-center titulo mb-0 rounded fw-bold">Agregar Compra</h2>
		
			<div class="form-group">
				<form action="ServletAltaCompra" method="POST">
					<label class="col-form-label mt-3">Fecha</label> 
					<input class="form-control" type="date" name="fecha" value="<%= session.getAttribute("fechaActualEditable") %>" required>
					
					<label class="col-form-label mt-3">Tienda</label>
					<select name="tiendas" class="form-select" required>
						<%= session.getAttribute("tiendas") %>
					</select>
					
					<label class="col-form-label mt-3">Importe</label> 
					<input class="form-control" type="number" step="0.01" name="importe" required>
					<br>
					
					<div class="d-grid gap-2 mb-2 mt-2">
						<input type="hidden" name="mostrarFecha" value="<%= session.getAttribute("mostrarFecha") %>">
						<input type="hidden" name="paginaOrigen" value="<%= session.getAttribute("paginaOrigen") %>">
						<input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
						<button type="submit" class="btn btn-success">Aceptar</button>
						<button type="reset" class="btn btn-dark">Limpiar</button>
					</div>	
				</form>	
			</div>
				
			<form action="<%= (session.getAttribute("paginaOrigen").equals("informes")) ? "informes.jsp" : "principal.jsp" %>" method="get">
		    	<div class="d-grid">
		    		<button type="submit" class="btn btn-dark">Cancelar</button>
		    	</div>	
			</form>
		</div>
	</div>	
</body>
</html>
