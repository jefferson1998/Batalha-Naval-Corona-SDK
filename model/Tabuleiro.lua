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

function tabuleiro:preencherTabuleiro()
	for i=1,10 do
		for j=1,10 do
			tabuleiro[i][j] = 0
		end
	end
end

tabuleiro:preencherTabuleiro()


function tabuleiro:inserirNavio(navio, linha, coluna, tabuleiro)

	if navio.orientacao == "vertical" then
		for i = 1, #tamanho do
			tabuleiro[linha][coluna + i] = navio.tamanho
		end
	else 
		for i = 1, #tamanho do
			tabuleiro[linha + i][coluna] = navio.tamanho
		end
	end
	
end

return tabuleiro