create view treinador_pokemon as
select t.idtreinador, t.nome nome_treinador, pc.idpokemon, p.nome nome_pokemon 
from treinador  t 
inner join pokemon_capturado pc on t.idtreinador=pc.idtreinador
inner join pokemon p on p.idpokemon=pc.idpokemon;

create view pokemon_classe as 
select p.nome, c.descricao
from pokemon p
inner join classe c on p.idclasse=c.idclasse;

create view pokemon_enfermaria as
select e.nome nome_enfermaria, t.nome nome_treinador, p.nome nome_pokemon, entrada, saida
from pokemon_enfermaria pe
inner join enfermaria e on e.idenfermaria=pe.idenfermaria
inner join treinador t on pe.idtreinador=t.idtreinador
inner join pokemon_capturado pc on pe.idpokemon=pc.idpokemon and pe.idtreinador=pc.idtreinador
inner join pokemon p on p.idpokemon=pc.idpokemon;

create view equipe_treinador as
select e.nome nome_equipe, t.nome nome_treinador, qtd_insignias, genero, if(idLider=idtreinador,'Líder','') lider
from equipe e
inner join treinador t on t.idequipe=e.idequipe;
