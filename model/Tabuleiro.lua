local tabuleiro = {
	
}

function tabuleiro:newTabuleiro()
	local mapa = {
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
			mapa[i][j] = 0
		end
	end

	return mapa
end

---- Verifica inserção do navio ----

function tabuleiro:verificarInsercao(mapa, navio, orientacao, linha, coluna)

	if orientacao.linha > 0 then
		
		for i = 0, navio.tamanho - 1 do
			if mapa[linha + i][coluna] ~= 0 then
				return false
			end
		end

	elseif orientacao.linha < 0 then
		
		for i = 0, navio.tamanho - 1 do
			if mapa[linha - i][coluna] ~= 0 then
				return false
			end
		end

	elseif orientacao.coluna > 0 then
		
		 i=0, navio.tamanho, 1 do
			if mapa[linha][coluna + i] ~=  0 then
				 return false
			end
		end

	elseif orientacao.coluna < 0 then

		for i=0, navio.tamanho, 1 do
			if mapa[linha][coluna - i] ~=  0 then
				 return false
			end
		end

	end

	return true
end

---- inserção de navio ----

function tabuleiro:inserirNavio(jogador, navio, linha, coluna, orientacao)
	local mapaJogador = jogador.mapa
	local podeInserir = tabuleiro:verificarInsercao(mapaJogador, navio, orientacao, linha, coluna)

	if podeInserir == true then
		if orientacao.linha > 0 then
			for i = 0, navio.tamanho -1 do
				mapaJogador[linha + i][coluna] = navio.tamanho
			end
		elseif orientacao.linha < 0 then
			for i = 0, navio.tamanho -1 do
				mapaJogador[linha - i][coluna] = navio.tamanho
			end
		elseif orientacao.coluna > 0 then
			for i = 0, navio.tamanho -1 do
				mapaJogador[linha][coluna + i] = navio.tamanho
			end
		 		
		elseif orientacao.coluna < 0 then
			for i = 0, navio.tamanho-1 do
				mapaJogador[linha][coluna - i] = navio.tamanho
			end
		end
		-- print(podeInserir)
	end

	return podeInserir

end

---- verifica jogada ----

function tabuleiro:verificaJogada(primeiroToque, segundoToque)
	
	local orientacao = {linha = segundoToque.linha - primeiroToque.linha,
					  	coluna = segundoToque.coluna - primeiroToque.coluna}

  	if(orientacao.linha ~= 0 and orientacao.coluna ~= 0) then return nil end

  	return orientacao
end


--- ver tabuleiro ---

function tabuleiro:viewTabuleiro()
	local srt = ""
	for i=1, #tabuleiro do
		for j=1, #tabuleiro[i] do
	
			srt = srt .. tabuleiro[i][j]
		
		end

			srt = srt .. "\n"
	end
	return str

end 

return tabuleiro