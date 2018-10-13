local primeiroToque
local segundoToque
local tabuleiroModel = require "model.Tabuleiro"
local navios = require "model.Navio"
local controler = require "controler.insercaoDeNavios"

local id = 2

local tabuleiro = {}

--- Cria um novo tabuleiro ---

function tabuleiro:newTabuleiro()
	local dimensaoDoRetangulo = 25
	local posicaoX, posicaoY = 0, 80

	tabuleiro.tabuleiroCriado = {
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
	
	for i=1,10 do
		for j=1,10 do
			posicaoX = posicaoX + 30
			tabuleiro.tabuleiroCriado[i][j] = display.newRect(posicaoX, posicaoY, dimensaoDoRetangulo, dimensaoDoRetangulo )
			tabuleiro.tabuleiroCriado[i][j].linha = i
			tabuleiro.tabuleiroCriado[i][j].coluna = j
			tabuleiro.tabuleiroCriado[i][j]:addEventListener( "touch", adicionarJogada )
		end
		posicaoY = posicaoY + 30
		posicaoX = 0
	end

	return tabuleiro.tabuleiroCriado
end

--- Adiciona a jogada no tabuleiro ---

function adicionarJogada(event)
	
	local nomeNavio, navioDaVez = navios:getUniqueNavio(id)

	 if tabuleiro.player.insercaoOk <= 5 then

		if event.phase == "began" then

			if primeiroToque == nil  then

				primeiroToque = {linha = event.target.linha, coluna = event.target.coluna}
				event.target:removeEventListener( "touch", adicionarJogada  )

			elseif segundoToque == nil then

				segundoToque = {linha = event.target.linha, coluna = event.target.coluna}
				event.target:removeEventListener( "touch", adicionarJogada  )
				
				local orientacao = tabuleiroModel:verificaJogada(primeiroToque, segundoToque)
				print(id)
				if  orientacao ~= nil then
				 	
				 	tabuleiroModel:inserirNavio(tabuleiro.player, navioDaVez, primeiroToque.linha, primeiroToque.coluna, orientacao)

					tabuleiro:preencherNaviosNaView(navioDaVez, orientacao, event.target.linha, event.target.coluna)

					segundoToque = nil
					primeiroToque = nil
					id = id + 1

					tabuleiro.player.insercaoOk = id
					if controler:verificaInsercaoDeNavios(tabuleiro.player) then
						id = 2
					end

				end
				
			end
			event.target:setFillColor(navioDaVez.rgb[1],navioDaVez.rgb[2],navioDaVez.rgb[3])
			print(mostraTabuleiro(tabuleiro.player.mapa))
			print(tabuleiro.player.nomeJogador)
		 end
 	else
 		if event.phase == "began" then
 			print(tabuleiro.player.nomeJogador)
 		end
 		
 	end
end

---- Preenche o tabuleiro com a cor do navio ----

function tabuleiro:preencherNaviosNaView(navio,orientacao,linha,coluna)
	for i=1,navio.tamanho - 2 do

		if orientacao.linha > 0 then
			tabuleiro.tabuleiroCriado[linha + i][coluna]:setFillColor(navio.rgb[1],navio.rgb[2],navio.rgb[3])
		elseif orientacao.linha < 0 then
			tabuleiro.tabuleiroCriado[linha - i][coluna]:setFillColor(navio.rgb[1],navio.rgb[2],navio.rgb[3])
		elseif orientacao.coluna > 0 then
			tabuleiro.tabuleiroCriado[linha][coluna + i]:setFillColor(navio.rgb[1],navio.rgb[2],navio.rgb[3])
		else 
			tabuleiro.tabuleiroCriado[linha][coluna - i]:setFillColor(navio.rgb[1],navio.rgb[2],navio.rgb[3])
		end

		navio.tamanho = 0

	end

end
--- Verifica jogada ---
function tabuleiro:verificaJogada(primeiroToque, segundoToque)
	
	local orientacao = {linha = segundoToque.linha - primeiroToque.linha,
					  	coluna = segundoToque.coluna - primeiroToque.coluna}

  	if(orientacao.linha ~= 0 and orientacao.coluna ~= 0) then return nil end

  	return orientacao

end

--- Atualiza o estado do tabuleiro (Model) que irá para o Jogador ---

function tabuleiro:atualizaEstadoModel(jogador, navioDaVez, primeiroToque, orientacao)
	
	tabuleiroModel:inserirNavio(jogador, navioDaVez, primeiroToque.linha, primeiroToque.coluna, orientacao)	

	return tabuleiroModel

end

function tabuleiro:jogadorDaVez(jogador)
	tabuleiro.player = jogador 
	-- body
end

--- Mostra o estado do tabuleiro (Testes) ---
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