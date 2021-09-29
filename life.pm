/* Risultati CSV */
/* time unit;media;varianza;dev std */
/* prima set param poi init */

/* alberi che producono cibo e crescono */
/* persone che tagliano alberi per creare assi per costruire case */
/* persone che mangiano per riprodursi (solo se ci sono abbastanza case) */

const trees = 20;       /* Initial number of food */
const lumberjacks = 5;  /* Initial number of lumberjacks */
const farmers = 3;      /* Initial number of farmers */

const produceSeedRate = 0.25;
const produceFoodRate = 0.25;
const lumberjackWithoutFoodDeathRate = 0.2;
const farmerWithoutFoodDeathRate = 0.1;

species T;              /* tree */
species W;              /* wood */
species H;              /* house */
species F;              /* food */
species S;              /* seed */
species B;              /* baby */
species C;              /* contadino */
species L;              /* lumberjack */
species D;              /* dead */

rule produce_seed {
    T -[ produceSeedRate ]-> T|S<4>
}

rule produce_food {
    T -[ produceFoodRate ]-> T|F<4>
}

rule die_lumberjack {
    [#F == 0] L -[ lumberjackWithoutFoodDeathRate ]-> D
}

rule eat_lumberjack {
    L|F -[ 0.1 ]-> L
}

rule eat_farmer {
    C|F -[ 0.1 ]-> C
}

rule die_farmers {
    [#F == 0] C -[ farmerWithoutFoodDeathRate ]-> D
}

rule cut_tree {
    L|T -[ 1.0 ]-> L|W<2>
}

rule build_house {
    L|W<4> -[ 1.0 ]-> L|H
}

rule plant_tree {
    C|S -[ 1.0 ]-> C|T
}

rule new_person {
    L|L|F|H -[ 1.0 ]-> L|L|B
}

rule new_person_2 {
    C|C|F|H -[ 1.0 ]-> C|C|B
}

rule grow_to_farmer {
    B -[ 0.5 ]-> C
}

rule grow_to_lumberjack {
    B -[ 0.5 ]-> L
}

system init = T<trees>|L<lumberjacks>|C<farmers>;

/*param nprod = 5;

system balanced = U[0]<2*nprod>|P[5]<nprod>;
system unbalanced = U[0]<4*nprod>|P[5]<nprod>;
system cs = U[0]<3*nprod>|P[5]<nprod>;*/