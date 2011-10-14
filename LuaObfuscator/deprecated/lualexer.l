%namespace LuaObfuscator
%option unicode noEmbedBuffers nolisting caseInsensitive
%visibility public

double_quote				\"
percent						\%
ampersand					&
quote						\'
left_paren					\(
right_paren					\)
asterisk					*
plus_sign					+
comma						,
minus_sign					-
period						\.
solidus						/
colon						:
semicolon					;
question_mark				?
vertical_bar				|
left_bracket				\[
right_bracket				\]
left_curlybracket			\{
right_curlybracket			\}
power						\^
cage						\#
equal						=

two_dots					\.\.
three_dots					\.\.\.

operator_lt					<
operator_le					<=
operator_ne					~=
operator_eq					==
operator_gt					>
operator_ge					>=

space						[ \t\n\r\f]
newline						[\n\r]
non_newline					[^\n\r]

comment						("--"{non_newline}*)

whitespace					({space}+|{comment})

digit						[0-9]
hexdigit					[0-9A-Fa-f]

integer						{digit}+
decimal						(({digit}*\.{digit}+)|({digit}+\.{digit}*))
decimalfail					{digit}+\.\.
double						({integer}|{decimal})[Ee][\-\+]?{digit}+
doublefail1					({integer}|{decimal})[Ee]
doublefail2					({integer}|{decimal})[Ee][\-\+]

string_const				({quote}[^{quote}]{quote})

identifier_start			[A-Za-z_]
identifier_part				[A-Za-z_0-9]
identifier_body				{identifier_start}{identifier_part}*
identifier					{identifier_body}

string						([nN])?'[^']*'
hexstring					0x{hexdigit}*

%%

{comment}					{ /* Игнорируем комментарий */ }


// Ключевые слова (в алфавитном порядке)
AND							{ return TokenInfo(Tokens.AND); }
BREAK						{ return TokenInfo(Tokens.BREAK); }
DO							{ return TokenInfo(Tokens.DO); }
ELSE						{ return TokenInfo(Tokens.ELSE); }
END							{ return TokenInfo(Tokens.END); }
FALSE						{ return TokenInfo(Tokens.FALSE); }
FOR							{ return TokenInfo(Tokens.FOR); }
FUNCTION					{ return TokenInfo(Tokens.FUNCTION); }
IF							{ return TokenInfo(Tokens.IF); }
ELSEIF						{ return TokenInfo(Tokens.ELSEIF); }
IN							{ return TokenInfo(Tokens.IN); }
LOCAL						{ return TokenInfo(Tokens.LOCAL); }
NIL							{ return TokenInfo(Tokens.NIL); }
NOT							{ return TokenInfo(Tokens.NOT); }
OR							{ return TokenInfo(Tokens.OR); }
REPEAT						{ return TokenInfo(Tokens.REPEAT); }
RETURN						{ return TokenInfo(Tokens.RETURN); }
THEN						{ return TokenInfo(Tokens.THEN); }
TRUE						{ return TokenInfo(Tokens.TRUE); }
UNTIL						{ return TokenInfo(Tokens.UNTIL); }
WHILE						{ return TokenInfo(Tokens.WHILE); }



{identifier}				{
								Console.WriteLine("identifier: {0}", yytext);
								//yylval = new StatementIdentifier(yytext);
								return TokenInfo(Tokens.Identifier);
							}

{integer}					{
								Console.WriteLine("integer: {0}", yytext);
								//yylval = StatementExactNumericConstant.Parse(yytext);
								//if (null == yylval)
								//	yyerror("Can't convert {0} to integer", yytext);

								return TokenInfo(Tokens.IntegerConst);
							}
{decimal}					{
								Console.WriteLine("decimal: {0}", yytext);
								////yylval = StatementDecimal.Parse(yytext);
								//yylval = StatementApproximateNumericConstant.Parse(yytext);
								//if (null == yylval)
								//	yyerror("Can't convert {0} to decimal", yytext);

								return TokenInfo(Tokens.DoubleConst);
							}
{decimalfail}				{
								// возвращаем идущие подряд две точки (..) и считаем, что это целое число
								yyless(yyleng-2);

								//yylval = StatementExactNumericConstant.Parse(yytext);
								//if (null == yylval)
								//	yyerror("Can't convert {0} to integer", yytext);

								return TokenInfo(Tokens.IntegerConst);
							}
{double}					{
								Console.WriteLine("double: {0}", yytext);
								//yylval = StatementApproximateNumericConstant.Parse(yytext);
								//if (null == yylval)
								//	yyerror("Can't convert {0} to decimal", yytext);

								return TokenInfo(Tokens.DoubleConst);
							}
{doublefail1}				{
								yyless(yyleng - 1);

								//yylval = StatementApproximateNumericConstant.Parse(yytext);
								//if (null == yylval)
								//	yyerror("Can't convert {0} to decimal", yytext);

								return TokenInfo(Tokens.DoubleConst);
							}
{doublefail2}				{
								/* возвращаем назад символы [Ee][+-], и обрабатываем также, как и doublefail1 */
								yyless(yyleng-2);

								//yylval = StatementApproximateNumericConstant.Parse(yytext);
								//if (null == yylval)
								//	yyerror("Can't convert {0} to decimal", yytext);

								return TokenInfo(Tokens.DoubleConst);
							}

