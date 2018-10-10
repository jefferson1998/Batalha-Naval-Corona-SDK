local navios = {
	Corveta = {tamanho = 2, orientacao = "vertical", "horizontal"},
	Fragata = {tamanho = 3, orientacao = "vertical", "horizontal"},
	PortaAvioes = {tamanho = 4, orientacao = "vertical", "horizontal"},
	Cruzador = {tamanho = 5, orientacao = "vertical", "horizontal"}
}

function navios:verificarInsercao(tamanho, orientacao, linha, coluna, tabuleiro)

	if orientacao == "vertical" then
		
		for i = tamanho, 1, -1 do
			if tabuleiro[linha + (i - tamanho)][coluna] ~= 0 then
				return false
			end
		end

	else 

		for i=0, tamanho -1, 1 do
			if tabuleiro[linha][coluna + i] ~=  0 then
				 return false
			end
		end

	end

	return true

return navios
