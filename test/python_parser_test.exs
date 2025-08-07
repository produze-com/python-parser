defmodule PythonParserTest do
  use ExUnit.Case
  alias PythonParser

  test "greets the world" do
    assert PythonParser.hello() == :world
  end

  test "parses python code" do
    code = """
    from datetime import datetime, timedelta
    import pytz
    # Set timezone
    tz = pytz.timezone("America/Los_Angeles")
    now = datetime.now(tz)
    foo(123, "hello", [1, 2, 3])
    bar(x=42, y={"a": 1, "b": 2})
    baz("nested", {"list": [10, 20, {"deep": "value"}]})
    process_data("dataset1", {"normalize": True, "scale": 0.75})
    log("Run completed", None)
    """

    {:ok, ast} = PythonParser.parse(code)

    assert %PythonParser.AstNode{
             kind: "module",
             text:
               "from datetime import datetime, timedelta\nimport pytz\n# Set timezone\ntz = pytz.timezone(\"America/Los_Angeles\")\nnow = datetime.now(tz)\nfoo(123, \"hello\", [1, 2, 3])\nbar(x=42, y={\"a\": 1, \"b\": 2})\nbaz(\"nested\", {\"list\": [10, 20, {\"deep\": \"value\"}]})\nprocess_data(\"dataset1\", {\"normalize\": True, \"scale\": 0.75})\nlog(\"Run completed\", None)\n",
             children: [
               %PythonParser.AstNode{
                 kind: "import_from_statement",
                 text: "from datetime import datetime, timedelta",
                 children: [
                   %PythonParser.AstNode{kind: "from", text: "from", children: []},
                   %PythonParser.AstNode{
                     kind: "dotted_name",
                     text: "datetime",
                     children: [
                       %PythonParser.AstNode{
                         kind: "identifier",
                         text: "datetime",
                         children: []
                       }
                     ]
                   },
                   %PythonParser.AstNode{kind: "import", text: "import", children: []},
                   %PythonParser.AstNode{
                     kind: "dotted_name",
                     text: "datetime",
                     children: [
                       %PythonParser.AstNode{
                         kind: "identifier",
                         text: "datetime",
                         children: []
                       }
                     ]
                   },
                   %PythonParser.AstNode{kind: ",", text: ",", children: []},
                   %PythonParser.AstNode{
                     kind: "dotted_name",
                     text: "timedelta",
                     children: [
                       %PythonParser.AstNode{
                         kind: "identifier",
                         text: "timedelta",
                         children: []
                       }
                     ]
                   }
                 ]
               },
               %PythonParser.AstNode{
                 kind: "import_statement",
                 text: "import pytz",
                 children: [
                   %PythonParser.AstNode{kind: "import", text: "import", children: []},
                   %PythonParser.AstNode{
                     kind: "dotted_name",
                     text: "pytz",
                     children: [
                       %PythonParser.AstNode{
                         kind: "identifier",
                         text: "pytz",
                         children: []
                       }
                     ]
                   }
                 ]
               },
               %PythonParser.AstNode{kind: "comment", text: "# Set timezone", children: []},
               %PythonParser.AstNode{
                 kind: "expression_statement",
                 text: "tz = pytz.timezone(\"America/Los_Angeles\")",
                 children: [
                   %PythonParser.AstNode{
                     kind: "assignment",
                     text: "tz = pytz.timezone(\"America/Los_Angeles\")",
                     children: [
                       %PythonParser.AstNode{kind: "identifier", text: "tz", children: []},
                       %PythonParser.AstNode{kind: "=", text: "=", children: []},
                       %PythonParser.AstNode{
                         kind: "call",
                         text: "pytz.timezone(\"America/Los_Angeles\")",
                         children: [
                           %PythonParser.AstNode{
                             kind: "attribute",
                             text: "pytz.timezone",
                             children: [
                               %PythonParser.AstNode{
                                 kind: "identifier",
                                 text: "pytz",
                                 children: []
                               },
                               %PythonParser.AstNode{kind: ".", text: ".", children: []},
                               %PythonParser.AstNode{
                                 kind: "identifier",
                                 text: "timezone",
                                 children: []
                               }
                             ]
                           },
                           %PythonParser.AstNode{
                             kind: "argument_list",
                             text: "(\"America/Los_Angeles\")",
                             children: [
                               %PythonParser.AstNode{kind: "(", text: "(", children: []},
                               %PythonParser.AstNode{
                                 kind: "string",
                                 text: "\"America/Los_Angeles\"",
                                 children: [
                                   %PythonParser.AstNode{
                                     kind: "string_start",
                                     text: "\"",
                                     children: []
                                   },
                                   %PythonParser.AstNode{
                                     kind: "string_content",
                                     text: "America/Los_Angeles",
                                     children: []
                                   },
                                   %PythonParser.AstNode{
                                     kind: "string_end",
                                     text: "\"",
                                     children: []
                                   }
                                 ]
                               },
                               %PythonParser.AstNode{kind: ")", text: ")", children: []}
                             ]
                           }
                         ]
                       }
                     ]
                   }
                 ]
               },
               %PythonParser.AstNode{
                 kind: "expression_statement",
                 text: "now = datetime.now(tz)",
                 children: [
                   %PythonParser.AstNode{
                     kind: "assignment",
                     text: "now = datetime.now(tz)",
                     children: [
                       %PythonParser.AstNode{kind: "identifier", text: "now", children: []},
                       %PythonParser.AstNode{kind: "=", text: "=", children: []},
                       %PythonParser.AstNode{
                         kind: "call",
                         text: "datetime.now(tz)",
                         children: [
                           %PythonParser.AstNode{
                             kind: "attribute",
                             text: "datetime.now",
                             children: [
                               %PythonParser.AstNode{
                                 kind: "identifier",
                                 text: "datetime",
                                 children: []
                               },
                               %PythonParser.AstNode{kind: ".", text: ".", children: []},
                               %PythonParser.AstNode{
                                 kind: "identifier",
                                 text: "now",
                                 children: []
                               }
                             ]
                           },
                           %PythonParser.AstNode{
                             kind: "argument_list",
                             text: "(tz)",
                             children: [
                               %PythonParser.AstNode{kind: "(", text: "(", children: []},
                               %PythonParser.AstNode{
                                 kind: "identifier",
                                 text: "tz",
                                 children: []
                               },
                               %PythonParser.AstNode{kind: ")", text: ")", children: []}
                             ]
                           }
                         ]
                       }
                     ]
                   }
                 ]
               },
               %PythonParser.AstNode{
                 kind: "expression_statement",
                 text: "foo(123, \"hello\", [1, 2, 3])",
                 children: [
                   %PythonParser.AstNode{
                     kind: "call",
                     text: "foo(123, \"hello\", [1, 2, 3])",
                     children: [
                       %PythonParser.AstNode{kind: "identifier", text: "foo", children: []},
                       %PythonParser.AstNode{
                         kind: "argument_list",
                         text: "(123, \"hello\", [1, 2, 3])",
                         children: [
                           %PythonParser.AstNode{kind: "(", text: "(", children: []},
                           %PythonParser.AstNode{
                             kind: "integer",
                             text: "123",
                             children: []
                           },
                           %PythonParser.AstNode{kind: ",", text: ",", children: []},
                           %PythonParser.AstNode{
                             kind: "string",
                             text: "\"hello\"",
                             children: [
                               %PythonParser.AstNode{
                                 kind: "string_start",
                                 text: "\"",
                                 children: []
                               },
                               %PythonParser.AstNode{
                                 kind: "string_content",
                                 text: "hello",
                                 children: []
                               },
                               %PythonParser.AstNode{
                                 kind: "string_end",
                                 text: "\"",
                                 children: []
                               }
                             ]
                           },
                           %PythonParser.AstNode{kind: ",", text: ",", children: []},
                           %PythonParser.AstNode{
                             kind: "list",
                             text: "[1, 2, 3]",
                             children: [
                               %PythonParser.AstNode{kind: "[", text: "[", children: []},
                               %PythonParser.AstNode{
                                 kind: "integer",
                                 text: "1",
                                 children: []
                               },
                               %PythonParser.AstNode{kind: ",", text: ",", children: []},
                               %PythonParser.AstNode{
                                 kind: "integer",
                                 text: "2",
                                 children: []
                               },
                               %PythonParser.AstNode{kind: ",", text: ",", children: []},
                               %PythonParser.AstNode{
                                 kind: "integer",
                                 text: "3",
                                 children: []
                               },
                               %PythonParser.AstNode{kind: "]", text: "]", children: []}
                             ]
                           },
                           %PythonParser.AstNode{kind: ")", text: ")", children: []}
                         ]
                       }
                     ]
                   }
                 ]
               },
               %PythonParser.AstNode{
                 kind: "expression_statement",
                 text: "bar(x=42, y={\"a\": 1, \"b\": 2})",
                 children: [
                   %PythonParser.AstNode{
                     kind: "call",
                     text: "bar(x=42, y={\"a\": 1, \"b\": 2})",
                     children: [
                       %PythonParser.AstNode{kind: "identifier", text: "bar", children: []},
                       %PythonParser.AstNode{
                         kind: "argument_list",
                         text: "(x=42, y={\"a\": 1, \"b\": 2})",
                         children: [
                           %PythonParser.AstNode{kind: "(", text: "(", children: []},
                           %PythonParser.AstNode{
                             kind: "keyword_argument",
                             text: "x=42",
                             children: [
                               %PythonParser.AstNode{
                                 kind: "identifier",
                                 text: "x",
                                 children: []
                               },
                               %PythonParser.AstNode{kind: "=", text: "=", children: []},
                               %PythonParser.AstNode{
                                 kind: "integer",
                                 text: "42",
                                 children: []
                               }
                             ]
                           },
                           %PythonParser.AstNode{kind: ",", text: ",", children: []},
                           %PythonParser.AstNode{
                             kind: "keyword_argument",
                             text: "y={\"a\": 1, \"b\": 2}",
                             children: [
                               %PythonParser.AstNode{
                                 kind: "identifier",
                                 text: "y",
                                 children: []
                               },
                               %PythonParser.AstNode{kind: "=", text: "=", children: []},
                               %PythonParser.AstNode{
                                 kind: "dictionary",
                                 text: "{\"a\": 1, \"b\": 2}",
                                 children: [
                                   %PythonParser.AstNode{
                                     kind: "{",
                                     text: "{",
                                     children: []
                                   },
                                   %PythonParser.AstNode{
                                     kind: "pair",
                                     text: "\"a\": 1",
                                     children: [
                                       %PythonParser.AstNode{
                                         kind: "string",
                                         text: "\"a\"",
                                         children: [
                                           %PythonParser.AstNode{
                                             kind: "string_start",
                                             text: "\"",
                                             children: []
                                           },
                                           %PythonParser.AstNode{
                                             kind: "string_content",
                                             text: "a",
                                             children: []
                                           },
                                           %PythonParser.AstNode{
                                             kind: "string_end",
                                             text: "\"",
                                             children: []
                                           }
                                         ]
                                       },
                                       %PythonParser.AstNode{
                                         kind: ":",
                                         text: ":",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: "integer",
                                         text: "1",
                                         children: []
                                       }
                                     ]
                                   },
                                   %PythonParser.AstNode{
                                     kind: ",",
                                     text: ",",
                                     children: []
                                   },
                                   %PythonParser.AstNode{
                                     kind: "pair",
                                     text: "\"b\": 2",
                                     children: [
                                       %PythonParser.AstNode{
                                         kind: "string",
                                         text: "\"b\"",
                                         children: [
                                           %PythonParser.AstNode{
                                             kind: "string_start",
                                             text: "\"",
                                             children: []
                                           },
                                           %PythonParser.AstNode{
                                             kind: "string_content",
                                             text: "b",
                                             children: []
                                           },
                                           %PythonParser.AstNode{
                                             kind: "string_end",
                                             text: "\"",
                                             children: []
                                           }
                                         ]
                                       },
                                       %PythonParser.AstNode{
                                         kind: ":",
                                         text: ":",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: "integer",
                                         text: "2",
                                         children: []
                                       }
                                     ]
                                   },
                                   %PythonParser.AstNode{
                                     kind: "}",
                                     text: "}",
                                     children: []
                                   }
                                 ]
                               }
                             ]
                           },
                           %PythonParser.AstNode{kind: ")", text: ")", children: []}
                         ]
                       }
                     ]
                   }
                 ]
               },
               %PythonParser.AstNode{
                 kind: "expression_statement",
                 text: "baz(\"nested\", {\"list\": [10, 20, {\"deep\": \"value\"}]})",
                 children: [
                   %PythonParser.AstNode{
                     kind: "call",
                     text: "baz(\"nested\", {\"list\": [10, 20, {\"deep\": \"value\"}]})",
                     children: [
                       %PythonParser.AstNode{kind: "identifier", text: "baz", children: []},
                       %PythonParser.AstNode{
                         kind: "argument_list",
                         text: "(\"nested\", {\"list\": [10, 20, {\"deep\": \"value\"}]})",
                         children: [
                           %PythonParser.AstNode{kind: "(", text: "(", children: []},
                           %PythonParser.AstNode{
                             kind: "string",
                             text: "\"nested\"",
                             children: [
                               %PythonParser.AstNode{
                                 kind: "string_start",
                                 text: "\"",
                                 children: []
                               },
                               %PythonParser.AstNode{
                                 kind: "string_content",
                                 text: "nested",
                                 children: []
                               },
                               %PythonParser.AstNode{
                                 kind: "string_end",
                                 text: "\"",
                                 children: []
                               }
                             ]
                           },
                           %PythonParser.AstNode{kind: ",", text: ",", children: []},
                           %PythonParser.AstNode{
                             kind: "dictionary",
                             text: "{\"list\": [10, 20, {\"deep\": \"value\"}]}",
                             children: [
                               %PythonParser.AstNode{kind: "{", text: "{", children: []},
                               %PythonParser.AstNode{
                                 kind: "pair",
                                 text: "\"list\": [10, 20, {\"deep\": \"value\"}]",
                                 children: [
                                   %PythonParser.AstNode{
                                     kind: "string",
                                     text: "\"list\"",
                                     children: [
                                       %PythonParser.AstNode{
                                         kind: "string_start",
                                         text: "\"",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: "string_content",
                                         text: "list",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: "string_end",
                                         text: "\"",
                                         children: []
                                       }
                                     ]
                                   },
                                   %PythonParser.AstNode{
                                     kind: ":",
                                     text: ":",
                                     children: []
                                   },
                                   %PythonParser.AstNode{
                                     kind: "list",
                                     text: "[10, 20, {\"deep\": \"value\"}]",
                                     children: [
                                       %PythonParser.AstNode{
                                         kind: "[",
                                         text: "[",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: "integer",
                                         text: "10",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: ",",
                                         text: ",",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: "integer",
                                         text: "20",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: ",",
                                         text: ",",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: "dictionary",
                                         text: "{\"deep\": \"value\"}",
                                         children: [
                                           %PythonParser.AstNode{
                                             kind: "{",
                                             text: "{",
                                             children: []
                                           },
                                           %PythonParser.AstNode{
                                             kind: "pair",
                                             text: "\"deep\": \"value\"",
                                             children: [
                                               %PythonParser.AstNode{
                                                 kind: "string",
                                                 text: "\"deep\"",
                                                 children: [
                                                   %PythonParser.AstNode{
                                                     kind: "string_start",
                                                     text: "\"",
                                                     children: []
                                                   },
                                                   %PythonParser.AstNode{
                                                     kind: "string_content",
                                                     text: "deep",
                                                     children: []
                                                   },
                                                   %PythonParser.AstNode{
                                                     kind: "string_end",
                                                     text: "\"",
                                                     children: []
                                                   }
                                                 ]
                                               },
                                               %PythonParser.AstNode{
                                                 kind: ":",
                                                 text: ":",
                                                 children: []
                                               },
                                               %PythonParser.AstNode{
                                                 kind: "string",
                                                 text: "\"value\"",
                                                 children: [
                                                   %PythonParser.AstNode{
                                                     kind: "string_start",
                                                     text: "\"",
                                                     children: []
                                                   },
                                                   %PythonParser.AstNode{
                                                     kind: "string_content",
                                                     text: "value",
                                                     children: []
                                                   },
                                                   %PythonParser.AstNode{
                                                     kind: "string_end",
                                                     text: "\"",
                                                     children: []
                                                   }
                                                 ]
                                               }
                                             ]
                                           },
                                           %PythonParser.AstNode{
                                             kind: "}",
                                             text: "}",
                                             children: []
                                           }
                                         ]
                                       },
                                       %PythonParser.AstNode{
                                         kind: "]",
                                         text: "]",
                                         children: []
                                       }
                                     ]
                                   }
                                 ]
                               },
                               %PythonParser.AstNode{kind: "}", text: "}", children: []}
                             ]
                           },
                           %PythonParser.AstNode{kind: ")", text: ")", children: []}
                         ]
                       }
                     ]
                   }
                 ]
               },
               %PythonParser.AstNode{
                 kind: "expression_statement",
                 text: "process_data(\"dataset1\", {\"normalize\": True, \"scale\": 0.75})",
                 children: [
                   %PythonParser.AstNode{
                     kind: "call",
                     text: "process_data(\"dataset1\", {\"normalize\": True, \"scale\": 0.75})",
                     children: [
                       %PythonParser.AstNode{
                         kind: "identifier",
                         text: "process_data",
                         children: []
                       },
                       %PythonParser.AstNode{
                         kind: "argument_list",
                         text: "(\"dataset1\", {\"normalize\": True, \"scale\": 0.75})",
                         children: [
                           %PythonParser.AstNode{kind: "(", text: "(", children: []},
                           %PythonParser.AstNode{
                             kind: "string",
                             text: "\"dataset1\"",
                             children: [
                               %PythonParser.AstNode{
                                 kind: "string_start",
                                 text: "\"",
                                 children: []
                               },
                               %PythonParser.AstNode{
                                 kind: "string_content",
                                 text: "dataset1",
                                 children: []
                               },
                               %PythonParser.AstNode{
                                 kind: "string_end",
                                 text: "\"",
                                 children: []
                               }
                             ]
                           },
                           %PythonParser.AstNode{kind: ",", text: ",", children: []},
                           %PythonParser.AstNode{
                             kind: "dictionary",
                             text: "{\"normalize\": True, \"scale\": 0.75}",
                             children: [
                               %PythonParser.AstNode{kind: "{", text: "{", children: []},
                               %PythonParser.AstNode{
                                 kind: "pair",
                                 text: "\"normalize\": True",
                                 children: [
                                   %PythonParser.AstNode{
                                     kind: "string",
                                     text: "\"normalize\"",
                                     children: [
                                       %PythonParser.AstNode{
                                         kind: "string_start",
                                         text: "\"",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: "string_content",
                                         text: "normalize",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: "string_end",
                                         text: "\"",
                                         children: []
                                       }
                                     ]
                                   },
                                   %PythonParser.AstNode{
                                     kind: ":",
                                     text: ":",
                                     children: []
                                   },
                                   %PythonParser.AstNode{
                                     kind: "true",
                                     text: "True",
                                     children: []
                                   }
                                 ]
                               },
                               %PythonParser.AstNode{kind: ",", text: ",", children: []},
                               %PythonParser.AstNode{
                                 kind: "pair",
                                 text: "\"scale\": 0.75",
                                 children: [
                                   %PythonParser.AstNode{
                                     kind: "string",
                                     text: "\"scale\"",
                                     children: [
                                       %PythonParser.AstNode{
                                         kind: "string_start",
                                         text: "\"",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: "string_content",
                                         text: "scale",
                                         children: []
                                       },
                                       %PythonParser.AstNode{
                                         kind: "string_end",
                                         text: "\"",
                                         children: []
                                       }
                                     ]
                                   },
                                   %PythonParser.AstNode{
                                     kind: ":",
                                     text: ":",
                                     children: []
                                   },
                                   %PythonParser.AstNode{
                                     kind: "float",
                                     text: "0.75",
                                     children: []
                                   }
                                 ]
                               },
                               %PythonParser.AstNode{kind: "}", text: "}", children: []}
                             ]
                           },
                           %PythonParser.AstNode{kind: ")", text: ")", children: []}
                         ]
                       }
                     ]
                   }
                 ]
               },
               %PythonParser.AstNode{
                 kind: "expression_statement",
                 text: "log(\"Run completed\", None)",
                 children: [
                   %PythonParser.AstNode{
                     kind: "call",
                     text: "log(\"Run completed\", None)",
                     children: [
                       %PythonParser.AstNode{kind: "identifier", text: "log", children: []},
                       %PythonParser.AstNode{
                         kind: "argument_list",
                         text: "(\"Run completed\", None)",
                         children: [
                           %PythonParser.AstNode{kind: "(", text: "(", children: []},
                           %PythonParser.AstNode{
                             kind: "string",
                             text: "\"Run completed\"",
                             children: [
                               %PythonParser.AstNode{
                                 kind: "string_start",
                                 text: "\"",
                                 children: []
                               },
                               %PythonParser.AstNode{
                                 kind: "string_content",
                                 text: "Run completed",
                                 children: []
                               },
                               %PythonParser.AstNode{
                                 kind: "string_end",
                                 text: "\"",
                                 children: []
                               }
                             ]
                           },
                           %PythonParser.AstNode{kind: ",", text: ",", children: []},
                           %PythonParser.AstNode{kind: "none", text: "None", children: []},
                           %PythonParser.AstNode{kind: ")", text: ")", children: []}
                         ]
                       }
                     ]
                   }
                 ]
               }
             ]
           } = ast
  end
end
