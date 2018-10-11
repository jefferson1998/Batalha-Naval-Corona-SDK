local tabuleiroView = require "view.tabuleiroView"
local naviosModel = require "model.Navio"

local jogador = {mapa = tabuleiroView.newTabuleiro(),
				navios = naviosModel:getNavios(),
				pontuacao = 0}