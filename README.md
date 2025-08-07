# PythonParser

A Python parser and code analysis library for Elixir, built with Rustler and Tree-sitter. This library allows you to parse Python source code into an Abstract Syntax Tree (AST).

## Features

- **Parse Python Code**: Convert Python source code into a structured AST

## Installation

This package is not yet published to Hex. You can install it directly from the repository.

## Usage

### Parsing Python Code

Use `PythonParser.parse/1` to convert Python source code into an AST:

```elixir
code = """
x = 1
y = x + 2
print("Hello, world!")
"""

{:ok, ast} = PythonParser.parse(code)
# Returns %PythonParser.AstNode{kind: "module", text: "...", children: [...]}
```
