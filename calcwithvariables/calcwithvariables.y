
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <limits.h>

    void yyerror(char *s);
    int yylex();
    int yyparse();

    struct node{
        char key;
        int val;
        struct node *next;
    };

    struct table{
        int size;
        struct node **list;
    };

    struct table *hashTable = NULL;

    struct table *createTable(int size){
        struct table *t = (struct table*)malloc(sizeof(struct table));
        t->size = size;
        t->list = (struct node**)malloc(sizeof(struct node*)*size);
        int i;
        for(i=0;i<size;i++)
            t->list[i] = NULL;
        return t;
    }

    int hashCode(struct table *t,char key){
        if(key<0)
            return -(key%t->size);
        return key%t->size;
    }

    void insert(struct table *t,char key,int val){
        int pos = hashCode(t,key);
        struct node *list = t->list[pos];
        struct node *newNode = (struct node*)malloc(sizeof(struct node));
        struct node *temp = list;
        while(temp){
            if(temp->key==key){
                temp->val = val;
                return;
            }
            temp = temp->next;
        }
        newNode->key = key;
        newNode->val = val;
        newNode->next = list;
        t->list[pos] = newNode;
    }

    int lookup(struct table *t,char key){
        int pos = hashCode(t,key);
        struct node *list = t->list[pos];
        struct node *temp = list;
        while(temp){
            if(temp->key==key){
                return temp->val;
            }
            temp = temp->next;
        }
        return -1;
    }

%}

%union{
  int intval;
  char  cval;
}
%output "calcwithvariables.tab.c"
%token ID NUM EOL SC PRINT ERROR SPACE

%right ASSIGN
%left PLUS MINUS
%left MULT DIV

%type <intval> expr unary
%type <cval> var

%%

run:
    | stmts run                               {return 0;}
    | ERROR                                   {printf("syntax error\n"); return 0;}
    ;

stmts:                                        {}
    | stmts var ASSIGN line expr SC EOL       {if(hashTable==NULL) hashTable = createTable(1000); insert(hashTable,$2,$5);}
    | stmts PRINT SPACE var SC EOL            {if(hashTable==NULL) hashTable = createTable(1000); int val = lookup(hashTable,$4); if(val!=-1){printf("%d\n",val);}else{printf("syntax error\n",val);}}
    ;

expr: expr MULT expr                          {$$ = $1 * $3;}
    | expr DIV expr                           {$$ = $1 / $3;}
    | expr PLUS expr                          {$$ = $1 + $3;}
    | expr MINUS expr                         {$$ = $1 - $3;}
    | unary                                   {}
    ;

unary: MINUS unary                            {$$ = -$2;}
    | var                                     {if(hashTable==NULL) hashTable = createTable(1000); int val = lookup(hashTable,$1); if(val!=-1){$$ = val;}else{printf("syntax error\n");}}
    | NUM                                     {$$ = yylval.intval;}
    ;

var: ID                                       {$$ = yylval.cval;}
    ;

line:                                         {}              
    | EOL line                                {}    
    ;

%%

int main()
{
  yyparse();
  return 0;
}

void yyerror(char *s)
{
	printf("syntax error\n");
}