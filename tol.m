function gtol = tol(thread_tol)
	%% Допуски и величины, определяющие положение полей допусков и предел износа резьбовых калибров (согласно ГОСТ 24997-81).
	%%
	%% Использование:
	%%     gtol = tol(thread_tol)
	%%
	%% Выходные параметры:
	%%     gtol - структура, содержащая поля:
	%%         T_R  - допуск внутреннего и среднего диаметра резьбового проходного и непроходного калибров-колец
	%%         T_PL - допуск наружного и среднего диаметра резьбового проходного и непроходного калибров-пробок
	%%         T_CP - допуск среднего диаметра резьбового контрольного проходного и непроходного калибров-пробок, резьбового калибра-пробки для контроля износа, установочного и сортировочного калибров-пробок
	%%         m    - расстояние между серединой поля допуска T_R проходного и непроходного резьбовых калибров-колец и серединой поля допуска T_CP резьбового контрольного проходного калибра-пробки
	%%         Z_R  - расстояние от середины поля доуска T_R резьбового проходного калибра-кольца до проходного (верхнего) предела среднего диаметра наружной резьбы
	%%         Z_PL - расстояние от середины поля допуска T_PL резьбового проходного калибра-пробки до проходного (нижнего) предела среднего диаметра внутренней резьбы
	%%         W_GO_R - величина среднедопустимого износа резьбовых проходных калибров-колец
	%%         W_GO_PL - величина среднедопустимого износа резьбовых проходных калибров-пробок
	%%         W_NG_R - величина среднедопустимого износа резьбовых непроходных калибров-колец
	%%         W_NG_PL - величина среднедопустимого износа резьбовых непроходных калибров-пробок
	%%
	%% Входные параметры:
	%%     thread_tol - допуск контролируемой резьбы
	%%

	% Возможные предельные значения T_d2, T_D2
	tol_lims = [24 50 80 125 200 315 500 710 900]/1000;
	if (thread_tol < min(tol_lims)
	       || thread_tol > max(tol_lims))
		error("incorrect thread tolerance");
	end

	% Номер строки в таблице 5
	row_num = sum(thread_tol > tol_lims);

	T5 =[ 8  6  6 10 -4  0 10    8    7   6;
	     10  7  7 12 -2  2 12    9.5  9   7.5;
	     14  9  8 15  2  6 16   12.5 12   9.5;
	     18 11  9 18  8 12 21   17.5 15   11.5;
	     23 14 12 22 12 16 25.5 21   19.5 15;
	     30 18 15 27 20 24 33   27   25   19;
	     38 22 18 33 28 32 41   33   31   23;
	     48 28 22 40 38 42 50   40   38   28]/1000;
	gtol.T_R     = T5(row_num, 1);
	gtol.T_PL    = T5(row_num, 2);
	gtol.T_CP    = T5(row_num, 3);
	gtol.T_m     = T5(row_num, 4);
	gtol.Z_R     = T5(row_num, 5);
	gtol.Z_PL    = T5(row_num, 6);
	gtol.W_GO_R  = T5(row_num, 7);
	gtol.W_GO_PL = T5(row_num, 8);
	gtol.W_NG_R  = T5(row_num, 9);
	gtol.W_NG_PL = T5(row_num,10);
end
