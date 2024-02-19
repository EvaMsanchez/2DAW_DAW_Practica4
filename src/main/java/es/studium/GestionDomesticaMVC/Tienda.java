package es.studium.GestionDomesticaMVC;

public class Tienda {

	int idTienda;
	String nombreTienda;

	public Tienda(int idTienda, String nombreTienda) {
		this.idTienda = idTienda;
		this.nombreTienda = nombreTienda;

	}

	public int getIdTienda() {
		return idTienda;
	}

	public void setIdTienda(int idTienda) {
		this.idTienda = idTienda;
	}

	public String getNombreTienda() {
		return nombreTienda;
	}

	public void setNombreTienda(String nombreTienda) {
		this.nombreTienda = nombreTienda;
	}

}
