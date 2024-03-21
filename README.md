# K-Matrix Formalism in Hadron Physics

[![](https://indico.cern.ch/event/1397619/logo-3676420921.png)](https://indico.cern.ch/event/1397619)

## Overview

This repository contains educational materials focused on the application of the $K$-matrix formalism in the field of hadron physics. The materials are designed to bridge theoretical concepts with practical examples, facilitating a deeper understanding of scattering amplitude observables and resonance phenomena.

## Contents

- **Lecture Notes**: Comprehensive notes detailing the theoretical background, mathematical formulation, and physical significance of the K-matrix formalism.
- **Practical Examples Notebook**: An interactive Julia notebook that walks through several key examples illustrating the application of the $K$-matrix in different scenarios:
- **Exercise Solutions**: Solutions to the exercises provided in the practical examples notebook.
- **Supplementary Materials**: Additional resources and readings for further exploration of the $K$-matrix formalism and its applications in hadron physics.

## Installation Instructions

To get started with the materials in this repository, clone the repository using:

```shell
git clone https://github.com/mmikhasenko/international-k-matrix-day
```

This course utilizes [Pluto notebooks](https://plutojl.org/), which requires [Julia](https://julialang.org/). Below are the steps to set up your environment for running the provided materials.

### Installing Julia

1. **Download Julia**: Visit the [official Julia language website](https://julialang.org/downloads/) and download the appropriate installer for your operating system.
2. **Install Julia**: Run the installer and follow the on-screen instructions to install Julia on your system.

### Setting up Pluto.jl

After installing Julia, the next step is to set up Pluto.jl, which is the environment used for interactive notebooks in this course.

1. **Open Julia**: Launch the Julia application. You will be greeted with the Julia REPL, a command-line interface for Julia.
2. **Install Pluto.jl**: In the Julia REPL, install the Pluto.jl package by running the following command:
   ```julia
   using Pkg
   Pkg.add("Pluto")
   ```
3. **Launch Pluto**: After the installation is complete, start Pluto by running:
   ```julia
   using Pluto
   Pluto.run()
   ```

Pluto will now start, and your default web browser should open a new tab pointing to Pluto's start page. From here, you can create new notebooks or open existing ones.

## Contributing

We welcome contributions and suggestions to improve the educational materials. Please feel free to open an issue or submit a pull request with your enhancements.

## License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This educational material is provided under MIT licence, free to reuse and distribute.
