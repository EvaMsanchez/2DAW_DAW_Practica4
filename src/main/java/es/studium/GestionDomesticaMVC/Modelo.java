package es.studium.GestionDomesticaMVC;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.sql.DataSource;

public class Modelo
{
	// Pool de conexiones a la base de datos.
	private DataSource pool;
				
	// Creamos objetos para la conexión
	Connection conn = null; //Objeto "connection", para conectarnos a la base de datos.
	Statement stmt = null; //Objeto, permite ejecutar sentencias SQL.
	ResultSet rs = null; //Objeto, para guardar toda la información que nos devuelve la base de datos.
	
	String sentencia = ""; //Vacío para que sirva para otros elementos luego, se ve en toda la clase.	
	
	// Constructor.
    public Modelo(ServletConfig config) throws ServletException 
    {
        init(config); // Inicializa la conexión al construir el objeto Modelo
    }
		
	// CONEXIÓN.
	public void init(ServletConfig config) throws ServletException
	{
		try
		{
			// Crea un contexto para poder luego buscar el recurso DataSource.
			InitialContext ctx = new InitialContext();
			// Busca el recurso DataSource en el contexto.
			pool = (DataSource) ctx.lookup("java:comp/env/jdbc/gestion_domestica");
			if (pool == null)
			{
				throw new ServletException("DataSource desconocida gestion domestica");
			}
			
			// Obtenemos una conexión del pool
            conn = pool.getConnection();
		} 
		catch (NamingException | SQLException ex) 
		{
            ex.printStackTrace();
		}
	}
	
	
	// Método COMPROBAR CREDENCIALES.
	public int comprobarCredenciales(String u, String c)
	{		
		sentencia = "SELECT*FROM usuarios WHERE nombreUsuario = '"+u+"' AND claveUsuario = SHA2('"+c+"',256);";  //"SHA2": algoritmo de encriptación.
		
		try
		{
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); //READ_ONLY: no permite actualización del contenido.
					
			// Crear un objeto ResultSet para guardar lo obtenido
			// y ejecutar la sentencia SQL.
			rs = stmt.executeQuery(sentencia); //Donde está toda la información "rs".
			
			if(rs.next())
			{
				return rs.getInt("idUsuario"); // Devuelve el idUsuario si las credenciales son correctas.
			}
			else
			{
				return -1;
			}
		}
		catch (SQLException sqle) 
		{
			System.out.println("Error 1-"+sqle.getMessage());
			return -1;
		}
	}
	
	
	// Método COMPRAS MES ACTUAL.
	public ArrayList<Compra> obtenerComprasMesActual(int idUsu)
	{
		ArrayList<Compra> comprasMesActual = new ArrayList<>();
		
		Calendar calendario = Calendar.getInstance();
		int mesActual = calendario.get(Calendar.MONTH)+1;
		int anioActual = calendario.get(Calendar.YEAR);
		
		sentencia = "SELECT idCompra as idCompra, "
				        +   "date_format(fechaCompra, '%d/%m/%Y') as fecha, "
						+ 	"nombreTienda as tienda, "
						+ 	"importeCompra as importe, "
						+   "idTienda as idTienda, "
						+   "idUsuarioFK as idUsuario "
				  + "FROM compras "
				  + "JOIN tiendas ON idTiendaFk = idTienda "
				  + "WHERE "
				  		+	"MONTH(fechaCompra) = "+ mesActual +" AND YEAR(fechaCompra) = "+ anioActual +" AND idUsuarioFk = "+ idUsu
				  + " ORDER BY fechaCompra DESC;";
		
		try
		{
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); //READ_ONLY: no permite actualización del contenido.
					
			// Crear un objeto ResultSet para guardar lo obtenido
			// y ejecutar la sentencia SQL.
			rs = stmt.executeQuery(sentencia); //Donde está toda la información "rs".
			
			while(rs.next())
			{
				int idCompra = rs.getInt("idCompra");
				String fecha = rs.getString("fecha");
				double importe = rs.getDouble("importe");
				String tienda = rs.getString("tienda");
				int idTienda = rs.getInt("idTienda");
				int idUsuario = rs.getInt("idUsuario");
				
				comprasMesActual.add(new Compra(idCompra, fecha, importe, tienda, idTienda, idUsuario));
			}
		}
		catch (SQLException sqle) 
		{
			System.out.println("Error 2-"+sqle.getMessage());
		}
		
		return comprasMesActual;
	}
	
	
	// Método OBTENER DATOS COMPRA SELECCIONADA.
	public Compra obtenerCompraSeleccionada(int idCompra)
	{
		
		// Inicializamos la compra.
		Compra compra = null;
		
		sentencia = "SELECT idCompra as idCompra, "
		        		+   "fechaCompra as fecha, "
		        		+ 	"nombreTienda as tienda, "
		        		+ 	"importeCompra as importe, "
		        		+   "idTienda as idTienda, "
		        		+	"idUsuarioFK as idUsuario "
		          + "FROM compras "
		          + "JOIN tiendas ON idTiendaFk = idTienda "
		          + "WHERE "
		          		+ "idCompra = "+ idCompra +";";
		
		try
		{
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); //READ_ONLY: no permite actualización del contenido.
			
			// Crear un objeto ResultSet para guardar lo obtenido
			// y ejecutar la sentencia SQL.
			rs = stmt.executeQuery(sentencia); //Donde está toda la información "rs".
			
			if (rs.next()) 
			{
				compra = new Compra(rs.getInt("idCompra"), rs.getString("fecha"), rs.getDouble("importe"), rs.getString("tienda"), rs.getInt("idTienda"), rs.getInt("idUsuario"));
			}
		}
		catch (SQLException sqle)
		{
			System.out.println("Error 3-"+sqle.getMessage());
		}
		
		return compra;
	}

	
	// Método OBTENER LISTADO TIENDAS PARA SELECT EDITAR.
	public String selectTiendasEditar(int idTiendaSeleccionada, String tiendaSeleccionada)
	{
		String resultado = "";
		sentencia = "SELECT idTienda, nombreTienda "
				  + "FROM tiendas "
				  + "ORDER BY nombreTienda ASC;";

		try
		{
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); //READ_ONLY: no permite actualización del contenido.
			
			// Crear un objeto ResultSet para guardar lo obtenido
			// y ejecutar la sentencia SQL.
			rs = stmt.executeQuery(sentencia); //Donde está toda la información "rs".
			
			while (rs.next()) 
			{
				int idTienda = rs.getInt("idTienda");
				String nombreTienda = rs.getString("nombreTienda");
			
				if (idTienda == idTiendaSeleccionada || nombreTienda.equals(tiendaSeleccionada))
				{
					resultado += "<option value='" + idTienda + "' selected>" + nombreTienda + "</option>";
				}
				else
				{
					resultado += "<option value='" + idTienda + "'>" + nombreTienda + "</option>";
				}
			}
		}
		catch (SQLException sqle)
		{
			System.out.println("Error 4-"+sqle.getMessage());
		}
		
		return resultado;
	}
	
	
	// Método ACTUALIZAR COMPRA.
	public int actualizarCompra(int idCompra, String fecha, double importe, int idTienda, int idUsu)
	{	
		sentencia = "UPDATE compras "
				  + "SET "	
				  		+ "fechaCompra = '"+ fecha +"', "
						+ "importeCompra = '"+ importe +"', "
						+ "idTiendaFK = '"+ idTienda +"', "
						+ "idUsuarioFK = '"+ idUsu +"' "
				  + "WHERE "
				        + "idCompra = "+ idCompra +";";
				
		try
		{
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); //READ_ONLY: no permite actualización del contenido.
					
			// Crear un objeto ResultSet para guardar lo obtenido
			// y ejecutar la sentencia SQL.
			stmt.executeUpdate(sentencia); //Donde está toda la información "rs".
			return 0; 
		}
		catch (SQLException sqle) 
		{
			System.out.println("Error 5-"+sqle.getMessage());
			return 1;
		}
	}
	
	
	// Método BORRAR COMPRA.
	public int borrarCompra(int idCompra)
	{	
		sentencia = "DELETE FROM compras WHERE idCompra =" + idCompra +";";
				
		try
		{
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); //READ_ONLY: no permite actualización del contenido.
					
			// Crear un objeto ResultSet para guardar lo obtenido
			// y ejecutar la sentencia SQL.
			stmt.executeUpdate(sentencia); //Donde está toda la información "rs".
			return 0; 
		}
		catch (SQLException sqle) 
		{
			System.out.println("Error 6-"+sqle.getMessage());
			return 1;
		}
	}
	
	
	// Método OBTENER LISTADO TIENDAS PARA SELECT ALTA.
	public String selectTiendasAlta()
	{
		// value: vacío para que al aceptar salga un mensaje de que hay que elegir una opción.
		String resultado = "<option disabled value='' selected>Seleccionar tienda</option>";
		sentencia = "SELECT idTienda, nombreTienda "
				  + "FROM tiendas "
				  + "ORDER BY nombreTienda ASC;";

		try
		{
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); //READ_ONLY: no permite actualización del contenido.
			
			// Crear un objeto ResultSet para guardar lo obtenido
			// y ejecutar la sentencia SQL.
			rs = stmt.executeQuery(sentencia); //Donde está toda la información "rs".
			
			while (rs.next()) 
			{
				int idTienda = rs.getInt("idTienda");
				String nombreTienda = rs.getString("nombreTienda");
				resultado += "<option value='" + idTienda + "'>" + nombreTienda + "</option>";
			}
		}
		catch (SQLException sqle)
		{
			System.out.println("Error 7-"+sqle.getMessage());
		}
		
		return resultado;
	}
		
		
	// Método INSERTAR NUEVA COMPRA.
	public int altaCompra(String fecha, double importe, int idTienda, int idUsuario)
	{
		sentencia = "INSERT INTO compras "
				  + "VALUES (null, '"+ fecha +"', '"+ importe +"', '"+ idTienda +"', '"+ idUsuario+"');";
		
		try
		{
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); //READ_ONLY: no permite actualización del contenido.
					
			// Crear un objeto ResultSet para guardar lo obtenido
			// y ejecutar la sentencia SQL.
			stmt.executeUpdate(sentencia); //Donde está toda la información "rs".
			return 0; 
		}
		catch (SQLException sqle) 
		{
			System.out.println("Error 8-"+sqle.getMessage());
			return 1;
		}
	}
	
	
	// Método OBTENER LISTADO FECHAS PARA SELECT INFORMES.
	public String selectInformes(int idUsu)
	{
		String resultado = "<option value='' disabled selected>Seleccionar el mes...</option>";	
		sentencia = "SELECT DATE_FORMAT(MAX(fechaCompra), '%M %Y') as fechaOrdenada "
				  + "FROM compras "
				  + "WHERE "
				  		+ 	"idUsuarioFK = "+ idUsu
				  + " GROUP BY YEAR(fechaCompra), MONTH(fechaCompra) "
				  + "ORDER BY MAX(fechaCompra) DESC;";

		try
		{
			// SET lc_time_names: para mostrar los nombres de los meses en español.
	        String mesEspanol = "SET lc_time_names = 'es_ES'";
	        
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); //READ_ONLY: no permite actualización del contenido.
			// Se ejecuta antes que la consulta. 
			stmt.execute(mesEspanol);
			
			// Crear un objeto ResultSet para guardar lo obtenido
			// y ejecutar la sentencia SQL.
			rs = stmt.executeQuery(sentencia); //Donde está toda la información "rs".
			
			while (rs.next()) 
			{
				String fecha = rs.getString("fechaOrdenada");
				resultado += "<option value='" + fecha + "'>" + fecha + "</option>";
			}
		}
		catch (SQLException sqle)
		{
			System.out.println("Error 9-"+sqle.getMessage());
		}
		
		return resultado;
	} 
	
	
	// Método COMPRAS MES SELECCIONADO.
	public ArrayList<Compra> obtenerComprasMes(String fechaSeleccionada, int idUsu)
	{
		ArrayList<Compra> comprasMes = new ArrayList<>();
		
		// Separar el mes y el año.
	    String[] fechaSeparada = fechaSeleccionada.split(" ");
	    String mes = fechaSeparada[0]; // Mes en letras en español.
	    String anio = fechaSeparada[1];
		
		sentencia = "SELECT idCompra as idCompra, "
				        +   "date_format(fechaCompra, '%d/%m/%Y') as fecha, "
						+ 	"nombreTienda as tienda, "
						+ 	"importeCompra as importe, "
						+   "idTienda as idTienda, "
						+   "idUsuarioFK as idUsuario "
				  + "FROM compras "
				  + "JOIN tiendas ON idTiendaFk = idTienda "
				  + "WHERE "
				  		+   "MONTHNAME(fechaCompra) = '"+ mes +"' AND YEAR(fechaCompra) = "+ anio +" AND idUsuarioFk = "+ idUsu
				  + " ORDER BY fechaCompra DESC;";
		
		try
		{
			// SET lc_time_names: para mostrar los nombres de los meses en español o comparar.
	        String mesEspanol = "SET lc_time_names = 'es_ES'";
	        
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); //READ_ONLY: no permite actualización del contenido.
			// Se ejecuta antes que la consulta. 
			stmt.execute(mesEspanol);
			
			// Crear un objeto ResultSet para guardar lo obtenido
			// y ejecutar la sentencia SQL.
			rs = stmt.executeQuery(sentencia); //Donde está toda la información "rs".
			
			while(rs.next())
			{
				int idCompra = rs.getInt("idCompra");
				String fecha = rs.getString("fecha");
				double importe = rs.getDouble("importe");
				String tienda = rs.getString("tienda");
				int idTienda = rs.getInt("idTienda");
				int idUsuario = rs.getInt("idUsuario");
				
				comprasMes.add(new Compra(idCompra, fecha, importe, tienda, idTienda, idUsuario));
			}
		}
		catch (SQLException sqle) 
		{
			System.out.println("Error 10-"+sqle.getMessage());
		}
		
		return comprasMes;
	}
	
	
	// Método OBTENER DATOS TIENDA SELECCIONADA.
		public Tienda obtenerTiendaSeleccionada(int idTienda) {
			// Inicializamos la tienda.
			Tienda tienda = null;

			sentencia = "SELECT idTienda as idTienda, " + "nombreTienda as nombreTienda " + "FROM tiendas " + "WHERE "
					+ "idTienda = " + idTienda + ";";

			try {
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); 
				// READ_ONLY: no permite actualización del contenido.

				// Crear un objeto ResultSet para guardar lo obtenido
				// y ejecutar la sentencia SQL.
				rs = stmt.executeQuery(sentencia); // Donde está toda la información "rs".

				if (rs.next()) {
					tienda = new Tienda(rs.getInt("idTienda"), rs.getString("nombreTienda"));
				}
			}

			catch (SQLException sqle) {
				System.out.println("Error 9-" + sqle.getMessage());
			}

			return tienda;
		}
		// =============================================================================================

		// Método OBTENER LISTADO TIENDAS.
		public ArrayList<Tienda> obtenerListaTiendas() {
			
			ArrayList<Tienda> listaTiendas = new ArrayList<>();

			sentencia = "SELECT * " + "FROM tiendas ORDER By nombreTienda" + ";";

			try {
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); 
				// READ_ONLY: no permite actualización del contenido.

				// Crear un objeto ResultSet para guardar lo obtenido
				// y ejecutar la sentencia SQL.
				rs = stmt.executeQuery(sentencia); // Donde está toda la información "rs".

				while (rs.next()) {
					int idTienda = rs.getInt("idTienda");
					String nombreTienda = rs.getString("nombreTienda");

					listaTiendas.add(new Tienda(idTienda, nombreTienda));
				}
			}

			catch (SQLException sqle) {
				System.out.println("Error 10-" + sqle.getMessage());
			}

			return listaTiendas;
		}

		// =============================================================================================
		// Método ACTUALIZAR TIENDA ...

		public int actualizarTienda(int idTienda, String nombre) {
			/* sentencia = "UPDATE tiendas " + "SET " + "nombreTienda = '" + nombre + "' WHERE " + "idTienda ='" + idTienda
					+ "';"; */
			sentencia = " UPDATE tiendas "
					+ " SET nombreTienda = '" + nombre 
					+ "' WHERE idTienda = '"+ idTienda +"' ;";

			try {
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); 
				// READ_ONLY: no permite actualización del contenido. Crear un objeto ResultSet para guardar lo obtenido
				// y ejecutar la sentencia SQL.
				stmt.executeUpdate(sentencia); // Donde está toda la información "rs".
				return 0;
			} catch (SQLException sqle) {
				System.out.println("Error 11-" + sqle.getMessage());
				return 1;
			}
		}
		
		// =============================================================================================
		// Método BORRAR TIENDA ...
		
		public int borrarTienda(int idTienda) {
			sentencia = "DELETE FROM tiendas WHERE idTienda =" + idTienda + ";";
		
			try {
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); 
				// READ_ONLY: no permite actualización del contenido.

				// Crear un objeto ResultSet para guardar lo obtenido
				// y ejecutar la sentencia SQL.
				stmt.executeUpdate(sentencia); // Donde está toda la información "rs".
				return 0;
			} catch (SQLException sqle) {
				System.out.println("Error 12-" + sqle.getMessage());
				return 1;
			}
			
		}
		
		// Método INSERTAR NUEVA TIENDA.
			public int altaTienda(String nombre) {
				
				sentencia = "SELECT * FROM tiendas WHERE nombreTienda = '" + nombre + "';";
				
				try {
					
					stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); 
					
					rs = stmt.executeQuery(sentencia); 
					
					if(rs.next()) {
						System.out.println("Error 13- duplicado")  ;
						return -1;
						
					}
				
			} catch (SQLException sqle) {
				System.out.println("Error 14-" + sqle.getMessage());
				return 1;
			}
				
				sentencia = "INSERT INTO tiendas " + "VALUES (null, '" + nombre + "');";

				try {
					stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY); 
					// READ_ONLY: no permite actualización del contenido.

					// Crear un objeto ResultSet para guardar lo obtenido
					// y ejecutar la sentencia SQL.
					stmt.executeUpdate(sentencia); // Donde está toda la información "rs".
					return 0;
				} catch (SQLException sqle) {
					System.out.println("Error 15-" + sqle.getMessage());
					return 1;
				}
			}
			
	
}
