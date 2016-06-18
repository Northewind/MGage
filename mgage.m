function G = mgage(thr, typ)
	%% Расчёт калибров для метрических резьб
	%%
	%% Использование:
	%%     G = mgage(thr, "plug")
	%%     G = mgage(thr, "ring")
	%%     G = mgage(thr, "cplug")
	%%
	%% Выходные параметры:
	%%     G - структура, содержащая поля-размеры рассчитываемого калибра (для ПР и НЕ):
	%%         G.d, G.D   - наружный диаметр, мм
	%%         G.d2, G.D2 - средний диаметр, мм
	%%         G.d1, G.D1 - внутренний диаметр, мм
	%%
	%% Входные параметры:
	%%     thr - структура, содержащая поля-параметры контролируемой резьбы:
	%%         thr.P              - шаг контролируемой резьбы, мм
	%%         thr.d, thr.D       - номинальный наружный диаметр, мм
	%%         thr.Td2, thr.TD2   - допуски среднего диаметра, мм
	%%         thr.esd, thr.EID   - основное отклонение наружного диаметра, мм
	%%         thr.esd2, thr.EID2 - основное отклонение среднего диаметра, мм
	%%         thr.esd1, thr.EID1 - основное отклонение внутреннего диаметра, мм
	%%
	%% Использованные нормативные документы:
	%%     ГОСТ 24705-81 ОНВ. Резьба метрическая. Основные размеры
	%%     ГОСТ 24997-81 Калибры для метрической резьбы. Допуски
	%%

	% Расстояние между линией среднего диаметра и вершиной укороченного профиля резьбы
	F1 = 0.1 * thr.P;
	% Высота исходного треугольника
	thr.H = thr.P / 2 / tand (30);

	switch (typ)
	case "plug"
		thr.D2 = thr.D - 2 * 3/8 * thr.H;
		thr.D1 = thr.D - 2 * 5/8 * thr.H;
		gtol = tol(thr.TD2);
		G.go = plugGO(thr, gtol);
		G.ng = plugNG(thr, gtol, F1);
	case "ring"
		thr.d2 = thr.d - 2 * 3/8 * thr.H;
		thr.d1 = thr.d - 2 * 5/8 * thr.H;
		gtol = tol(thr.Td2);
		G.go = ringGO(thr, gtol);
		G.ng = ringNG(thr, gtol, F1);
	case "cplug"
		thr.d2 = thr.d - 2 * 3/8 * thr.H;
		thr.d1 = thr.d - 2 * 5/8 * thr.H;
		gtol = tol(thr.Td2);
		G.go = cplugGO(thr, gtol, F1);
		G.ng = cplugNG(thr, gtol);
	otherwise
		error("Неизвестный тип объекта");
	endswitch

endfunction


function res = plugGO(thr, gtol)
	res.d = thr.D + thr.EID + gtol.Z_PL;
	res.d = res.d + gtol.T_PL*[-1 1];

	res.d2 = thr.D2 + thr.EID2 + gtol.Z_PL;
	res.d2_wearlim = res.d2 - gtol.W_GO_PL;
	res.d2 = res.d2 + gtol.T_PL/2*[-1 1];

	res.d1 = thr.D1 + thr.EID1 - thr.H/6;
	res.d1 = res.d1 + [-inf 0];
end

function res = plugNG(thr, gtol, F1)
	res.d = thr.D2 + thr.EID2 + thr.TD2 + gtol.T_PL/2 + 2*F1;
	res.d = res.d + gtol.T_PL*[-1 1];

	res.d2 = thr.D2 + thr.EID2 + thr.TD2 + gtol.T_PL/2;
	res.d2_wearlim = res.d2 - gtol.W_NG_PL;
	res.d2 = res.d2 + gtol.T_PL/2*[-1 1];

	res.d1 = thr.D1 + thr.EID1 - thr.H/6;
	res.d1 = res.d1 + [-inf 0];
end

function res = ringGO(thr, gtol)
	res.D = thr.d + thr.esd + gtol.T_PL + thr.H/12;
	res.D = res.D + [0 inf];

	res.D2 = thr.d2 + thr.esd2 - gtol.Z_R;
	res.D2 = res.D2 + gtol.T_R/2*[-1 1];

	res.D1 = thr.d1 + thr.esd1;
	res.D1 = res.D1 + gtol.T_R/2*[-1 1];
end

function res = ringNG(thr, gtol, F1)
	res.D = thr.d + thr.esd + gtol.T_PL/2 + thr.H/12;
	res.D = res.D + [0 inf];

	res.D2 = thr.d2 + thr.esd2 - thr.Td2 - gtol.T_R/2;
	res.D2 = res.D2 + gtol.T_R/2*[-1 1];

	res.D1 = thr.d2 + thr.esd2 - thr.Td2 - gtol.T_R/2 - 2*F1;
	res.D1 = res.D1 + gtol.T_R*[-1 1];
end

function res = cplugGO(thr, gtol, F1)
	%% Расчёт калибра-пробки для контроля износа проходных калибров-колец
	res.d = thr.d2 + thr.esd2 - gtol.Z_R + gtol.W_GO_R + 2*F1;
	res.d = res.d + gtol.T_PL*[-1 1];

	res.d2 = thr.d2 + thr.esd2 - gtol.Z_R + gtol.W_GO_R;
	res.d2 = res.d2 + gtol.T_CP/2*[-1 1];

	res.d1 = thr.d1 + thr.esd1 - gtol.T_R/2 - thr.H/6;
	res.d1 = res.d1 + [-inf 0];
end

function res = cplugNG(thr, gtol)
	%% Расчёт калибра-пробки для контроля износа НЕпроходных калибров-колец
	res.d = thr.d + thr.esd - thr.Td2 - gtol.T_R/2 + gtol.W_NG_R;
	res.d = res.d + gtol.T_PL*[-1 1];

	res.d2 = thr.d2 + thr.esd2 - thr.Td2 + gtol.W_NG_R;
	res.d2 = res.d2 + gtol.T_CP/2*[-1 1];

	res.d1 = thr.d1 + thr.esd1 - thr.Td2 - thr.H/6;
	res.d1 = res.d1 + [-inf 0];
end

