local dimensaoDoRetangulo = 25
local posicaoX, posicaoY = 0, 60
local espelho = require "model.Tabuleiro"
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

function tabuleiro:inserirNavio(linha, coluna, navio)

end



function adicionarJogada(event)
	if event.phase == "began" then
		event.target:setFillColor(0.2, 0.2, 0.2)
	end
	
end

return tabuleiro