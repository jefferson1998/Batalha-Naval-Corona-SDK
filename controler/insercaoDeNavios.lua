local controler = {}

function controler:verificaInsercaoDeNavios(jogador)
	if jogador.insercaoOk == 6 then
		return true
	end
end

return controler
