<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- Para utilizar las sesiones -->
<%@ page import="java.util.ArrayList" %>
<%@ page import="es.studium.GestionDomesticaMVC.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gestión Doméstica</title>
	<link rel="stylesheet" href="css/estilos.css">
	<!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<!-- Alertify -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script>
</head>

<body class="body">
	<div class="container justify-content-center fondo">
		<div class="col-md-8 col-lg-7 mx-auto p-4">
			<h2 class="text-center titulo mb-0 rounded fw-bold">Gestión Doméstica</h2>
			<br>
			<h3 class="text-center"><%=session.getAttribute("fecha") %></h3>
	
			<%
			@SuppressWarnings("unchecked")
		    // Obtener la lista de compras de la sesión.
		    ArrayList<Compra> compras = (ArrayList<Compra>) session.getAttribute("compras");
			
			double total = 0.0;
			%>
			
			<p class="text-center">Total Actual: <span class="fw-bold"><%= String.format("%.2f €", total) %></span></p>
			<br>
			<div class="row">
	               <div class="col">
	               	<form action="ServletSelectAlta" method="POST">
						<input type="hidden" name="paginaOrigen" value="principal">
						<input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
						<button type="submit" class="btn btn-success">Agregar Compra</button>
					</form>
				</div>
				<div class="col d-flex justify-content-end">
					<form action="ServletTiendas" method="POST">	
	    				<button type="submit" class="btn btn-primary me-3">Tiendas</button>
	    			</form>
	    			
	    			<form action="ServletSelectInformes" method="POST">
				    	<input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
						<button type="submit" class="btn btn-primary">Informes</button>
					</form>	
				</div>
			</div>
			<br>
		
			<%
		    // Verificar si hay compras en la lista.
		    if (compras != null && !compras.isEmpty()) 
		    {
				for (Compra compra : compras) 
				{ 
					// Sumar el importe de la compra al total.
		            total += compra.getImporte();
				}
				%>
			
			<div class="row">
	            <div>
				<table class="table text-center">
					<thead>
					<tr>
						<th>Fecha</th>
						<th>Tienda</th>
						<th>Importe</th>
						<th colspan="2">Acciones</th>
					</tr>
					</thead>
					
				<% 
		        for (Compra compra : compras) 
		        {%>	
		        	<tbody>
					<tr>
					    <td><%= compra.getFecha() %></td>
					    <td><%= compra.getNombreTienda() %></td>
					    <td><%= String.format("%.2f €", compra.getImporte()) %></td>
					    
					    <td>
							<form action="ServletEditarCompra" method="POST">
								<input type="hidden" name="paginaOrigen" value="principal">
								<input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
								<!-- Oculto para pasar el idCompra -->
								<input type="hidden" name="idCompra" value="<%= compra.getIdCompra() %>">
								<button type="submit" class="btn btn-info">Editar</button>
							</form>
						</td>
					    <td>
							<form action="ServletBorrarCompra" method="POST" id="borrar<%= compra.getIdCompra() %>">
								<input type="hidden" name="paginaOrigen" value="principal">
								<!-- Oculto para pasar el idCompra -->
								<input type="hidden" name="idCompra" value="<%= compra.getIdCompra() %>">
								<button type="button" onclick="confirmarBorrado(<%= compra.getIdCompra() %>)" class="btn btn-danger">Borrar</button>
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
				out.println("<p class='text-center'>No hay compras registradas para el mes actual.</p>");
			}%>	
			<br>
			<br>
			
			<div class="text-center">		    
				<form action="ServletPrincipal" method="POST">
					<input type="hidden" name="accion" value="salir">
					<button type="submit" class="btn btn-dark">Cerrar sesión</button>
				</form>	
			</div>
			
			
			<%
			// Mensaje editar.
			Boolean editado = (Boolean) session.getAttribute("editado");
			if (editado != null) 
			{
			    if (editado) 
			    {
			        out.println("<script>alertify.success('La compra se ha actualizado correctamente.');</script>");
			    } 
			    else 
			    {
			        out.println("<script>alertify.error('Error: La compra no pudo ser actualizada.');</script>");
			    }
			    session.removeAttribute("editado");
			}
		
			//Mensaje borrar.
		    Boolean borrado = (Boolean) session.getAttribute("borrado");
		    if (borrado != null) 
		    {
		    	if (borrado) 
		    	{
		            out.println("<script>alertify.success('La compra se ha eliminado correctamente.');</script>");
		        } 
		    	else 
		    	{
		            out.println("<script>alertify.error('Error: La compra no pudo ser eliminada.');</script>");
		        }
		        session.removeAttribute("borrado");
		    }
		    
			// Mensaje alta.
			Boolean alta = (Boolean) session.getAttribute("alta");
			if (alta != null) 
			{
			    if (alta) 
			    {
			        out.println("<script>alertify.success('La compra se ha insertado correctamente.');</script>");
			    } 
			    else 
			    {
			        out.println("<script>alertify.error('Error: La compra no pudo ser insertada.');</script>");
			    }
			    session.removeAttribute("alta");
			}
		    %>
		    
		    <script>
		    function confirmarBorrado(idCompra) 
		    {  		    	
		        // Mostrar mensaje de confirmación con Alertify.
		        alertify.confirm( "¿Estás seguro de que deseas eliminar esta compra?", 
		        function (a) 
		        {
		        	
		            if(a)
		            {
		                document.getElementById("borrar" + idCompra).submit();
		            } 
		            else {}
		        });
		    }
		    </script>
		</div>	    
	</div>
</body>
</html>
