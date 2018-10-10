# encoding: utf-8


# Imprescindibles para crear
# instancias clases definidas 
# en otros archivos del proyecto

require_relative "sorpresa"
require_relative "qytetet"
require_relative "tipo_sorpresa"
require_relative "tipo_casilla"
require_relative "casilla"
require_relative "titulo_propiedad"
require_relative "tablero"

module ModeloQytetet
  
  class PruebaQytetet
    
    # Variable de clase
    
    @@juego = Qytetet.new
    
    
    # Método de instancia de clase que crea, a partir
    # de un mazo, otro mazo con sorpresas
    # de valor siempre mayor que cero
    
    def self.sorpresa_mayor_que_cero (mazo)
      a_devolver = Array.new
      
      mazo.each do |sorpresa|
        
        if sorpresa.valor > 0
          a_devolver << sorpresa
        end
      end
      
      a_devolver
    end
    
    # Método de instancia de clase que crea, a partir
    # de un mazo, otro mazo con sorpresas
    # de un tipo específico
    
    def self.es_de_tipo (mazo, tipo)
      a_devolver = Array.new
      
      mazo.each do |sorpresa|
        
        if sorpresa.tipo == tipo
          a_devolver << sorpresa
        end
      end
      
      a_devolver
    end
    
    # Método de instancia de clase que crea, a partir
    # de un mazo, otro mazo con sorpresas
    # de tipo "ir a casilla" 
    # (aprovechamos el general)
    
    def self.es_de_ir_a_casilla (mazo)
      es_de_tipo(mazo, TipoSorpresa::IRACASILLA)
    end
    
    def self.get_nombre_jugadores
      puts "Introduce el número de jugadores"
      numero = gets.chomp.to_s
      
      nombres = Array.new
      
      for i in(0..numero)
        
        puts "Introduce el nombre del jugador #{i}"
        cadena = gets
        nombres << cadena
        
      end
      
      nombres
      
    end
    
    # Método de instancia de clase Main 
    # para probar el juego
    
    def self.main
      
      mazo_completo = @@juego.mazo
      
      mazo_mayor_que_cero = sorpresa_mayor_que_cero(mazo_completo)
      puts "\n\n///////////////////////////////////////////////////"
      puts "Prueba del método de mazo con valor mayor que cero:"
      puts "///////////////////////////////////////////////////\n\n"
      puts mazo_mayor_que_cero
      
      
      TipoSorpresa::constants.each do |constante|
        tipo = TipoSorpresa.const_get(constante)
        puts "\n\n///////////////////////////////////////////////////"
        puts "  Prueba del método de mazo con tipo #{tipo}"
        puts "///////////////////////////////////////////////////\n\n"
        puts es_de_tipo(mazo_completo, tipo)
      end
      
      puts "\n\n///////////////////////////////////////////////////"
      puts "  Prueba del tablero to_s"
      puts "///////////////////////////////////////////////////\n\n"
      
      tablero = @@juego.tablero
      
      puts tablero
      
    end
  end
  
  PruebaQytetet.main
  
end
