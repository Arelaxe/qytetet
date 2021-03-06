# encoding: utf-8

Dir["../ModeloQytetet/*.rb"].each {|file| require_relative file }
require_relative "../ModeloQytetet/qytetet.rb"
require_relative "../ModeloQytetet/metodo_salir_carcel.rb"
require_relative "opcion_menu"
require "singleton"

module ControladorQytetet
  class ControladorQytetet
    include Singleton
    include ModeloQytetet
    attr_writer:nombre_jugadores
    
    def initialize
      @modelo = Qytetet.instance
    end
    
    # Inicializa el modelo desde la vista,
    # para que no tengan que contactar entre ellos
    
    def inicializar_modelo (nombres)
       @nombre_jugadores = nombres
       @modelo.inicializar_juego(nombres)
    end
    
    # Devuelve un array de enteros con los
    # índices de las operaciones válidas
    # dependiendo del estado actual del juego
    
    def obtener_operaciones_juego_validas
      array_de_opciones = Array.new
     
      
      array_de_opciones.push(OpcionMenu.index(:TERMINARJUEGO))
      array_de_opciones.push(OpcionMenu.index(:MOSTRARJUGADORACTUAL))
      array_de_opciones.push(OpcionMenu.index(:MOSTRARJUGADORES))
      array_de_opciones.push(OpcionMenu.index(:MOSTRARTABLERO))
      array_de_opciones.push(OpcionMenu.index(:OBTENERRANKING))
      
      estado = @modelo.estado_juego
      
      case estado
      when ModeloQytetet::EstadoJuego::JA_PREPARADO
        array_de_opciones.push(OpcionMenu.index(:JUGAR))
      when ModeloQytetet::EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
        array_de_opciones.push(OpcionMenu.index(:PASARTURNO))
        array_de_opciones.push(OpcionMenu.index(:COMPRARTITULOPROPIEDAD))
        array_de_opciones.push(OpcionMenu.index(:VENDERPROPIEDAD))
        array_de_opciones.push(OpcionMenu.index(:HIPOTECARPROPIEDAD))
        array_de_opciones.push(OpcionMenu.index(:CANCELARHIPOTECA))
        array_de_opciones.push(OpcionMenu.index(:EDIFICARCASA))
        array_de_opciones.push(OpcionMenu.index(:EDIFICARHOTEL))
       when ModeloQytetet::EstadoJuego::JA_PUEDEGESTIONAR 
        array_de_opciones.push(OpcionMenu.index(:PASARTURNO))
        array_de_opciones.push(OpcionMenu.index(:VENDERPROPIEDAD))
        array_de_opciones.push(OpcionMenu.index(:HIPOTECARPROPIEDAD))
        array_de_opciones.push(OpcionMenu.index(:CANCELARHIPOTECA))
        array_de_opciones.push(OpcionMenu.index(:EDIFICARCASA))
        array_de_opciones.push(OpcionMenu.index(:EDIFICARHOTEL))
      when ModeloQytetet::EstadoJuego::JA_CONSORPRESA
        array_de_opciones.push(OpcionMenu.index(:APLICARSORPRESA))
      when ModeloQytetet::EstadoJuego::JA_ENCARCELADO
        array_de_opciones.push(OpcionMenu.index(:PASARTURNO))
      when ModeloQytetet::EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
        array_de_opciones.push(OpcionMenu.index(:INTENTARSALIRCARCELTIRANDODADO))
        array_de_opciones.push(OpcionMenu.index(:INTENTARSALIRCARCELPAGANDOLIBERTAD))
      end
      
      return array_de_opciones
    
    end 
    
    # Helper para ver si una operación necesita elección de casilla
    
    def necesita_elegir_casilla (opcion)
      opciones_dependientes_de_casilla = Array.new
      
      opciones_dependientes_de_casilla.push(OpcionMenu.index(:HIPOTECARPROPIEDAD))
      opciones_dependientes_de_casilla.push(OpcionMenu.index(:CANCELARHIPOTECA))
      opciones_dependientes_de_casilla.push(OpcionMenu.index(:EDIFICARCASA))
      opciones_dependientes_de_casilla.push(OpcionMenu.index(:EDIFICARHOTEL))
      opciones_dependientes_de_casilla.push(OpcionMenu.index(:VENDERPROPIEDAD))
      
      return opciones_dependientes_de_casilla.include?(opcion)
    end
    
    # Devuelve un array de índices enteros de casillas válidas
    # dependiendo de la opción que se pasas como parámetro
    
    def obtener_casillas_validas (opcion)
       opcion_enumerado = OpcionMenu[opcion]
       
      case opcion_enumerado
      when :HIPOTECARPROPIEDAD
        return @modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)
      when :CANCELARHIPOTECA
        return @modelo.obtener_propiedades_jugador_segun_estado_hipoteca(true)
      else
        return @modelo.obtener_propiedades_jugador
      end
    end
    
    # Método que aplica todas las operaciones seleccionadas
    # en la vista, y devuelve un mensaje feedback
    
    def realizar_operacion(opcion, casilla)
      a_realizar = OpcionMenu[opcion]
      

      case a_realizar
      when :JUGAR
        @modelo.jugar
        if @modelo.estado_juego == EstadoJuego::JA_ENCARCELADO
          to_return = "\n El jugador #{@modelo.jugador_actual.nombre} ha caído en la " +  
                    "casilla juez y tendrá que pasar un tiempo en la cárcel..."
        else
          to_return = "\nDado: #{@modelo.get_valor_dado} \nCasilla: #{@modelo.jugador_actual.casilla_actual}"
        end
        when :APLICARSORPRESA
        to_return = "\nLa sorpresa es #{@modelo.carta_actual}"
        @modelo.aplicar_sorpresa
      when :INTENTARSALIRCARCELPAGANDOLIBERTAD
        encarcelado = @modelo.intentar_salir_carcel(MetodoSalirCarcel::PAGANDOLIBERTAD)
        if (encarcelado)
          to_return = "\nNo se ha salido de la cárcel"
        else
          to_return = "\nSe ha salido de la cárcel"
        end
      when :INTENTARSALIRCARCELTIRANDODADO
        encarcelado = @modelo.intentar_salir_carcel(MetodoSalirCarcel::TIRANDODADO)
        if (encarcelado)
          to_return = "\nNo se ha salido de la cárcel"
        else
          to_return = "\nSe ha salido de la cárcel"
        end
      when :COMPRARTITULOPROPIEDAD
        comprado = @modelo.comprar_titulo_propiedad
        if (!comprado)
          to_return = "\nNo se ha comprado la propiedad #{@modelo.jugador_actual.casilla_actual}"
        else
          to_return = "\nSe ha comprado la propiedad #{@modelo.jugador_actual.casilla_actual}"
        end
      when :HIPOTECARPROPIEDAD
        hipotecada = @modelo.hipotecar_propiedad(casilla)
        if (hipotecada)
          to_return = "\nSe ha hipotecado la propiedad #{casilla}"
        else
          to_return = "\nNo se ha hipotecado la propiedad #{casilla}"
        end
      when :CANCELARHIPOTECA
        cancelada = @modelo.cancelar_hipoteca(casilla)
        
        if (cancelada)
          to_return = "\nSe ha cancelado la hipoteca de la propiedad #{casilla}"
        else
          to_return = "\nNo se ha cancelado la hipoteca de la propiedad #{casilla}"
        end
      when :EDIFICARCASA
        edificada = @modelo.edificar_casa(casilla)
        
        if (edificada)
          to_return = "\nSe ha edificado una casa en la propiedad #{casilla}"
        else
          to_return = "\nNo se ha podido edificar una casa en la propiedad #{casilla}"
        end
      when :EDIFICARHOTEL
        edificada = @modelo.edificar_hotel(casilla)
        
        if (edificada)
          to_return = "\nSe ha edificado un hotel en la propiedad #{casilla}"
        else
          to_return = "\nNo se ha podido edificar un hotel en la propiedad #{casilla}"
        end
      when :VENDERPROPIEDAD
        vendida = @modelo.vender_propiedad(casilla)
        
        if (vendida)
          to_return = "\nSe ha vendido la propiedad #{casilla}"
        else
          to_return = "\nNo se ha podido vender la propiedad #{casilla}"
        end
      when :PASARTURNO
        @modelo.siguiente_jugador
        to_return = "\nLe toca a #{@modelo.jugador_actual.nombre}"
      when :OBTENERRANKING
        @modelo.obtener_ranking
        to_return = "\nLos jugadores ordenados: #{@modelo.jugadores}"
      when :TERMINARJUEGO
        @modelo.obtener_ranking
        to_return = "\nJuego terminado. Ranking: #{@modelo.jugadores}"
      when :MOSTRARJUGADORACTUAL
        to_return = "#{@modelo.jugador_actual}"
      when :MOSTRARJUGADORES
        to_return = "#{@modelo.jugadores}"
      when :MOSTRARTABLERO
        to_return = "#{@modelo.tablero}"
      end

      return to_return
    end
  end
end
