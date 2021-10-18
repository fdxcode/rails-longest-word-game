require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = []
    letter = (0...9).map { (65 + rand(26)).chr }.join(" ")
    @letters.push(letter)
  end

  def score
    @res = params[:palabra]
    uri = "https://wagon-dictionary.herokuapp.com/#{@res}"
    @result_busqueda = JSON.parse(open(uri).read)
    @letters = params[:letters]
    #validar que la palabra tenga los mismos caracteres que el texto ingresado
    @contador_palabras = 0
    @arr_palabras = @res.upcase.split("")
    @arr_palabras.each do |letter|
      if @arr_palabras.count(letter) > @letters.count(letter)
        @contador_palabras += 1
      end
    end
    #validar respuesta
    if @contador_palabras > 0
      @resultado = "Sorry, but the #{@res.upcase} can't be built out of #{@letters}"
    elsif @result_busqueda["found"] == false
      @resultado = "#{@res.upcase} does not seem to be a valid English word..."
    else
      @resultado = "Congratulations! #{@res.upcase} is a valid English word!"
    end
    return @resultado
  end
end
