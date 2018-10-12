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

--- Preenche o tabuleiro com 0 ---

function tabuleiro:preencherTabuleiro()
	for i=1,10 do
		for j=1,10 do
			tabuleiro[i][j] = 0
		end
	end

end

tabuleiro:preencherTabuleiro()

---- Verifica inserção do navio ----

function tabuleiro:verificarInsercao(navio, orientacao, linha, coluna)

	if orientacao.linha > 0 then
		
		for i = 0, navio.tamanho - 1 do
			if tabuleiro[linha + i][coluna] ~= 0 then
				return false
			end
		end

	elseif orientacao.linha < 0 then
		
		for i = 0, navio.tamanho - 1 do
			if tabuleiro[linha - i][coluna] ~= 0 then
				return false
			end
		end

	elseif orientacao.coluna > 0 then
		
		 i=0, navio.tamanho, 1 do
			if tabuleiro[linha][coluna + i] ~=  0 then
				 return false
			end
		end

	elseif orientacao.coluna < 0 then

		for i=0, navio.tamanho, 1 do
			if tabuleiro[linha][coluna - i] ~=  0 then
				 return false
			end
		end

	end

	return true
end

---- verifica jogada ----

function tabuleiro:verificaJogada(primeiroToque, segundoToque)
	
	local orientacao = {linha = segundoToque.linha - primeiroToque.linha,
					  	coluna = segundoToque.coluna - primeiroToque.coluna}

  	if(orientacao.linha ~= 0 and orientacao.coluna ~= 0) then return nil end

  	return orientacao
end
---- inserção de navio ----

function tabuleiro:inserirNavio(navio, linha, coluna, orientacao)
	if orientacao.linha > 0 then
		for i = 0, navio.tamanho -1 do
			tabuleiro[linha + i][coluna] = navio.tamanho
		end
	elseif orientacao.linha < 0 then
		for i = 0, navio.tamanho -1 do
			tabuleiro[linha - i][coluna] = navio.tamanho
		end
	elseif orientacao.coluna > 0 then
		for i = 0, navio.tamanho -1 do
			tabuleiro[linha][coluna + i] = navio.tamanho
		end
	 		
	elseif orientacao.coluna < 0 then
		for i = 0, navio.tamanho-1 do
			tabuleiro[linha][coluna - i] = navio.tamanho
		end
	end
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