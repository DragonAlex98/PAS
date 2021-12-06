const N = 3;            /* cities */
const warChance = 1/4;

species P of [0, N];    /* people */
species B of [0, N];    /* birth */
species I of [0, N];    /* immigration */
species D of [0, N];    /* death */
species E of [0, N];    /* emigration */

label pop = { P[i for i in [0, N]] }
/*const min_pop = %P[0] < %P[1] && %P[0] < %P[2] ? 0 : (%P[1] < %P[0] && %P[1] < %P[2] ? 1 : 2);*/

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

rule emigrate for i in [0, N] {
    P[i] -[ #P[i]/#pop ]-> E[i]|P[(#P[0] < #P[1]) ? 1 : 0]|I[(i+1)%N]
}

rule reproduce for i in [0, N] {
    P[i]<2> -[ #P[i]/#pop ]-> P[i]<3>|B[i]
}

param scale = 10;
system balanced = P[i for i in [0, N]]<scale>;
system unbalanced = P[i for i in [0, N-1]]<scale>|P[N-1]<10*scale>;