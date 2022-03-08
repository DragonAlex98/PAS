# Performance Analysis and Simulation

BD and BIDE models for PAS exam @ University of Camerino.

## How to run
- Clone the Sibilla repository at https://github.com/quasylab/sibilla
- Navigate to the Sibilla folder and from the terminal run the following command:
```
cd sibilla
./gradlew build
./gradlew installDist
```
- Copy the content of this repository inside the **_shell\build\install\sshell\bin_** folder
- Navigate to the aforementioned folder and from the terminal run the **Sibilla Shell**:
```
sshell
```
- Launch the scenario of interest (e.g. BD vs BIDE)
```
> run "bd_vs_bide/bd.sib"
```

Once the simulation has ended and the results have been collected, the [Jupyter Notebook](analysis.ipynb) contains the code needed to actually analyse the data and extract the various graphs.

## VSCode Extension for Syntax Highlighting
VSCode Extension for Syntax Highlighting .pm and .sib files

<b>Installation</b>:
- Move <b>extension/sibilla</b> folder inside <b>VS_CODE_INSTALLATION_FOLDER/resources/app/extensions</b>
- Restart <b>VSCode</b>

<b>N.B.:</b> You have to repeat this procedure after each VSCode Update
