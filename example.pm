const C = 1.0;

species A of [0, N];
species B;

label lab = { A[i for i in [0, N]] }

rule a_to_b {
    A|B -[ 1.0*%A ]-> B|B
}

param text = "this-is-a-text";
param char = 'c';

param num = 1;
param float = 1.0f;

param bool = true;

system init = A<10>|B;