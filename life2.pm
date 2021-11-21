/* Risultati CSV */
/* time unit;media;varianza;dev std */
const N = 3;            /* Initial number of cities */
const warChance = 1/3;

species P of [0, N];    /* people */
species B of [0, N];    /* birth */
species I of [0, N];    /* immigration */
species D of [0, N];    /* death */
species E of [0, N];    /* emigration */

/* TODO: %P is not correct, I need the the %P with respect to P[], not all */
rule make_war_1 for i in [0,N] and j in [0,N] {
    [!(i == j)] P[i]|P[j] -[ warChance * %P[i] * %P[j] ]-> P[i]|D[j]
}

rule make_war_2 for i in [0,N] and j in [0,N] {
    [!(i == j)] P[i]|P[j] -[ warChance * %P[i] * %P[j] ]-> D[i]|P[j]
}

rule make_war_3 for i in [0,N] and j in [0,N] {
    [!(i == j)] P[i]|P[j] -[ warChance * %P[i] * %P[j] ]-> D[i]|D[j]
}

rule emigrate for i in [0,N] {
    P[i] -[ %P[i] ]-> E[i]|P[(i+1)%N]|I[(i+1)%N]
}

rule reproduce for i in [0,N] {
    P[i]|P[i] -[ %P[i] ]-> P[i]|P[i]|B[i]
}

param scale = 10;
system balanced = P[i for i in [0, N]]<scale>;
system unbalanced = P[i for i in [0, N-1]]<scale>|P[N-1]<3*scale>;

/*param nprod = 5;

system balanced = U[0]<2*nprod>|P[5]<nprod>;
system unbalanced = U[0]<4*nprod>|P[5]<nprod>;
system cs = U[0]<3*nprod>|P[5]<nprod>;*/