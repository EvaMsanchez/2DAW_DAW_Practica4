<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page session="true"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="es.studium.GestionDomesticaMVC.*"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tiendas</title>
<!-- Alertify -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script>
</head>
<body>
	<h2>Tiendas</h2>

	<%
	// Obtener la lista de tiendas de la sesión.
		@SuppressWarnings("unchecked")
	ArrayList<Tienda> tiendas = (ArrayList<Tienda>) session.getAttribute("tiendas");

	%>

	<table border="1" style="border-collapse: collapse;">
		<tr>
			<th>idTienda</th>
			<th>Tienda</th>
			<th>Editar</th>
			<th>Borrar</th>
		</tr>
		<%
		for (Tienda tienda : tiendas) {
		%>
		<tr>
			<td><%=tienda.getIdTienda()%></td>
			<td><%=tienda.getNombreTienda()%></td>
			<td>
				<form action="ServletEditarTienda" method="POST">

					<!-- Oculto para pasar el idTienda -->
					<input type="hidden" name="idTienda"
						value="<%=tienda.getIdTienda()%>"> <input type="submit"
						value="Editar">
				</form>
			</td>
			<td>
				<!--  <form action="ServletBorrarTienda" method="POST" id="borrar">-->
				<form action="ServletBorrarTienda" method="POST" id="<%="borrar_"+tienda.getIdTienda()%>">
					<!-- Oculto para pasar el idTienda -->
					<input type="hidden" name="idTienda"
						value="<%=tienda.getIdTienda()%>">

					<button type="button" onclick="confirmarBorrado('<%=tienda.getIdTienda()%>')">Borrar</button>
				</form>
			</td>
		</tr>
		<%
		}
		%>
	</table>
	<br>
	<br>
	<form action="altaTienda.jsp" method="POST">
		<input type="submit" value="Nueva Tienda">
	</form>
		<form action="ServletPrincipal" method="POST">
		<input type="submit" value="Volver a Principal">
	</form>	
	
	<%
	// Mensaje editar Tienda.
	Boolean editadoTienda = (Boolean) session.getAttribute("editadoTienda");
	if (editadoTienda != null) {
		if (editadoTienda) {
			out.println("<script>alertify.success('La tienda se ha actualizado correctamente.');</script>");
		} else {
			out.println("<script>alertify.error('Error: La tienda no pudo ser actualizada.');</script>");
		}
		session.removeAttribute("editadoTienda");
	}
	
	//Mensaje borrar tienda.
	Boolean borradoTienda = (Boolean) session.getAttribute("borradoTienda");
	if (borradoTienda != null) {
		if (borradoTienda) {
			out.println("<script>alertify.success('La tienda se ha eliminado correctamente.');</script>");
		} else {
			out.println("<script>alertify.error('Error: La tienda no pudo ser eliminada porque existen compras asociadas a ella.');</script>");
		}
		session.removeAttribute("borradoTienda");
	}	
	
	// Mensaje alta Tienda.
	Boolean altaTienda = (Boolean) session.getAttribute("altaTienda");
	if (altaTienda != null) {
		if (altaTienda) {
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
	if (tiendaDuplicada != null) {
		if (tiendaDuplicada) {
			out.println("<script>alertify.error('La tienda ya existe.');</script>");
		} 
		session.removeAttribute("tiendaDuplicada");
	}
	
	%>

	<script>
		function confirmarBorrado(id) {
			alertify.confirm('Borrar tienda',
					'¿Estás seguro que desea eliminar la tienda?', 
							function() {
						// OK
						document.getElementById('borrar_'+id).submit();
					}, function() {
						// Cancelar
					});
		}
	</script>
</body>
</html>
