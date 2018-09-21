# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#encoding: utf8

# Imprescindibles para crear
# clases definidas en otros
# archivos del proyecto

require_relative "sorpresa"
require_relative "qytetet"
require_relative "tipo_sorpresa"

module ModeloQytetet
  
  class PruebaQytetet
    
    # Variable de clase, pues main es
    # un método de clase también
    @@juego
    
    
    # Método de clase que crea, a partir
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
    
    # Método de clase que crea, a partir
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
    
    # Método de clase que crea, a partir
    # de un mazo, otro mazo con sorpresas
    # de tipo "ir a casilla" 
    # (aprovechamos el general)
    
    def self.es_de_ir_a_casilla (mazo)
      es_de_tipo(mazo, TipoSorpresa::IRACASILLA)
    end
    
    # Método de clase Main para probar el juego
    
    def self.main
      @@juego = Qytetet.new
      @@juego.inicializarCartasSorpresa
      
      mazo_completo = @@juego.mazo
      
      mazo_mayor_que_cero = sorpresa_mayor_que_cero(mazo_completo)
      puts "///////////////////////////////////////////////////"
      puts "Prueba del método de mazo con valor mayor que cero:"
      puts "///////////////////////////////////////////////////\n\n"
      puts mazo_mayor_que_cero
      
      
      TipoSorpresa::constants.each do |constante|
        tipo = TipoSorpresa.const_get(constante)
        puts "///////////////////////////////////////////////////"
        puts "  Prueba del método de mazo con tipo #{tipo}"
        puts "///////////////////////////////////////////////////\n\n"
        puts es_de_tipo(mazo_completo, tipo)
      end
    end
  end
  
  PruebaQytetet.main
  
end
