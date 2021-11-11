/* Risultati CSV */
/* time unit;media;varianza;dev std */
const N = 3;            /* Initial number of cities */

species P of [0, N];    /* people */

param scale = 10;
system balanced = P[i for i in [0, N]]<scale>;
system unbalanced = P[i for i in [0, N-1]]<scale>|P[N-1]<3*scale>;

/*param nprod = 5;

system balanced = U[0]<2*nprod>|P[5]<nprod>;
system unbalanced = U[0]<4*nprod>|P[5]<nprod>;
system cs = U[0]<3*nprod>|P[5]<nprod>;*/