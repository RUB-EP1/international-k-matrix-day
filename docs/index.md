---
myst:
  all_links_external: true
---

:::{title} Welcome
:::

# K-Matrix Formalism in Hadron Physics

[![](https://indico.cern.ch/event/1397619/logo-3676420921.png)](https://indico.cern.ch/event/1397619)

This repository contains educational materials focused on the application of the $K$-matrix formalism in the field of hadron physics. The materials are designed to bridge theoretical concepts with practical examples, facilitating a deeper understanding of scattering amplitude observables and resonance phenomena.

## Contents


- [Pluto notebook with interactive K-matrix widget](./_static/K-matrix.html) (Julia)
- {doc}`Analyticity: Single-channel Riemann sheets <analyticity-1channel>` (Python)
- {doc}`Analyticity: Coupled channel Riemann sheets <analyticity-2channel>` (Python)

:::{toctree}
:hidden:
:maxdepth: 1
K matrix with Julia <https://mmikhasenko.github.io/international-k-matrix-day/_static/K-matrix.html>
analyticity-1channel
analyticity-2channel
:::

## Installation Instructions

To run the materials in this repository locally, clone the repository using:

```shell
git clone https://github.com/mmikhasenko/international-k-matrix-day
```

This course utilizes [Pluto notebooks](https://plutojl.org/), which requires [Julia](https://julialang.org/), and [Jupyter notebooks](https://jupyter.org), which requires [Python](https://www.python.org/downloads). You can install and run Pluto and Jupyter yourself, but you can also use the provided [Pixi](https://pixi.sh) environment.

1. [Install Pixi](https://pixi.sh/latest/#installation):

   ::::{tab-set}
   :::{tab-item} Linux / macOS

   ```shell
   curl -fsSL https://pixi.sh/install.sh | bash
   ```

   :::
   :::{tab-item} Powershell

   ```shell
   iwr -useb https://pixi.sh/install.ps1 | iex
   ```

   :::
   :::{tab-item} Winget

   ```shell
   winget install prefix-dev.pixi
   ```

   :::
   ::::

2. Run one of the Pixi tasks:

   ```shell
   pixi run lab
   ```

   ```shell
   pixi run pluto
   ```

   :::{warning}
   The first time you run `pixi run pluto`, it can take a few minutes before all Julia packages are downloaded and installed.
   :::
