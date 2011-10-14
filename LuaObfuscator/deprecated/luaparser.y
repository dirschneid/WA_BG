%namespace LuaObfuscator
%visibility public
%output=luaparser.cs 

%{
%}

//%valuetype Statement
%YYLTYPE Location

%start LuaScript


%token Identifier
%token IntegerConst DoubleConst StringConst


// Операторы

%token	DOUBLE_QUOTE
%token	PERCENT
%token	AMPERSAND
%token	QUOTE
%token	LEFT_PAREN
%token	RIGHT_PAREN
%token	ASTERISK
%token	PLUS_SIGN
%token	COMMA
%token	MINUS_SIGN
%token	PERIOD
%token	SOLIDUS
%token	COLON
%token	SEMICOLON
%token	QUESTION_MARK
%token	VERTICAL_BAR
%token	LEFT_BRACKET
%token	RIGHT_BRACKET
%token	LEFT_CURLYBRACKET
%token	RIGHT_CURLYBRACKET
%token	POWER
%token	TWO_DOTS
%token	THREE_DOTS
%token	CAGE
%token	EQUAL

%token	OPERATOR_LT		//'<'
%token	OPERATOR_LE		//'<='
%token	OPERATOR_NE		//'~='
%token	OPERATOR_EQ		//'=='
%token	OPERATOR_GT		//'>'
%token	OPERATOR_GE		//'>='

// Ключевые слова (в алфавитном порядке)

// Список зарезервированных слов
%token	AND
%token	BREAK
%token	DO 
%token	ELSE END
%token	FALSE
%token	FOR FUNCTION
%token	IF ELSEIF IN
%token	LOCAL
%token	NIL NOT
%token	OR
%token	REPEAT RETURN
%token	THEN TRUE
%token	UNTIL
%token	WHILE

//%left	VERTICAL_BAR //'|'
//%left	AMPERSAND //'&'
%left	PLUS_SIGN MINUS_SIGN //'+' '-'
%left	ASTERISK SOLIDUS PERCENT //'*' '/' '%'
%left	UMINUS


%%

Number
	:	IntegerConst
	|	DoubleConst
	;

Name
	:	Identifier
	;

String
	:	StringConst
	;


// ===============================================================
//
LuaScript
	:	/*empty */
	|	BLOCK EOF
	;

BLOCK
	:	_STAT
	|	_STAT _LASTSTAT
	;

_STAT
	:	STAT
	|	STAT SEMICOLON
	;

_LASTSTAT
	:	/* empty */
	|	LASTSTAT
	|	LASTSTAT SEMICOLON
	;

STAT
	:	VARLIST EQUAL EXPLIST
	|	FUNCTIONCALL
	|	DO BLOCK END
	|	WHILE EXP DO BLOCK END
	|	REPEAT BLOCK UNTIL EXP
	|	_IF
	|	FOR Name EQUAL EXP _FOR_EXP DO BLOCK END
	|	FOR NAMELIST IN EXPLIST DO BLOCK END
	|	FUNCTION FUNCNAME FUNCBODY
	|	LOCAL FUNCTION Name FUNCBODY
	|	_LOCALS
	;

LASTSTAT
	:	RETURN
	|	RETURN EXPLIST
	|	BREAK
	;

FUNCNAME
	:	_CLASSNAME
	|	_CLASSNAME COLON Name
	;

_CLASSNAME
	:	Name
	|	_CLASSNAME PERIOD Name
	;

VARLIST
	:	VAR
	|	VARLIST COMMA VAR
	;


VAR
	:	Name
	|	PREFIXEXP LEFT_BRACKET EXP RIGHT_BRACKET
	|	PREFIXEXP PERIOD Name
	;

NAMELIST
	:	Name
	|	NAMELIST COMMA Name
	;

EXPLIST
	:	EXP
	|	EXPLIST COMMA EXP
	;

EXP
	:	NIL
	|	FALSE
	|	TRUE
	|	Number
	|	String
	|	THREE_DOTS
	|	_FUNCTION
	|	PREFIXEXP
	|	TABLECONSTRUCTOR
	|	EXP BINOP EXP
	|	UNOP EXP 
	;

PREFIXEXP
	:	VAR
	|	FUNCTIONCALL
	|	LEFT_PAREN EXP RIGHT_PAREN
	;

FUNCTIONCALL
	:	PREFIXEXP ARGS
	|	PREFIXEXP COLON Name ARGS
	;

ARGS
	:	LEFT_PAREN EXPLIST RIGHT_PAREN
	|	LEFT_PAREN RIGHT_PAREN
	|	TABLECONSTRUCTOR
	|	String
	;

_FUNCTION
	:	FUNCTION FUNCBODY
	;

FUNCBODY
	:	LEFT_PAREN RIGHT_PAREN BLOCK END
	|	LEFT_PAREN PARLIST RIGHT_PAREN BLOCK END
	;

PARLIST
	:	NAMELIST
	|	THREE_DOTS
	|	NAMELIST COMMA THREE_DOTS
	;

TABLECONSTRUCTOR
	:	LEFT_CURLYBRACKET RIGHT_CURLYBRACKET
	|	LEFT_CURLYBRACKET FIELDLIST RIGHT_CURLYBRACKET
	;

FIELDLIST
	:	FIELD _NEXT_FIELD
	|	FIELD _NEXT_FIELD FIELDSEP
	;

_NEXT_FIELD
	:	/* empty */
	|	FIELDSEP FIELD
	;


FIELD
	:	LEFT_BRACKET EXP RIGHT_BRACKET EQUAL EXP
	|	Name EQUAL EXP
	|	EXP
	;

FIELDSEP
	:	COMMA
	|	SEMICOLON
	;

BINOP
	:	PLUS_SIGN
	|	MINUS_SIGN
	|	ASTERISK
	|	SOLIDUS
	|	POWER
	|	PERCENT
	|	TWO_DOTS
	|	OPERATOR_LT
	|	OPERATOR_LE
	|	OPERATOR_GT
	|	OPERATOR_GE
	|	OPERATOR_EQ
	|	OPERATOR_NE
	|	AND
	|	OR
	;

UNOP
	:	UMINUS
	|	NOT
	|	CAGE
	;

_IF
	:	IF EXP THEN BLOCK _ELSEIF END
	|	IF EXP THEN BLOCK _ELSEIF ELSE BLOCK END
	;

_ELSEIF
	:	/* empty */
	|	_ELSEIF ELSEIF EXP THEN BLOCK
	;

_FOR_EXP
	:	EXP
	|	_FOR_EXP COMMA EXP
	;

_LOCALS
	:	LOCAL NAMELIST
	|	LOCAL NAMELIST EQUAL EXPLIST
	;

%%
	public string GetText(Location location)
	{
		return ((Scanner)base.Scanner).GetText(location);
	}

	public Parser(Scanner scanner)
		: base(scanner)
	{
 	}
