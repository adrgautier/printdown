from pygments.lexer import RegexLexer, words
from pygments.token import Name, Keyword

class GraphQLLexer(RegexLexer):
    name = 'GraphQL'
    aliases = ['graphql','graphQL','graphQl','GraphQl','Graphql']
    tokens = {
        'root': [
            (words(('query', 'mutation', 'fragment', 'on', 'type', 'schema', 'scalar', 'enum', 'interface', 'input')), Keyword),
            (r'\w+', Name),
        ],
    }