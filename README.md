# PythonParser

A Python parser and code analysis library for Elixir, built with Rustler and Tree-sitter. This library allows you to parse Python source code into an Abstract Syntax Tree (AST).

## Features

- **Parse Python Code**: Convert Python source code into a structured AST
- **Error-Resilient Parsing**: Gracefully handles incomplete and malformed Python code
- **Incremental Parsing**: Perfect for real-time code analysis, IDEs, and code completion
- **Detailed AST Nodes**: Each node contains kind, text, and children information

## Installation

This package is not yet published to Hex. You can install it directly from the repository.

## Usage

### Parsing Python Code

Use `PythonParser.parse/1` to convert Python source code into an AST:

````elixir
code = """
x = 1
y = x + 2
print("Hello, world!")
"""

```elixir
code = """
x = 1
y = x + 2
print("Hello, world!")
"""

{:ok, ast} = PythonParser.parse(code)
# Returns %PythonParser.AstNode{kind: "module", text: "...", children: [...]}
````

### Handling Incomplete/Partial Code

The parser gracefully handles incomplete Python code by creating `ERROR` nodes in the AST while preserving as much structural information as possible.

## AST Structure

Each AST node is represented as a `%PythonParser.AstNode{}` struct with three fields:

- `kind`: The type of syntax element (e.g., "module", "function_definition", "string", "ERROR" etc.)
- `text`: The raw source code text for this node
- `children`: A list of child AST nodes

ERROR nodes are created when the parser encounters incomplete or invalid syntax, but still contain any successfully parsed child tokens.
