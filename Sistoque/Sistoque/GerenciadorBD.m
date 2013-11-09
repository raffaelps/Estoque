//
//  GerenciadorBD.m
//  Banco2
//
//  Created by Fabio Marinho on 14/09/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GerenciadorBD.h"

@implementation GerenciadorBD


static NSManagedObjectContext *managedObjectContext;

+ (NSManagedObjectContext *)managedObjectContext {
    return managedObjectContext;
}

+ (void)setManagedObjectContext:(NSManagedObjectContext *)context {
    managedObjectContext = context;
}

+ (void) salvar:(NSManagedObject *) entidade
{
    
	[[GerenciadorBD managedObjectContext] save:nil];
	
}

+ (void) remover:(NSManagedObject *) entidade{
    [[GerenciadorBD managedObjectContext] deleteObject:entidade];
    NSError *error = nil;
    [[GerenciadorBD managedObjectContext] save:&error];
    if (error) {NSLog(@"%@",error.description);}
}

+ (void) inserir:(NSManagedObject *) entidade{
    [[GerenciadorBD managedObjectContext] insertObject:entidade];
    
    NSError *error = nil;
    [[GerenciadorBD managedObjectContext] save:&error];
    if (error) {NSLog(@"%@",error.description);}
    [self.managedObjectContext save:nil];
}

+(NSArray *)listar:(NSString*) nomeClasse comPropriedades:(NSArray*) propriedades ePredicado:(NSPredicate*) predicado eOrdem: (NSString *) ordenacao{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:nomeClasse inManagedObjectContext:self.managedObjectContext];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:ordenacao ascending:YES]];
    
    if(propriedades!=nil)
        [request setPropertiesToFetch:propriedades];
    
    if(predicado!=nil)
        request.predicate = predicado;
    
    NSError *error = nil;
    NSArray *arr = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error) {
        return arr ;
    } else {
        NSLog(@"%@",[error description]);
        return nil;
    }
}

+ (NSArray *) listarPropriedades:(Class) classe comPropriedades:(NSArray*) propriedades eFiltro:(NSString*)filtro eOrdem: (NSString *) ordenacao eAscending:(BOOL)ascending
{
    NSString *nomeClasse = NSStringFromClass(classe);
    NSPredicate *predicado = [NSPredicate predicateWithFormat:filtro];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:nomeClasse inManagedObjectContext:self.managedObjectContext];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:ordenacao ascending:ascending]];
    
    if(propriedades!=nil)
        [request setPropertiesToFetch:propriedades];
    
    if(predicado!=nil)
        request.predicate = predicado;
    
    NSError *error = nil;
    NSArray *arr = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error) {
        return arr ;
    } else {
        NSLog(@"%@",[error description]);
        return nil;
    }
}

+(NSArray *)listarPropriedades:(Class) classe comPropriedades:(NSArray*) propriedades eFiltro:(NSString*)filtro eOrdem: (NSString *) ordenacao{
    NSString *nomeClasse = NSStringFromClass(classe);
    NSPredicate *predicado = [NSPredicate predicateWithFormat:filtro];
    return [self listar:nomeClasse comPropriedades:propriedades ePredicado:predicado eOrdem:ordenacao];
}

+ (NSArray *) listarTodos:(Class) classe ordenacao: (NSString *) ordenacao {
    NSString *nomeClasse = NSStringFromClass(classe);

    return [self listar:nomeClasse comPropriedades:nil ePredicado:nil eOrdem:ordenacao];
}

+ (NSArray *) listarTodosAtivo:(Class) classe ordenacao: (NSString *) ordenacao {
    NSString *nomeClasse = NSStringFromClass(classe);
    NSPredicate *predicado = [NSPredicate predicateWithFormat:@"ativo = 1"];
    
    return [self listar:nomeClasse comPropriedades:nil ePredicado:predicado eOrdem:ordenacao];
}


+ (NSManagedObject *) getNovaInstancia:(Class) classe{
    NSString *nomeClasse = NSStringFromClass(classe);
    NSEntityDescription *desc = [NSEntityDescription
                                 entityForName:nomeClasse
                                 inManagedObjectContext: [GerenciadorBD managedObjectContext] ];
    return [[NSManagedObject alloc]
            initWithEntity:desc
            insertIntoManagedObjectContext:nil];    
}


+ (NSNumber *) getNextAutoIncrement:(NSString *) entityName fieldIdKey:(NSString *) idKey {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:idKey ascending:YES]];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    NSManagedObject *maxIndexedObject = [results lastObject];
    request = nil;
    if (error) {
        NSLog(@"%@",[error description]);
        return nil;
    }
    
    NSInteger myIndex = 1;
    
    if (maxIndexedObject) {
        myIndex = [[maxIndexedObject valueForKey:idKey] integerValue] + 1;
    }
    
    return [NSNumber numberWithInteger:myIndex];
}

@end
