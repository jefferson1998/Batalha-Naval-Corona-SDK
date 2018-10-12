local dimensaoDoRetangulo = 25
local posicaoX, posicaoY = 0, 80

local primeiroToque
local segundoToque
local jogador = require "model.Jogador"
local tabuleiroModel = require "model.Tabuleiro"
local navios = require "model.Navio"

local id = 2

local tabuleiro = {
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
}

--- Cria um novo tabuleiro ---

function tabuleiro:newTabuleiro()
	
	for i=1,10 do
		for j=1,10 do
			posicaoX = posicaoX + 30
			tabuleiro[i][j] = display.newRect(posicaoX, posicaoY, dimensaoDoRetangulo, dimensaoDoRetangulo )
			tabuleiro[i][j].linha = i
			tabuleiro[i][j].coluna = j
			tabuleiro[i][j]:addEventListener( "touch", adicionarJogada )
		end
		posicaoY = posicaoY + 30
		posicaoX = 0
	end
end

--- Adiciona a jogada no tabuleiro ---

function adicionarJogada(event)
	
	local nomeNavio, navioDaVez = navios:getUniqueNavio(id)

	if id <= 5 then

		if event.phase == "began" then

			if primeiroToque == nil  then

				primeiroToque = {linha = event.target.linha, coluna = event.target.coluna}
				event.target:removeEventListener( "touch", adicionarJogada  )

			elseif segundoToque == nil then

				segundoToque = {linha = event.target.linha, coluna = event.target.coluna}
				event.target:removeEventListener( "touch", adicionarJogada  )
				
				local orientacao = tabuleiroModel:verificaJogada(primeiroToque, segundoToque)
				
				if  orientacao ~= nil then
				 	jogador.mapa = 	tabuleiro:atualizaEstadoModel(navioDaVez, orientacao, primeiroToque)
					tabuleiro:preencherNaviosNaView(navioDaVez, orientacao, event.target.linha, event.target.coluna)

					segundoToque = nil
					primeiroToque = nil
					id = id + 1

				end
				
			end
			event.target:setFillColor(navioDaVez.rgb[1],navioDaVez.rgb[2],navioDaVez.rgb[3])
			print(mostraTabuleiro(tabuleiroModel))
		end
	end
end

---- Preenche o tabuleiro com a cor do navio ----

function tabuleiro:preencherNaviosNaView(navio,orientacao,linha,coluna)
	for i=1,navio.tamanho - 2 do

		if orientacao.linha > 0 then
			tabuleiro[linha + i][coluna]:setFillColor(navio.rgb[1],navio.rgb[2],navio.rgb[3])
		elseif orientacao.linha < 0 then
			tabuleiro[linha - i][coluna]:setFillColor(navio.rgb[1],navio.rgb[2],navio.rgb[3])
		elseif orientacao.coluna > 0 then
			tabuleiro[linha][coluna + i]:setFillColor(navio.rgb[1],navio.rgb[2],navio.rgb[3])
		else 
			tabuleiro[linha][coluna - i]:setFillColor(navio.rgb[1],navio.rgb[2],navio.rgb[3])
		end

		navio.tamanho = 0

	end

end

function tabuleiro:verificaJogada(primeiroToque, segundoToque)
	
	local orientacao = {linha = segundoToque.linha - primeiroToque.linha,
					  	coluna = segundoToque.coluna - primeiroToque.coluna}

  	if(orientacao.linha ~= 0 and orientacao.coluna ~= 0) then return nil end

  	return orientacao

end

function tabuleiro:atualizaEstadoModel(navioDaVez, orientacao, primeiroToque)
	
	if tabuleiroModel:verificarInsercao(navioDaVez, orientacao, primeiroToque.linha, primeiroToque.coluna) then
		tabuleiroModel:inserirNavio(navioDaVez, primeiroToque.linha, primeiroToque.coluna, orientacao)	
	end

	return tabuleiroModel

end

function mostraTabuleiro(tabuleiro)
	local str = ""
		for i=1,#tabuleiro do
			for j=1,#tabuleiro[i] do
				str =  str .. tabuleiro[i][j]
			end
			str = str .. "\n"
		end
	return str
end

return tabuleiro