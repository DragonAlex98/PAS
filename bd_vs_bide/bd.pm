const warChance = 1/4;

param N = 3;
param scale = 10;

species P of [0, N];
species B of [0, N];
species D of [0, N];

label pop = { P[i for i in [0, N]] }
label birth = { B[i for i in [0, N]] }
label death = { D[i for i in [0, N]] }

rule make_war_1 for i in [0, N] and j in [0, N] {
    [!(i == j)] P[i]|P[j] -[ warChance * (#P[i] / #pop) * (#P[j] / #pop) ]-> P[i]|D[j]
}

rule make_war_2 for i in [0, N] and j in [0, N] {
    [!(i == j)] P[i]|P[j] -[ warChance * (#P[i] / #pop) * (#P[j] / #pop) ]-> D[i]|P[j]
}

rule make_war_3 for i in [0, N] and j in [0, N] {
    [!(i == j)] P[i]|P[j] -[ warChance * (#P[i] / #pop) * (#P[j] / #pop) ]-> D[i]|D[j]
}

rule make_war_4 for i in [0, N] and j in [0, N] {
    [!(i == j)] P[i]|P[j] -[ warChance * (#P[i] / #pop) * (#P[j] / #pop) ]-> P[i]|P[j]
}

rule reproduce for i in [0, N] {
    P[i]<2> -[ #P[i]/#pop ]-> P[i]<3>|B[i]
}

measure P_tot = #pop;
measure B_tot = #birth;
measure D_tot = #death;

measure BD = #birth - #death;

system balanced = P[i for i in [0, N]]<scale>;
system unbalanced = P[i for i in [0, N-1]]<scale>|P[N-1]<10*scale>;