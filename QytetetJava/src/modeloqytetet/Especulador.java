
package modeloqytetet;


public class Especulador extends Jugador {
    private int fianza;
    
    
    // Constructor de especulador
    protected Especulador (Jugador jugador, int fianza){
        super (jugador);
        this.fianza = fianza;
    }
    
    // Método para pagar impuesto 
    @Override
    protected void pagarImpuesto (){
        modificarSaldo (-(getCasillaActual().getCoste()/2));
    }
    
    // Método para consultar si el especulador debe ir a la cárcel
    
    @Override
    protected boolean deboIrACarcel(){
        boolean debe_ir = false;
        debe_ir = super.deboIrACarcel();
        if (!debe_ir)
            debe_ir = !pagarFianza();
        return debe_ir;
    }
    
    // Método privado para pagar la fianza
    
    private boolean pagarFianza(){
        boolean pagada = false;
        
        if (getSaldo() > fianza){
            modificarSaldo(-fianza);
            pagada = true;
        }
        return pagada;
    }
    
    // Método para obtener el factor de especulador
//    @Override
//    protected int getFactorEspeculador(){}
    
    // Método para convertirse
    @Override
    protected Especulador convertirme (int fianza){
        return this;
    }

    // Método que sobreescribe el de jugador y devuelve si puede edificar una casa
    
    @Override
    protected boolean puedoEdificarCasa(TituloPropiedad titulo){
        return (titulo.getNumCasas() < 8 && tengoSaldo(titulo.getPrecioEdificar()));
    }
    
    // Método que sobreescribe el de jugador y devuelve si puede edificar una casa
    
    @Override
    protected boolean puedoEdificarHotel(TituloPropiedad titulo){
        return (titulo.getNumHoteles() < 8 && tengoSaldo(titulo.getPrecioEdificar()) && titulo.getNumCasas() == 4);
    }
    
    @Override
    public String toString(){
        String aDevolver = super.toString();
        aDevolver += "\nFianza: ";
        aDevolver += fianza;
        
        return aDevolver;
    }
    
}