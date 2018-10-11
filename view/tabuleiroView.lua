local dimensaoDoRetangulo = 25
local posicaoX, posicaoY = 0, 80

local primeiroToque
local segundoToque

local espelho = require "model.Tabuleiro"
local navios = require "model.Navio"

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

local navio = {tamanho = 4}

function adicionarJogada(event)


	if event.phase == "began" then
		if primeiroToque == nil  then

			primeiroToque = {linha = event.target.linha, coluna = event.target.coluna}
			event.target:removeEventListener( "touch", adicionarJogada  )

		elseif segundoToque == nil then

			segundoToque = {linha = event.target.linha, coluna = event.target.coluna}
			event.target:removeEventListener( "touch", adicionarJogada  )
			
			local orientacao = tabuleiro:verificaJogada(primeiroToque, segundoToque)
			
			if  orientacao ~= nil then
				
				if espelho:verificarInsercao(navio, orientacao, primeiroToque.linha, primeiroToque.coluna) then
					espelho:inserirNavio(navio, primeiroToque.linha, primeiroToque.coluna, orientacao)
					tabuleiro:preencherNaviosNaView(navio.tamanho-2, orientacao, event.target.linha, event.target.coluna)
					segundoToque = nil
					primeiroToque = nil
				end

			end
			
		end
		event.target:setFillColor(1,1,0)
		print(mostraTabuleiro(espelho))
	end
	
end

function tabuleiro:preencherNaviosNaView(tamanho,orientacao,linha,coluna)
	for i=1,tamanho do

		if orientacao.linha > 0 then
			tabuleiro[linha + i][coluna]:setFillColor(1,1,0)
		elseif orientacao.linha < 0 then
			tabuleiro[linha - i][coluna]:setFillColor(1,1,0)
		elseif orientacao.coluna > 0 then
			tabuleiro[linha][coluna + i]:setFillColor(1,1,0)
		else 
			tabuleiro[linha][coluna - i]:setFillColor(1,1,0)
		end

	end

end

function tabuleiro:verificaJogada(primeiroToque, segundoToque)
	local orientacao = {linha = segundoToque.linha - primeiroToque.linha,
					  	coluna = segundoToque.coluna - primeiroToque.coluna}

  	if(orientacao.linha ~= 0 and orientacao.coluna ~= 0) then return nil end

  	return orientacao
end

function tabuleiro:limparJogadasInvalidas(condicao)
	if condicao then

	end
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