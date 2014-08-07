grammar Protogen;

ATTR : 'auth' | 'unauth' | 'admin' | 'global' | 'map' ;
NEWTYPE : 'newtype' ;
CATEGORY : 'category' ;
INCLUDE : 'include' ;
METHOD : 'method' ;
PRIM
    : 'i8' | 'u8'
    | 'i16' | 'u16'
    | 'i32' | 'u32' | 'f32'
    | 'i64' | 'u64' | 'f64'
    | 'array' '<' IDENT '>'
    ;
SEMI : ';' ;
LBRACE : '{' ;
RBRACE : '}' ;
COMMA : ',' ;
EQ : '=' ;
IN : 'in' ;
OUT : 'out' ;

STRING : '"' ~["]* '"' ;
IDENT : [a-zA-Z_][a-zA-Z_0-9]* ;
WS : [ \r\n\t]+ -> skip;
COMMENT : '\'' .*? ('\r\n' | '\n') ;

newtype : NEWTYPE IDENT EQ (PRIM SEMI | IDENT SEMI | object) ;
category : CATEGORY IDENT LBRACE (include | method) RBRACE ;
include : INCLUDE STRING SEMI ;
property : IDENT '=' (object | PRIM) SEMI ;
method : METHOD IDENT LBRACE ATTR* RBRACE LBRACE COMMENT* property* RBRACE ;
object : LBRACE (field COMMA)* (field COMMA?)? RBRACE ;
field : IDENT ':' IDENT ;

protocol : (newtype | category | include)* ;
