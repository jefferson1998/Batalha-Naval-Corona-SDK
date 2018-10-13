local tabuleiroModel = require "model.Tabuleiro"
local naviosModel = require "model.Navio"

local jogador = {}

function jogador:newJogador(nome)

	player = { nomeJogador = nome,
				mapa = tabuleiroModel,
				navios = naviosModel:getNavios(),
				insercaoOk = 0,
				pontuacao = 0}

	return player
end

return jogador