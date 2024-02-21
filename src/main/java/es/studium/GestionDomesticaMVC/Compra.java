package es.studium.GestionDomesticaMVC;

public class Compra
{
	int idCompra;
	String fecha;
	double importe;
	String nombreTienda;
	int idTienda;
	int idUsuario;
	
	public Compra(int idCompra, String fecha, double importe, String nombreTienda, int idTienda, int idUsuario)
	{
		this.idCompra = idCompra;
		this.fecha = fecha;
		this.importe = importe;
		this.nombreTienda = nombreTienda;
		this.idTienda = idTienda;	
		this.idUsuario = idUsuario;
	}

	
	public int getIdCompra()
	{
		return idCompra;
	}

	public void setIdCompra(int idCompra)
	{
		this.idCompra = idCompra;
	}

	public String getFecha()
	{
		return fecha;
	}

	public void setFecha(String fecha)
	{
		this.fecha = fecha;
	}

	public double getImporte()
	{
		return importe;
	}

	public void setImporte(double importe)
	{
		this.importe = importe;
	}

	public String getNombreTienda()
	{
		return nombreTienda;
	}

	public void setNombreTienda(String nombreTienda)
	{
		this.nombreTienda = nombreTienda;
	}

	public int getIdTienda()
	{
		return idTienda;
	}

	public void setIdTienda(int idTienda)
	{
		this.idTienda = idTienda;
	}

	public int getIdUsuario()
	{
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario)
	{
		this.idUsuario = idUsuario;
	}
	
}
