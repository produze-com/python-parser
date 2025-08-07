defmodule PythonParser do
  @moduledoc """
  Documentation for `PythonParser`.
  """

  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :python_parser,
    crate: "pythonparser",
    base_url: "https://github.com/produze-com/python-parser/releases/download/v#{version}",
    force_build: System.get_env("RUSTLER_PRECOMPILED_FORCE_BUILD") in ["1", "true"],
    version: version,
    targets: [
      "aarch64-apple-darwin",
      "x86_64-unknown-linux-gnu"
    ]

  defmodule AstNode do
    @moduledoc """
    Represents a node in the Python AST.
    """
    defstruct [:kind, :text, :children]

    @type t :: %__MODULE__{
            kind: String.t(),
            text: String.t(),
            children: [t()]
          }
  end

  @doc """
  Parse Python source code and return an AST.

  ## Examples

      iex> {:ok, ast} = PythonParser.parse("x = 1")
      iex> ast.kind
      "module"

  """
  def parse(_source), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Hello world.

  ## Examples

      iex> PythonParser.hello()
      :world

  """
  def hello do
    :world
  end
end
