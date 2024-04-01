# K-Matrix Formalism in Hadron Physics

[![](https://indico.cern.ch/event/1397619/logo-3676420921.png)](https://indico.cern.ch/event/1397619)

## Overview

This repository contains educational materials focused on the application of the $K$-matrix formalism in the field of hadron physics. The materials are designed to bridge theoretical concepts with practical examples, facilitating a deeper understanding of scattering amplitude observables and resonance phenomena.

## Contents

- **Lecture Notes**: Comprehensive notes detailing the theoretical background, mathematical formulation, and physical significance of the K-matrix formalism.
- **Practical Examples Notebook**: An interactive Julia notebook that walks through several key examples illustrating the application of the $K$-matrix in different scenarios:
- **Exercise Solutions**: Solutions to the exercises provided in the practical examples notebook.
- **Supplementary Materials**: Additional resources and readings for further exploration of the $K$-matrix formalism and its applications in hadron physics.

The core of this repository are the following interactive notebooks:

- [Pluto notebook with interactive K-matrix widget](./docs/K-matrix.jl) (Julia)
- [Analyticity: Single-channel Riemann sheets](./docs/analyticity-1channel.ipynb) (Python)
- [Analyticity: Coupled channel Riemann sheets](./docs/analyticity-2channel.ipynb) (Python)

Supplementary materials, including lecture notes and presentations, can be found here:

1. **Modelling conventions**: [PDG review on resonances](https://pdg.lbl.gov/2023/reviews/rpp2023-rev-resonances.pdf)
2. **Second talk**: [Analytic continuation within K-matrix formalism](additional_materials/Analytic_continuation_ComPWA.pdf) (Lena Zeynep Pöpping)
3.

## Installation Instructions

To get started with the materials in this repository, clone the repository using:

```shell
git clone https://github.com/rub-ep1/international-k-matrix-day
```

This course utilizes [Pluto notebooks](https://plutojl.org/), which requires [Julia](https://julialang.org/), and [Jupyter notebooks](https://jupyter.org), which requires [Python](https://www.python.org/downloads). You can install and run Pluto and Jupyter yourself, but you can also use the provided [Pixi](https://pixi.sh) environment.

1. [Install Pixi](https://pixi.sh/latest/#installation)
2. Run one of the Pixi tasks:

   ```shell
   pixi run lab
   ```

   ```shell
   pixi run pluto
   ```

> [!WARNING]
> The first time you run `pixi run pluto`, it can take a few minutes before all Julia packages are downloaded and installed.

## References

- K-matrix report from COMPWA project (see [here](https://ampform.readthedocs.io/stable/usage/dynamics/k-matrix/), [more references](https://ampform.readthedocs.io/stable/references/))
- "A Primer on K-matrix Formalism" by Chung (download from [here](https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=88b101a5300736f78293cf10116c32e5d25e3c91))
- "The K-matrix formalism for overlapping resonances" by I.J.R. Aitchison, ([journal paper](https://www.sciencedirect.com/science/article/pii/0375947472903053))

## Contributing

We welcome contributions and suggestions to improve the educational materials. Please feel free to open an issue or submit a pull request with your enhancements.

## License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This educational material is provided under MIT licence, free to reuse and distribute.
