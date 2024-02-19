package es.studium.GestionDomesticaMVC;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
 * Servlet implementation class ServletAltaCompra
 */
@WebServlet("/ServletSelectAlta")
public class ServletSelectAlta extends HttpServlet 
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
    public ServletSelectAlta() {
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
		
		
		// Obtener las tiendas y guardarlas en la sesión.
		String tiendas = modelo.selectTiendasAlta();
		session.setAttribute("tiendas", tiendas);
		
		// Para obtener la fecha de hoy, que la muestre en el jsp y se pueda editar (meterla en formato americano porque tiene type="date")
		Date fechaCompleta = new Date();
		SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
		String fechaActual = formatoFecha.format(fechaCompleta);
		// Guardamos la fecha en la sesión.
		session.setAttribute("fechaActualEditable", fechaActual);
		
		// Cogemos la fecha seleccionada.
	    String fechaSeleccionada = (String) session.getAttribute("mostrarFecha");
	    session.setAttribute("mostrarFecha", fechaSeleccionada);
		String paginaOrigen = request.getParameter("paginaOrigen");
		session.setAttribute("paginaOrigen", paginaOrigen);
		int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
		session.setAttribute("idUsuario", idUsuario);
		
		
		// Establecemos el contexto del proyecto
		ServletContext servletContext = getServletContext();
		// Creamos objeto para indicar a dónde dirigir la respuesta
		RequestDispatcher requestDispatcher = servletContext.getRequestDispatcher("/altaCompra.jsp");
		// Redirigir el flujo
		requestDispatcher.forward(request, response);
	}
}
