local navios = {
	
}

--- Pega os navios ---
function navios:getNavios()
	navios = {
		--Submarino = {id = 1, tamanho = 1, rgb = {1,1,0}}, -- cor amarela
		Rebocador = {id = 2, tamanho = 2,  rgb = {1,0,0}}, -- cor vermelha
		Contratorpedo = {id = 3, tamanho = 3, rgb = {0,1,0}}, -- cor verde
	 	Cruzador = {id = 4, tamanho = 4, rgb = {0,0,1}}, -- cor azul
		PortaAvioes = {id = 5, tamanho = 5, rgb = {1,0,1}}, -- cor roxa
	}

	return navios
end

--- Pega um navio por vez pelo id ---

function navios:getUniqueNavio(id)
	for k,v in pairs(navios) do
		if v.id == id then return k,v end
	end
end

return navios