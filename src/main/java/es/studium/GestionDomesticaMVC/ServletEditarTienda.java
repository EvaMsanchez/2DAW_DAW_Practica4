package es.studium.GestionDomesticaMVC;

import java.io.IOException;

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
 * Servlet implementation class ServletEditarTienda
 */
@WebServlet("/ServletEditarTienda")
public class ServletEditarTienda extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Modelo modelo; // Declarar el objeto Modelo como miembro del servlet.

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        // Crear el objeto Modelo utilizando el ServletConfig
        modelo = new Modelo(config);
    }

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletEditarTienda() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
		
		
		// Cogemos el idTienda del registro seleccionado.
		int idTienda = Integer.parseInt(request.getParameter("idTienda"));
		
		Tienda tiendaSeleccionada = modelo.obtenerTiendaSeleccionada(idTienda);
		session.setAttribute("tienda", tiendaSeleccionada);
			        
		
        // Establecemos el contexto del proyecto
        ServletContext servletContext = getServletContext();
        // Creamos objeto para indicar a dónde dirigir la respuesta
        RequestDispatcher requestDispatcher = servletContext.getRequestDispatcher("/editarTienda.jsp");
        // Redirigir el flujo
        requestDispatcher.forward(request, response);
    }
}
