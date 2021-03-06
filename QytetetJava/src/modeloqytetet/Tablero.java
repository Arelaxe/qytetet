package modeloqytetet;
import java.util.ArrayList;
    
    /* 
     Esta clase representa
     el tablero, con su conjunto
     de casillas y una referencia
     rápida a cárcel 
    */
    
public class Tablero {
    
    public static final int NUMERO_CASILLAS = 20;
    
    // Atributos privados
    
    private ArrayList<Casilla> casillas; // Vector de casillas del tablero
    private Casilla carcel; // Casilla que contiene la cárcel
    
    // Constructor sin argumentos
    
    Tablero(){
        inicializar();
    }
    
    /* 
        Método privado que inicializa el tablero con las características 
        que hemos decidido
    */
    
    private void inicializar(){
        casillas = new ArrayList<>();
        
        casillas.add (new OtraCasilla (0, TipoCasilla.SALIDA));
        casillas.add (new Calle (1, new TituloPropiedad ("Huerto de "
                + "Calixto y Melibea", 200, 50, (float)1.2, 150, 250)));
        casillas.add (new Calle (2, new TituloPropiedad ("Avda de los"
                + " cipreses", 350, 55, (float)1.3, 200, 255)));
        casillas.add (new Calle (3, new TituloPropiedad ("Avda Carmen"
                + " Martín Gaite", 400, 60, (float)1.4, 300, 300)));
        casillas.add (new OtraCasilla (4, TipoCasilla.PARKING));
        casillas.add (new Calle (5, new TituloPropiedad ("Calle Cuarta", 
                425, 62, (float)1.4, 400, 325)));
        casillas.add (new Calle (6, new TituloPropiedad ("Avda Vicente del"
                + "Bosque", 460, 67, (float)1.43, 450, 350)));
        casillas.add (new OtraCasilla (7, TipoCasilla.SORPRESA));
        casillas.add (new Calle (8, new TituloPropiedad ("Rana de la "
                + "Universidad", 500, 70, (float)1.5, 475, 400)));
        carcel = new OtraCasilla(9, TipoCasilla.CARCEL);
        casillas.add (carcel);
        casillas.add (new Calle (10, new TituloPropiedad ("Palacio de "
                + "Monterrey", 600, 75, (float)1.6, 500, 450)));
        casillas.add (new Calle (11, new TituloPropiedad ("Plaza de "
                + "Barcelona", 750, 80, (float)1.65, 600, 475)));
        casillas.add (new OtraCasilla (12, TipoCasilla.JUEZ));
        casillas.add (new Calle (13, new TituloPropiedad ("Ieronimus", 800,
                85, (float)1.7, 700, 500)));
        casillas.add (new OtraCasilla (14, TipoCasilla.SORPRESA));
        casillas.add (new Calle (15, new TituloPropiedad ("Puente romano",
                900, 90, (float)1.75, 850, 550)));
        casillas.add (new Calle (16, new TituloPropiedad ("Catedral de "
                + "Salamanca", 1000, 95, (float)1.9, 900, 600)));
        casillas.add (new OtraCasilla (17, TipoCasilla.IMPUESTO));
        casillas.add (new OtraCasilla (18, TipoCasilla.SORPRESA));
        casillas.add (new Calle (19, new TituloPropiedad ("Gran Vía", 1500,
                100, (float)1.95, 1000, 700)));
    }
    
    // Consultores
    
    public ArrayList<Casilla> getCasillas(){
        return casillas;
    }
    
    Casilla getCarcel(){
        return carcel;
    }
    
    // Método para verificar si una casilla es la carcel
    
    boolean esCasillaCarcel (int numeroCasilla){
        return numeroCasilla == carcel.getNumeroCasilla();
    }
    
    // Método para obtener una casilla concreta
    
    public Casilla obtenerCasillaNumero(int numeroCasilla){
        return casillas.get(numeroCasilla);
    }
    
    // Método para obtener una casilla, dados una base y un desplazamiento
    
    Casilla obtenerCasillaFinal (Casilla casilla, int desplazamiento){
    
        int posicionFinal = (casilla.getNumeroCasilla() + desplazamiento) % casillas.size();
        
        return obtenerCasillaNumero(posicionFinal);
    }


    // Método toString, que muestra las casillas de un tablero 

    @Override
    public String toString() {
        return "Tablero{" + "casillas=" + casillas + '}';
    }   
}
