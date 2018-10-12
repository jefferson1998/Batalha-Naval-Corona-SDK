local tabuleiroModel = require "model.Tabuleiro"
local naviosModel = require "model.Navio"

local jogador = {}

function jogador:newJogador(nome)

	jogador = { nomeJogador = nome,
				mapa = tabuleiroModel,
				navios = naviosModel:getNavios(),
				pontuacao = 0}

	return jogador
end

return jogador