// Строка символов
{string}					{
								Console.WriteLine("string: {0}", yytext);
								m_str.Append(yytext);

								//Console.WriteLine("yyleng: {0}, yytext: {1}, code: {2}, m_str: {3}", yyleng, yytext, (char)code, m_str);

								if (code != '\'')
								{
									//yylval = StatementStringConstant.Parse(yytext);
									if (null == yylval)
										yyerror("Can't convert {0} to string", yytext);

									m_str = new StringBuilder();

									return TokenInfo(Tokens.StringConst);
								}
							}

// Шестнадцатиричное значение
{hexstring}					{
								Console.WriteLine("hexstring: {0}", yytext);
								// Удалим из строки префикс 0x и преобразуем ее в двоичную константу
								//yylval = StatementBinaryConstant.Parse(yytext.Substring(2));

								return TokenInfo(Tokens.BinaryConst);
							}

{double_quote}				{ return TokenInfo(Tokens.DOUBLE_QUOTE); }
{percent}					{ return TokenInfo(Tokens.PERCENT); }
{ampersand}					{ return TokenInfo(Tokens.AMPERSAND); }
{left_paren}				{ return TokenInfo(Tokens.LEFT_PAREN); }
{right_paren}				{ return TokenInfo(Tokens.RIGHT_PAREN); }
{asterisk}					{ return TokenInfo(Tokens.ASTERISK); }
{plus_sign}					{ return TokenInfo(Tokens.PLUS_SIGN); }
{comma}						{ return TokenInfo(Tokens.COMMA); }
{minus_sign}				{ return TokenInfo(Tokens.MINUS_SIGN); }
{period}					{ return TokenInfo(Tokens.PERIOD); }
{solidus}					{ return TokenInfo(Tokens.SOLIDUS); }
{colon}						{ return TokenInfo(Tokens.COLON); }
{semicolon}					{ return TokenInfo(Tokens.SEMICOLON); }
{question_mark}				{ return TokenInfo(Tokens.QUESTION_MARK); }
{vertical_bar}				{ return TokenInfo(Tokens.VERTICAL_BAR); }
{left_bracket}				{ return TokenInfo(Tokens.LEFT_BRACKET); }
{right_bracket}				{ return TokenInfo(Tokens.RIGHT_BRACKET); }
{left_curlybracket}			{ return TokenInfo(Tokens.LEFT_CURLYBRACKET); }
{right_curlybracket}		{ return TokenInfo(Tokens.RIGHT_CURLYBRACKET); }
{power}						{ return TokenInfo(Tokens.POWER); }
{cage}						{ return TokenInfo(Tokens.CAGE); }
{equal}						{ return TokenInfo(Tokens.EQUAL); }

{two_dots}					{ return TokenInfo(Tokens.TWO_DOTS); }
{three_dots}				{ return TokenInfo(Tokens.THREE_DOTS); }


{operator_lt}				{ return TokenInfo(Tokens.OPERATOR_LT); }
{operator_le}				{ return TokenInfo(Tokens.OPERATOR_LE); }
{operator_ne}				{ return TokenInfo(Tokens.OPERATOR_NE); }
{operator_eq}				{ return TokenInfo(Tokens.OPERATOR_EQ); }
{operator_gt}				{ return TokenInfo(Tokens.OPERATOR_GT); }
{operator_ge}				{ return TokenInfo(Tokens.OPERATOR_GE); }

<<EOF>>						{ return TokenInfo(Tokens.EOF); }

%%
	private StringBuilder m_str = new StringBuilder();

	public string ErrorMessage { get; private set; }

	public override void yyerror(string format, params object[] args)
	{
		//Console.WriteLine(format, args);
		ErrorMessage = string.Format("At line {0}, col {1} (pos {2}). {3}",
			yyline,
			yycol,
			yypos,
			string.Format(format, args));
	}

	private int TokenInfo(Tokens token)
	{
		yylloc = new Location(tokLin, tokCol, tokELin, tokECol, tokPos, tokEPos);

		return (int)token;
	}

	public string GetText(Location location)
	{
		return buffer.GetString(location.StartPosition, location.EndPosition);
	}
