const N = 3;            /* cities */
const warChance = 1/4;

species P of [0, N];    /* people */
species B of [0, N];    /* birth */
species I of [0, N];    /* immigration */
species D of [0, N];    /* death */
species E of [0, N];    /* emigration */

label pop = { P[i for i in [0, N]] }

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

rule emigrate_to_next for i in [0, N] {
    P[i] -[ #P[i]/#pop ]-> E[i]|P[(i+1)%N]|I[(i+1)%N]
}

/*rule emigrate_to_biggest_1 for i in [0, N] {
    [(#P[i] < #P[(i+1)%N]) && (#P[i] < #P[(i+2)%N]) && (#P[(i+1)%N] < #P[(i+2)%N])] P[i] -[ #P[i]/#pop ]-> E[i]|P[(i+2)%N]|I[(i+2)%N]
}

rule emigrate_to_biggest_2 for i in [0, N] {
    [(#P[i] < #P[(i+1)%N]) && (#P[i] < #P[(i+2)%N]) && (#P[(i+1)%N] > #P[(i+2)%N])] P[i] -[ #P[i]/#pop ]-> E[i]|P[(i+1)%N]|I[(i+1)%N]
}*/

/*rule emigrate_to_smallest_1 for i in [0, N] {
    [(#P[i] > #P[(i+1)%N]) && (#P[i] > #P[(i+2)%N]) && (#P[(i+1)%N] > #P[(i+2)%N])] P[i] -[ #P[i]/#pop ]-> E[i]|P[(i+2)%N]|I[(i+2)%N]
}

rule emigrate_to_smallest_2 for i in [0, N] {
    [(#P[i] > #P[(i+1)%N]) && (#P[i] > #P[(i+2)%N]) && (#P[(i+1)%N] < #P[(i+2)%N])] P[i] -[ #P[i]/#pop ]-> E[i]|P[(i+1)%N]|I[(i+1)%N]
}*/

rule reproduce for i in [0, N] {
    P[i]<2> -[ #P[i]/#pop ]-> P[i]<3>|B[i]
}

/*rule disaster for i in [0, N] {
    [#P[i] > 100] P[i]<90> -[ 1.0 ]-> D[i]<90>
}*/

measure pop_tot = #pop;

param scale = 10;
system balanced = P[i for i in [0, N]]<scale>;
system unbalanced = P[i for i in [0, N-1]]<scale>|P[N-1]<10*scale>;