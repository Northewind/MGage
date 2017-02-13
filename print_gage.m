function print_gage(g, p, d, typ)
	%% Расчёт калибров для метрических резьб. Выводит параметры калибров на печать.
	%%
	%% Использование:
	%%     print_gage(g, p, d, "plug")
	%%     print_gage(g, p, d, "ring")
	%%     print_gage(g, p, d, "cplug")
	%%
	%% Входные параметры:
	%%     g - структура, содержащая поля-размеры рассчитываемого калибра (для ПР и НЕ):
	%%         g.go.d,  g.ng.d,  g.go.D,  g.ng.D   - наружный диаметр, мм
	%%         g.go.d2, g.ng.d2, g.go.D2, g.ng.D2  - средний диаметр, мм
	%%         g.go.d1, g.ng.d1, g.go.D1, g.ng.D1  - внутренний диаметр, мм
	%%         g.go.d2_wearlim, g.ng.d2_wearlim,
	%%         g.go.D2_wearlim, g.ng.D2_wearlim    - предельные значения
	%%                                среднего диаметра с учётом износа, мм
	%%     p       - шаг контролируемой резьбы, мм
	%%     d       - номинальный наружный диаметр резьбы, мм
	%%

	switch (typ)
	case "plug"
		printf("Plug-Go for thread %gx%g:\n", d, p);
		printf("    major diameter (d):  %g...%g\n", min(g.go.d), max(g.go.d));
		printf("    major diameter wear limit: %g\n", g.go.d_wearlim);
		printf("    pitch diameter (d2): %g...%g\n", min(g.go.d2), max(g.go.d2));
		printf("    pitch diameter wear limit: %g\n", g.go.d2_wearlim);
		printf("    minor diameter (d1): %g...%g\n", min(g.go.d1), max(g.go.d1));
		printf("Plug-NoGo for thread %gx%g:\n", d, p);
		printf("    major diameter (d):  %g...%g\n", min(g.ng.d), max(g.ng.d));
		printf("    pitch diameter (d2): %g...%g\n", min(g.ng.d2), max(g.ng.d2));
		printf("    pitch diameter wear limit: %g\n", g.ng.d2_wearlim);
		printf("    minor diameter (d1): %g...%g\n", min(g.ng.d1), max(g.ng.d1));
	case "ring"
		printf("Ring-Go for thread %gx%g:\n", d, p);
		printf("    major diameter (D):  %g...%g\n", min(g.go.D), max(g.go.D));
		printf("    pitch diameter (D2): %g...%g\n", min(g.go.D2), max(g.go.D2));
		printf("    pitch diameter wear limit: %g\n", g.go.D2_wearlim);
		printf("    minor diameter (D1): %g...%g\n", min(g.go.D1), max(g.go.D1));
		printf("    minor diameter wear limit: %g\n", g.go.D1_wearlim);
		printf("Ring-NoGo for thread %gx%g:\n", d, p);
		printf("    major diameter (D):  %g...%g\n", min(g.ng.D), max(g.ng.D));
		printf("    pitch diameter (D2): %g...%g\n", min(g.ng.D2), max(g.ng.D2));
		printf("    pitch diameter wear limit: %g\n", g.ng.D2_wearlim);
		printf("    minor diameter (D1): %g...%g\n", min(g.ng.D1), max(g.ng.D1));
	case "cplug"
		printf("CPlug-Go for thread %gx%g:\n", d, p);
		printf("    major diameter (d):  %g...%g\n", min(g.go.d), max(g.go.d));
		printf("    pitch diameter (d2): %g...%g\n", min(g.go.d2), max(g.go.d2));
		printf("    minor diameter (d1): %g...%g\n", min(g.go.d1), max(g.go.d1));
		printf("CPlug-NoGo for thread %gx%g:\n", d, p);
		printf("    major diameter (d):  %g...%g\n", min(g.ng.d), max(g.ng.d));
		printf("    pitch diameter (d2): %g...%g\n", min(g.ng.d2), max(g.ng.d2));
		printf("    minor diameter (d1): %g...%g\n", min(g.ng.d1), max(g.ng.d1));
	end
end

