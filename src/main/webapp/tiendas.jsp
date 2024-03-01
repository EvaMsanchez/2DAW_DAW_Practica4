<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="es.studium.GestionDomesticaMVC.*"%>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Tiendas</title>
	<link rel="stylesheet" href="css/estilos.css">
	<!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<!-- Alertify -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script>
</head>

<body class="body">
	<div class="container justify-content-center">
		<div class="col-md-7 col-lg-6 mx-auto p-4">
			<h2 class="text-center titulo mb-0 rounded fw-bold">Tiendas</h2>
			<br>
			<br>
			
			<div class="row">
	        	<div class="col">
					<form action="altaTienda.jsp" method="POST">
						<button type="submit" class="btn btn-success">Agregar Tienda</button>
					</form>
				</div>	
			</div>	
			<br>	

			<%
			@SuppressWarnings("unchecked")
			// Obtener la lista de tiendas de la sesión.
			ArrayList<Tienda> tiendas = (ArrayList<Tienda>) session.getAttribute("tiendas");
			
			if (tiendas != null && !tiendas.isEmpty())
			{
			%>	
				<div class="row">
	            <div>
				<table class="table text-center">
					<thead>
					<tr>
						<th>Tienda</th>
						<th>Editar</th>
						<th>Borrar</th>
					</tr>
					</thead>
					
					<tbody>
				
				<%	
				for (Tienda tienda : tiendas) 
				{
				%>
			
					<tr>
						<td><%=tienda.getNombreTienda()%></td>
						
						<td>
							<form action="ServletEditarTienda" method="POST">
								<!-- Oculto para pasar el idTienda -->
								<input type="hidden" name="idTienda" value="<%=tienda.getIdTienda()%>"> 
								<button type="submit" class="btn btn-info">Editar</button>
							</form>
						</td>
						<td>
							<form action="ServletBorrarTienda" method="POST" id="<%="borrar_"+tienda.getIdTienda()%>">
								<!-- Oculto para pasar el idTienda -->
								<input type="hidden" name="idTienda" value="<%=tienda.getIdTienda()%>">
								<button type="button" onclick="confirmarBorrado(<%=tienda.getIdTienda()%>)" class="btn btn-danger">Borrar</button>
							</form>
						</td>
					</tr>
					</tbody>
				<%
				}
				%>
				</table>
				</div>
			</div>	
			<%
			}
			else
			{
				out.println("<br>");
				out.println("<p class='text-center'>No hay tiendas registradas.</p>");
			}%>	
			<br>
			<br>
			
			<div class="text-center">
				<form action="ServletPrincipal" method="POST">
					<button type="submit" class="btn btn-dark">Volver a Principal</button>
				</form>	
			</div>	
			
			<%
			// Mensaje editar Tienda.
			Boolean editadoTienda = (Boolean) session.getAttribute("editadoTienda");
			if (editadoTienda != null) 
			{
				if (editadoTienda) 
				{
					out.println("<script>alertify.success('La tienda se ha actualizado correctamente.');</script>");
				} 
				else 
				{
					out.println("<script>alertify.error('Error: La tienda no pudo ser actualizada.');</script>");
				}
				session.removeAttribute("editadoTienda");
			}
			
			//Mensaje borrar tienda.
			Boolean borradoTienda = (Boolean) session.getAttribute("borradoTienda");
			if (borradoTienda != null) 
			{
				if (borradoTienda) 
				{
					out.println("<script>alertify.success('La tienda se ha eliminado correctamente.');</script>");
				} 
				else 
				{
					out.println("<script>alertify.error('Error: La tienda no pudo ser eliminada porque existen compras asociadas a ella.');</script>");
				}
				session.removeAttribute("borradoTienda");
			}	
			
			// Mensaje alta Tienda.
			Boolean altaTienda = (Boolean) session.getAttribute("altaTienda");
			if (altaTienda != null) 
			{
				if (altaTienda) 
				{
					out.println("<script>alertify.success('La tienda se ha creado correctamente.');</script>");
				} 
				else 
				{
					out.println("<script>alertify.error('Error: La tienda no pudo ser creada.');</script>");
				}
				session.removeAttribute("altaTienda");
			}
			
			// Mensaje tienda Duplicada.
			Boolean tiendaDuplicada = (Boolean) session.getAttribute("tiendaDuplicada");
			if (tiendaDuplicada != null) 
			{
				if (tiendaDuplicada) 
				{
					out.println("<script>alertify.error('La tienda ya existe.');</script>");
				} 
				session.removeAttribute("tiendaDuplicada");
			}
			%>
		
			<script>
			function confirmarBorrado(id) 
			{
				alertify.confirm('Borrar tienda', '¿Estás seguro de que deseas eliminar la tienda?', 
				function()
				{
					// OK
					document.getElementById('borrar_'+id).submit();
				},
				function()
				{});
			}
			</script>
		</div>
	</div>
</body>
</html>
