# varintjo
varintjo is a Mojo project that deals with variable bitwidth integers using Mojo (only `U24` is available). This README provides an overview of the project.

# Introduction
Variable bitwidth integers, here referred to as "varints," are a compact and efficient way to represent integers with varying byte lengths (e.g. unsigned integer 7, a.k.a. `u7` or `uint7` or `uint7_t` etc., which is an integer represented by exactly 7 bits, with its largest representable value equals to `2 ** 7 - 1`). This project, `varintjo`, leverages Mojo enable developers to write types that are represented precisely by a certain definite number of bits.

This is only possible because Mojo exposes an interface to the `Multi-level Intermediate Representation`, a.k.a. MLIR, which is a slightly higher intermediate representation than that of LLVM.

Not many languages allow for variable bitwidth integers, not even Rust provides this.

Look at [references](#references) for more details.

# Getting Started
Before you can run tests for the `varintjo` project, you need to set up your environment by installing Mojo.

# Prerequisites
To use `varintjo`, you need to have Mojo installed on your system. If you haven't installed Mojo yet, please follow the installation instructions below.

# Installing Mojo
You can install Mojo by following the official Mojo documentation: [Mojo Installation Guide](https://docs.modular.com/mojo/manual/get-started/)

# Running Tests
To run the tests for `varintjo`, follow these steps:

Make sure you are in the directory where `mojo.toml` is located, which is typically the root of your `varintjo` project.

Open your terminal or command prompt and navigate to the project directory.

Run the following command to execute the tests:

``` bash
bash scripts/tests.sh
```
This script is designed to run all the tests for the `varintjo` project.

# References

[1] https://blog.llvm.org/2020/04/the-new-clang-extint-feature-provides.html

[2] https://alic.dev/blog/custom-bitwidth

[3] https://www.morganclaypool.com/doi/pdf/10.2200/S00346ED1V01Y201104CAC016

[4] https://tratt.net/laurie/blog/2021/static_integer_types.html

p.s. Highly recommend to write Ref[4].

# License
This project is licensed under the MIT License. Feel free to use, modify, and distribute it as needed. We welcome contributions and collaboration from the open-source community.