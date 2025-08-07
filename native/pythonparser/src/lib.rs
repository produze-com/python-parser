use rustler::{Env, NifResult, Term, Encoder, NifStruct};
use tree_sitter::{Node, Parser};

#[derive(NifStruct)]
#[module = "PythonParser.AstNode"]
struct AstNode {
    kind: String,
    text: String,
    children: Vec<AstNode>,
}

mod atoms {
    rustler::atoms! {
        ok,
        error,
        parse_failed
    }
}

fn build_ast(node: Node, source_code: &str) -> AstNode {
    let children: Vec<AstNode> = node
        .children(&mut node.walk())
        .map(|child| build_ast(child, source_code))
        .collect();

    AstNode {
        kind: node.kind().to_string(),
        text: node.utf8_text(source_code.as_bytes()).unwrap_or("").to_string(),
        children,
    }
}

#[rustler::nif]
fn parse<'a>(env: Env<'a>, source_code: &str) -> NifResult<Term<'a>> {
    let language = tree_sitter_python::language();
    let mut parser = Parser::new();
    
    parser
        .set_language(language) 
        .expect("Error loading Python grammar");

    if let Some(tree) = parser.parse(source_code, None) {
        let root_node = tree.root_node();
        let ast = build_ast(root_node, source_code);

        Ok((atoms::ok(), ast).encode(env))
    } else {
        Ok((atoms::error(), atoms::parse_failed()).encode(env))
    }
}

rustler::init!("Elixir.PythonParser");