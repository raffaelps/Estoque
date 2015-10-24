//
//  ViewController.h
//  Sistoque
//
//  Created by Raffael Patrício de Souza on 27/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *menu;
}
@property (weak, nonatomic) IBOutlet UITableView *tabelaPrincipal;

@end
