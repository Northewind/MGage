function easy_mgage(p, d, td2, typ)
	%% Расчёт калибров для метрических резьб. Выводит параметры калибров на печать.
	%%
	%% Использование:
	%%     G = easy_mgage(p, d, td2, "plug")
	%%     G = easy_mgage(p, d, td2, "ring")
	%%     G = easy_mgage(p, d, td2, "cplug")
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

	G = mgage(thr, typ);

	switch (typ)
	case "plug"
		printf("Plug-Go for thread %gx%g:\n", d, p);
		printf("    major diameter (d):  %g...%g\n", min(G.go.d), max(G.go.d));
		printf("    pitch diameter (d2): %g...%g\n", min(G.go.d2), max(G.go.d2));
		printf("    pitch diameter wear limit: %g\n", G.go.d2_wearlim);
		printf("    minor diameter (d1): %g...%g\n", min(G.go.d1), max(G.go.d1));
		printf("Plug-NoGo for thread %gx%g\n", d, p);
		printf("    major diameter (d):  %g...%g\n", min(G.ng.d), max(G.ng.d));
		printf("    pitch diameter (d2): %g...%g\n", min(G.ng.d2), max(G.ng.d2));
		printf("    pitch diameter wear limit: %g\n", G.ng.d2_wearlim);
		printf("    minor diameter (d1): %g...%g\n", min(G.ng.d1), max(G.ng.d1));
	case "ring"
		printf("Ring-Go for thread %gx%g:\n", d, p);
		printf("    major diameter (D):  %g...%g\n", min(G.go.D), max(G.go.D));
		printf("    pitch diameter (D2): %g...%g\n", min(G.go.D2), max(G.go.D2));
		printf("    pitch diameter wear limit: %g\n", G.go.D2_wearlim);
		printf("    minor diameter (D1): %g...%g\n", min(G.go.D1), max(G.go.D1));
		printf("Ring-NoGo for thread %gx%g\n", d, p);
		printf("    major diameter (D):  %g...%g\n", min(G.ng.D), max(G.ng.D));
		printf("    pitch diameter (D2): %g...%g\n", min(G.ng.D2), max(G.ng.D2));
		printf("    pitch diameter wear limit: %g\n", G.ng.D2_wearlim);
		printf("    minor diameter (D1): %g...%g\n", min(G.ng.D1), max(G.ng.D1));
	case "cplug"
		printf("CPlug-Go for thread %gx%g:\n", d, p);
		printf("    major diameter (d):  %g...%g\n", min(G.go.d), max(G.go.d));
		printf("    pitch diameter (d2): %g...%g\n", min(G.go.d2), max(G.go.d2));
		printf("    minor diameter (d1): %g...%g\n", min(G.go.d1), max(G.go.d1));
		printf("CPlug-NoGo for thread %gx%g\n", d, p);
		printf("    major diameter (d):  %g...%g\n", min(G.ng.d), max(G.ng.d));
		printf("    pitch diameter (d2): %g...%g\n", min(G.ng.d2), max(G.ng.d2));
		printf("    minor diameter (d1): %g...%g\n", min(G.ng.d1), max(G.ng.d1));
	end
end

