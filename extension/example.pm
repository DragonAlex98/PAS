const c = 1.0;

species A of [0, N];
species B;

label lab = { A[i for i in [0, N]] }

rule a_to_b {
    A|B -[ 1.0*%A ]-> B|B
}

/* inline comment */

param text = "this-is-a-text";
param char = 'c';

param num = 1;
param float = 1.0f;

param bool = true;

/* multiline
comment */

measure m for i in [0, N] = #A[i];

system init = A<10>|B;