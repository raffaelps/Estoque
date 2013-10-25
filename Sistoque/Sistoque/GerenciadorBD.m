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

+ (NSArray *) listarTodos:(Class) classe ordenacao: (NSString *) ordenacao {
    NSString *nomeClasse = NSStringFromClass(classe);
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:nomeClasse inManagedObjectContext:self.managedObjectContext];
    //request.predicate = [NSPredicate predicateWithFormat:@"ativo = 1"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:ordenacao ascending:YES]];
    
    NSError *error = nil;
    NSArray *arr = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error) {
        return arr ;
    } else {
        NSLog(@"%@",[error description]);
        return nil;
    }
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
    
    //NSLog(@"Proximo id: %d", myIndex);
    return [NSNumber numberWithInteger:myIndex];
}

@end
