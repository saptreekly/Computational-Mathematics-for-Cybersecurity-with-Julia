# Computational Mathematics for Cybersecurity via Julia

This repo documents my self-directed exploration of the mathematics and logic behind modern cybersecurity and cryptography, implemented entirely in Julia.

## Motivation

Cybersecurity is fundamentally a mathematical science. Number theory, abstract algebra, statistics and probability, and information theory underpin everything from RSA to elliptic curve cryptography to side-channel attacks. I believe that the industry often takes the mathematics for granted.

This repo is my attempt to go in the other direction, understanding the mathematics first and build tools from the ground up. Everything here is implemented in the [Julia Programming Language](https://julialang.org/). Almost all cybersecurity work gets defaulted to Python, but Julia's expressiveness, native arbitrary precision arithmetic, and performance really do make it a compelling alternative that deserves more attention in this space. Building out that ecosystem is part of the project.

The Julia language is incredible and I think many people don't know what they're missing by sticking to Python. If you need proof, I suggest starting [here](https://www.youtube.com/watch?v=JYs_94znYy0).

## Structure

I'm organizing the project into specific topics. Each topic has a Jupyter notebook (running the Julia kernel via [IJulia](https://github.com/JuliaLang/IJulia.jl)) walking through the theory, implementation, and cryptographic application.

If you're new to Julia in Jupyter, you can also use [Pluto.jl](https://plutojl.org/) which is a Julia-native reactive notebook environment I highly recommend exploring.

---

# DISCLAIMER

Everything built in this repo is built for mathematical understanding, not production use. They are intentionally minimal.

Please don't use anything here to secure real systems.