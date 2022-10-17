# ========================== ADICIONANDO INSIGNIAS ==========================
drop trigger if exists trg_batalha_after_insert;
delimiter $$
create trigger trg_batalha_after_insert after insert
on batalha
for each row
begin
	update treinador set qtd_insignias = qtd_insignias + 1
	where idtreinador = NEW.idTreinadorVencedor;
end$$
delimiter ;

# insert into batalha(idTreinadorVencedor, idTreinadorPerdedor) values (1,2), (3,4);
# select * from treinador where idtreinador in (1,2,3,4);

# ========================== ADICIONANDO POKEMON PERDEDOR À ENFERMARIA ==========================
drop trigger if exists trg_round_batalha_after_insert;
delimiter $$
create trigger trg_round_batalha_after_insert after insert
on round_batalha
for each row
begin 
	declare minEnfermaria int;
    declare maxEnfermaria int;
    declare enf int;
    SET minEnfermaria= (select min(idenfermaria) from enfermaria);
    select max(idenfermaria) into maxEnfermaria from enfermaria;
    select RAND()*(maxEnfermaria-minEnfermaria)+minEnfermaria into enf;
	insert into pokemon_enfermaria (idenfermaria, idtreinador, idpokemon, entrada, saida) values (enf, NEW.idTreinadorPerdedor, NEW.idPokemonPerdedor, now(), null);
end$$
delimiter ;
