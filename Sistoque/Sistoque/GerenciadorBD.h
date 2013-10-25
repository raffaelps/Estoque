//
//  GerenciadorBD.h
//  Banco2
//
//  Created by Fabio Marinho on 14/09/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>


//Instruções para utilização:
// * Para inserir um registro, utilizar getNovaInstancia, popular as propriedades e chamar depois o metodo inserir para persistir
// * Para editar, deve-se recuperar o registro de interesse dentre um dos retornados por listaTodos, alterar as propriedades e
// chamar o metodo salvar
// Para remover um registro, basta chamar o método remover.


@interface GerenciadorBD : NSObject

+ (NSManagedObjectContext *) managedObjectContext;
+ (void) setManagedObjectContext:(NSManagedObjectContext *) context;

//*** Exemplo de utilizacao ***: Produto *p = [GerenciadorBD getNovaInstancia:[Produto class]];
+ (NSManagedObject *) getNovaInstancia:(Class) classe;
+ (void) salvar:(NSManagedObject *) entidade;
+ (void) inserir:(NSManagedObject *) entidade;

//*** Exemplo de utilizacao ***:
//NSArray *arr = [GerenciadorBD listarTodos:[Produto class] ordenacao:@"descricao"];
+ (NSArray *) listarTodos:(Class) classe ordenacao: (NSString *) ordenacao;

+ (void) remover:(NSManagedObject *) entidade;
+ (NSNumber *) getNextAutoIncrement:(NSString *) entityName fieldIdKey:(NSString *) idKey;


@end
