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
const produceAppleRate = 0.25;
const lumberjackDeathRate = 0.1;
const farmerDeathRate = 0.1;

species T;              /* tree */
species W;              /* wood */
species H;              /* house */
species A;              /* apple */
species S;              /* seed */
species BL;             /* baby lumberjack */
species BF;             /* baby farmer */
species F;              /* farmer */
species L;              /* lumberjack */
species D;              /* dead */
species CT;             /* cut trees */

rule produce_seed {
    T -[ produceSeedRate ]-> T|S<2>
}

rule produce_apple {
    T -[ produceAppleRate ]-> T|A<2>
}

rule die_tree {
    [#T > #F] T -[ 1.0 ]-> CT
}

rule die_lumberjack {
    [#A < (#L + #F)] L -[ lumberjackDeathRate ]-> D
}

rule die_farmers {
    [#A < (#L + #F)] F -[ farmerDeathRate ]-> D
}

rule eat_lumberjack {
    L|A -[ #L * %A ]-> L
}

rule eat_farmer {
    F|A -[ #F * %A ]-> F
}

rule cut_tree {
    L|T -[ #L * %T ]-> L|W<2>|CT
}

rule build_house {
    L|W<4> -[ 1.0 ]-> L|H
}

rule plant_tree {
    F|S -[ #F * %S ]-> F|T
}

rule new_lumberjack {
    L<2>|A|H -[ #L * %A ]-> L<2>|BL
}

rule new_farmer {
    F<2>|A|H -[ #F * %A ]-> F<2>|BF
}

rule grow_to_farmer {
    BF -[ 0.5 ]-> F
}

rule grow_to_lumberjack {
    BL -[ 0.5 ]-> L
}

system init = T<trees>|L<lumberjacks>|F<farmers>;

/*param nprod = 5;

system balanced = U[0]<2*nprod>|P[5]<nprod>;
system unbalanced = U[0]<4*nprod>|P[5]<nprod>;
system cs = U[0]<3*nprod>|P[5]<nprod>;*/