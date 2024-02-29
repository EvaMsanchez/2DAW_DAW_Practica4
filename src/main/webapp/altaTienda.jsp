<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			<h2 class="text-center titulo mb-0 rounded fw-bold">Agregar Tienda</h2>
			
			<div class="form-group">
				<form action="ServletAltaTienda" method="POST">
					<label class="col-form-label mt-3">Nombre</label> 
					<input class="form-control" type="text" name="nombre" required>			      	
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
		</div>	
	</div>
</body>
</html>