function easy_mgage(p, d, d_vec, d2_vec, d1_vec, typ)
	%% Расчёт калибров для метрических резьб. Выводит параметры калибров на печать.
	%%
	%% Использование:
	%%     easy_mgage(p, d, d_vec, d2_vec, d1_vec, "plug")
	%%     easy_mgage(p, d, d_vec, d2_vec, d1_vec, "ring")
	%%     easy_mgage(p, d, d_vec, d2_vec, d1_vec, "cplug")
	%%
	%% Входные параметры:
	%%     p         шаг контролируемой резьбы, мм
	%%     d         номинальный наружный диаметр резьбы, мм
	%%     d_vec     двухкомпонентный вектор предельных значений
	%%               наружного диаметра контролируемой резьбы, мм
	%%     d2_vec    двухкомпонентный вектор предельных значений
	%%               среднего диаметра контролируемой резьбы, мм
	%%     d1_vec    двухкомпонентный вектор предельных значений
	%%               внутреннего диаметра контролируемой резьбы, мм
	%%               
	%%     "plug"    тип рассчитыаемого калибра - пробки ПР и НЕ
	%%               (для контроля внутренних резьб)
	%%     "ring"    тип рассчитыаемого калибра - кольца ПР и НЕ
	%%               (для контроля наружных резьб)
	%%     "cplug"   тип рассчитыаемого калибра - контрольные пробки ПР и НЕ
	%%               (для контроля ПР и НЕ колец, контролирующих наружные резьбы)
	%%

	thr.P = p;
	switch (typ)
	case "plug"
		thr.D = d;
		thr.TD2 = abs(diff(d2_vec));
		thr.lim.D = d_vec;
		thr.lim.D2 = d2_vec;
		thr.lim.D1 = d1_vec;
		EIDs = main_devi(thr, "internal");
		thr.EID = EIDs.EID;
		thr.EID2 = EIDs.EID2;
		thr.EID1 = EIDs.EID1;
	case {"ring" "cplug"}
		thr.d = d;
		thr.Td2 = abs(diff(d2_vec));
		thr.lim.d = d_vec;
		thr.lim.d2 = d2_vec;
		thr.lim.d1 = d1_vec;
		esds = main_devi(thr, "external");
		thr.esd = esds.esd;
		thr.esd2 = esds.esd2;
		thr.esd1 = esds.esd1;
	otherwise
		error(["easy_mgage: unknown object type: ", typ]);
	end
	print_gage(mgage(thr, typ), p, d, typ);
end

