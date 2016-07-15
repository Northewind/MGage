function easy_mgage(p, d, td2, typ)
	%% Расчёт калибров для метрических резьб. Выводит параметры калибров на печать.
	%%
	%% Использование:
	%%     easy_mgage(p, d, td2, "plug")
	%%     easy_mgage(p, d, td2, "ring")
	%%     easy_mgage(p, d, td2, "cplug")
	%%
	%% Входные параметры:
	%%     p       - шаг контролируемой резьбы, мм
	%%     d       - номинальный наружный диаметр резьбы, мм
	%%     td2     - допуск среднего диаметра резьбы, мм
	%%

	thr.P = p;
	switch (typ)
	case "plug"
		thr.D = d;
		thr.TD2 = td2;
		thr.EID = thr.EID2 = thr.EID1 = 0;
	case {"ring" "cplug"}
		thr.d = d;
		thr.Td2 = td2;
		thr.esd = thr.esd2 = thr.esd1 = 0;
	otherwise
		error(["easy_mgage: unknown object type: ", typ]);
	end
	print_gage(mgage(thr, typ), p, d, typ);
end

