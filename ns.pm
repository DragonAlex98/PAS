/* Risultati CSV */
/* time unit;media;varianza;dev std */

const agents = 10;          /* Initial number of S agents */
const food = 100;           /* Initial number of food */

species F of [0, food];
species S of [0, agents];
species D;

rule dead for i in [0, agents] {
    [#F[0] == 0] S[i] -[ 1 ]-> D
}

rule foodAlone {
    S[0]|F[0] -[ 1.0 ]-> S[1]|S[1]|F[1]
}

/*rule foodWithOther for i in [0, agents] and j in [0, agents] and f in [0, food] {
    S[i]|S[j]|F[f] -[ 1.0 ]-> S[1]|S[1]|R
}*/

rule regenerateFood {
    [(#F[0] == 0) && (#S[0] == 0)] F[1]<food> -[ 1.0 ]-> F[0]<food>
}

rule regeneratePeople {
    [#S[0] == 0] S[1] -[ 1.0 ]-> S[0]<agents>
}

measure n_s0 = #S[0];
measure n_s1 = #S[1];
measure n_f0 = #F[0];
measure n_f1 = #F[1];

system init = S[0]<agents>|F[0]<food>;

/*param nprod = 5;

system balanced = U[0]<2*nprod>|P[5]<nprod>;
system unbalanced = U[0]<4*nprod>|P[5]<nprod>;
system cs = U[0]<3*nprod>|P[5]<nprod>;*/