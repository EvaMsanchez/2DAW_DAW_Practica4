<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- Para utilizar las sesiones -->
<%@ page import="java.util.ArrayList" %>
<%@ page import="es.studium.GestionDomesticaMVC.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gestión Doméstica</title>
	<!-- Alertify -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script>
</head>

<body>
	<h2>Informes</h2>
	
	<form action="ServletInformes" method="POST">
		<input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
		<select name="fechaSeleccionada" onchange="this.form.submit()">
	       	 
	       	<%= session.getAttribute("mesAnio") %>
	     
		</select>
	</form>	
	

	<%
	@SuppressWarnings("unchecked")
    // Obtener compras del mes seleccionado
    ArrayList<Compra> comprasMes = (ArrayList<Compra>) session.getAttribute("comprasMes");
    
	double total = 0.0;
	
    if (comprasMes != null && !comprasMes.isEmpty()) 
    {
    	  String fechaSeleccionada = (String) session.getAttribute("mostrarFecha");
          if (fechaSeleccionada != null && !fechaSeleccionada.isEmpty()) 
          { %>
              <h3><%= fechaSeleccionada.toUpperCase() %></h3>
          <% 
          }     	
    
    	for (Compra compra : comprasMes) 
		{ 
			// Sumar el importe de la compra al total.
            total += compra.getImporte();
		}
   		%>
   		<p>Total Actual: <%= String.format("%.2f €", total) %></p>
   		
	    <table border="1" style="border-collapse: collapse;">
	        <tr>
	            <th>Fecha</th>
	            <th>Tienda</th>
	            <th>Importe</th>
	            <th>Editar</th>
				<th>Borrar</th>
	        </tr>
	        
		<% for (Compra compra : comprasMes) 
		{ %>
	        <tr>
	            <td><%= compra.getFecha() %></td>
	            <td><%= compra.getNombreTienda() %></td>
	            <td><%= String.format("%.2f €", compra.getImporte()) %></td>
	        
	        	<td>
					<form action="ServletEditarCompra" method="POST">
						<input type="hidden" name="paginaOrigen" value="informes">
						<input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
						<!-- Oculto para pasar el idCompra -->
						<input type="hidden" name="idCompra" value="<%= compra.getIdCompra() %>">
						<input type="submit" value="Editar">
					</form>
				</td>
			    <td>
					<form action="ServletBorrarCompra" method="POST" id="borrarCompra<%= compra.getIdCompra() %>">
						<input type="hidden" name="paginaOrigen" value="informes">
						<!-- Oculto para pasar el idCompra -->
						<input type="hidden" name="idCompra" value="<%= compra.getIdCompra() %>">
						<button type="button" onclick="confirmarBorradoInformes(<%= compra.getIdCompra() %>)">Borrar</button>
					</form>
				</td>
	        </tr>
	    <% 
	    } 
	    %>
	    </table>
	    <br>
	    <br>
	    
	    <form action="ServletSelectAlta" method="POST">
			<input type="hidden" name="paginaOrigen" value="informes">
			<input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
			<input type="submit" value="Nueva Compra">
		</form>
    <% 
    } 
  	%>	

	
	<form action="ServletPrincipal" method="POST">
		<input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
    	<input type="submit" value="Volver a Principal">
	</form>
    
    
    
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
	function confirmarBorradoInformes(idCompra) 
	{
	    // Mostrar mensaje de confirmación con Alertify.
	    alertify.confirm("¿Estás seguro de que deseas eliminar esta compra?", 
	    function (a) 
	    {
	        if(a)
	        {
	            document.getElementById("borrarCompra" + idCompra).submit();
	        } 
	        else {}
	    });
	}
	</script>
      	
</body>
</html>
