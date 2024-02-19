package es.studium.GestionDomesticaMVC;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ServletActualizarCompra
 */
@WebServlet("/ServletActualizarCompra")
public class ServletActualizarCompra extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	 
	private Modelo modelo; // Declarar el objeto Modelo como miembro del servlet.

    @Override
    public void init(ServletConfig config) throws ServletException 
    {
        super.init(config);
        
        // Crear el objeto Modelo utilizando el ServletConfig
        modelo = new Modelo(config);
    }     
    
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletActualizarCompra() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// Establecer codificación de datos.
		request.setCharacterEncoding("UTF-8");
		// Establecemos el tipo MIME del mensaje de respuesta.
		response.setContentType("text/html");
		// Recoger la sesión actual si existe, en otro caso se crea una nueva.
		HttpSession session = request.getSession();
		
		
		String paginaOrigen = request.getParameter("paginaOrigen");
		int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
		
		// Cogemos los datos actualizados.
		int idCompra = Integer.parseInt(request.getParameter("idCompra"));
		String fecha = request.getParameter("fecha");
		String importeString = request.getParameter("importe");
		importeString = importeString.replace(",", ".");
		double importe = Double.parseDouble(importeString);
		int idTienda = Integer.parseInt(request.getParameter("tiendas"));
		
		int resultado = modelo.actualizarCompra(idCompra, fecha, importe, idTienda, idUsuario);
		
		if(resultado == 0)
		{
			 session.setAttribute("editado", true);
		}
		else
		{
			 session.setAttribute("editado", false);
		}
		
		
		String destino = "/ServletPrincipal";
		if (paginaOrigen != null && paginaOrigen.equals("informes")) 
		{
			String mesAnio = modelo.selectInformes(idUsuario);
			session.setAttribute("mesAnio", mesAnio);
			
	        // Cogemos la fecha seleccionada.
	        String fechaSeleccionada = (String) session.getAttribute("mostrarFecha");
	        session.setAttribute("mostrarFecha", fechaSeleccionada);
	        ArrayList<Compra> comprasMes = modelo.obtenerComprasMes(fechaSeleccionada, idUsuario);
	        session.setAttribute("comprasMes", comprasMes);
	        
	        destino = "/informes.jsp";
	    }
		
		
		// Establecemos el contexto del proyecto
		ServletContext servletContext = getServletContext();
		// Creamos objeto para indicar a dónde dirigir la respuesta
		RequestDispatcher requestDispatcher = servletContext.getRequestDispatcher(destino);
		// Redirigir el flujo
		requestDispatcher.forward(request, response);
	}
}
