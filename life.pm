/* Risultati CSV */
/* time unit;media;varianza;dev std */
/* prima set param poi init */

/* alberi che producono cibo e crescono */
/* persone che tagliano alberi per creare assi per costruire case */
/* persone che mangiano per riprodursi (solo se ci sono abbastanza case) */

const trees = 100;       /* Initial number of trees */
const lumberjacks = 25;  /* Initial number of lumberjacks */
const farmers = 25;      /* Initial number of farmers */

const produceSeedRate = 0.25;
const produceFoodRate = 0.25;
const lumberjackWithoutFoodDeathRate = 0.1;
const farmerWithoutFoodDeathRate = 0.1;

species T;              /* tree */
species W;              /* wood */
species H;              /* house */
species F;              /* food */
species S;              /* seed */
species BL;             /* baby lumberjack */
species BC;             /* baby contadino */
species C;              /* contadino */
species L;              /* lumberjack */
species D;              /* dead */
species CT;             /* cut trees */

rule produce_seed {
    T -[ produceSeedRate ]-> T|S<2>
}

rule produce_food {
    T -[ produceFoodRate ]-> T|F<2>
}

rule die_tree {
    [#T > #C] T -[ 1.0 ]-> CT
}

rule die_lumberjack {
    [#F < (#L + #C)] L -[ lumberjackWithoutFoodDeathRate ]-> D
}

rule eat_lumberjack {
    L|F -[ #L * %F ]-> L
}

rule eat_farmer {
    C|F -[ #C * %F ]-> C
}

rule die_farmers {
    [#F < (#L + #C)] C -[ farmerWithoutFoodDeathRate ]-> D
}

rule cut_tree {
    L|T -[ #L * %T ]-> L|W<2>|CT
}

rule build_house {
    L|W<4> -[ 1.0 ]-> L|H
}

rule plant_tree {
    C|S -[ #C * %S ]-> C|T
}

rule new_lumberjack {
    L<2>|F|H -[ #L * %F ]-> L<2>|BL
}

rule new_farmer {
    C<2>|F|H -[ #C * %F ]-> C<2>|BC
}

rule grow_to_farmer {
    BC -[ 0.5 ]-> C
}

rule grow_to_lumberjack {
    BL -[ 0.5 ]-> L
}

system init = T<trees>|L<lumberjacks>|C<farmers>;

/*param nprod = 5;

system balanced = U[0]<2*nprod>|P[5]<nprod>;
system unbalanced = U[0]<4*nprod>|P[5]<nprod>;
system cs = U[0]<3*nprod>|P[5]<nprod>;*/