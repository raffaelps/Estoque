//
//  FormCadastroProdutoViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "FormCadastroProdutoViewController.h"
#import "GerenciadorBD.h"
#import "UIBarButtonItemHelper.h"

@interface FormCadastroProdutoViewController ()

@end

@implementation FormCadastroProdutoViewController

@synthesize cellAtivo,cellValores,cellQuantidades,cellDescricao,cellCategoria,textCategoria,textDescricao,textQuantMaxima,textQuantMinima,textValorEntrada,textValorSaida,ativo,tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Novo produto"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self adicionaBotaoOk];
    [self adicionaCategoriasArray];

    
}

- (void)carregarProduto
{
    if (self.produto)
    {
        
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)novoProduto
{
    Produto *newProduto = [GerenciadorBD getNovaInstancia:[Produto class]];
    
    
    [newProduto setId:[[NSNumber alloc]initWithInt:nextProduto]];
    [newProduto setDescricao:self.textDescricao.text];
    [newProduto setQtdeMaxima:[NSNumber numberWithInt:[self.textQuantMaxima.text intValue]]];
    [newProduto setQtdeMinima:[NSNumber numberWithInt:[self.textQuantMinima.text intValue]]];
    [newProduto setValorEntrada:[NSNumber numberWithInt:[self.textValorEntrada.text intValue]]];
    [newProduto setValorSaida:[NSNumber numberWithInt:[self.textValorSaida.text intValue]]];
    
    if ([self.ativo isOn])
    {
        [newProduto setAtivo:[NSNumber numberWithInt:1]];
    }
    else
    {
        [newProduto setAtivo:[NSNumber numberWithInt:0]];
    }
    
    [GerenciadorBD inserir:newProduto];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return cellDescricao;
    }
    if (indexPath.row == 1) {
        return cellCategoria;
    }
    if (indexPath.row == 2) {
        return cellQuantidades;
    }
    if (indexPath.row == 3) {
        return cellValores;
    }
    
    return cellAtivo;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 || indexPath.row == 3) {
        return 88;
    }
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, -200, 0);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.tableView.contentInset = edge;
    [UIView commitAnimations];
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, 200, 0);
    self.tableView.contentInset = edge;
    UITableViewCell *cell = (UITableViewCell *)[[textField superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)setNextProduto:(int)next
{
    nextProduto = next;
}

-(void)adicionaBotaoOk{
    
    NSString *title = @"OK";
    UIBarButtonItemStyle style = UIBarButtonItemStyleBordered;
    id target = self;
    SEL selector = @selector(novoProduto);
    
    UIBarButtonItemHelper *btnHelper = [[UIBarButtonItemHelper alloc] initWithTitle:title andStyle:style andTarget:target andSelector:&selector];
    
    UIBarButtonItem *btnSalvar = [btnHelper createBarButtonItemHelper];
    self.navigationItem.rightBarButtonItem = btnSalvar;
}

//Verifica se o Field pode começar a editar.
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == textCategoria){
        [self hideKeyboard];
        [self setCategoria:textField];
        return NO;
    }
    return YES;
}

- (IBAction)setCategoria:(id)sender {
    
    //0, _view.bounds.size.height+44, 320, 216
    
    UIPickerView *pickerCategorias = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 216)];
    pickerCategorias.delegate = self;
    pickerCategorias.showsSelectionIndicator = YES;
    [self.view addSubview:pickerCategorias];
    
}

-(void)hideKeyboard{
    /*for (UIView *textField in [self.view subviews]) {
        if ([textField isKindOfClass:[UITextField class]]) {
            [textField resignFirstResponder];
        }
    }*/
    [textCategoria resignFirstResponder];
    [textDescricao resignFirstResponder];
    [textValorEntrada resignFirstResponder];
    [textValorSaida resignFirstResponder];
    [textQuantMinima resignFirstResponder];
    [textQuantMaxima resignFirstResponder];
}

//PickerView

//Função de retorno do Delegate
/*-(void) getDatePickerDate:(NSDate *)date{
    if(date != nil){
        textCategoria.text = [SisUtil dateToString:date withMask:@"dd-MM-yyyy"];
    }
}*/

-(void)adicionaCategoriasArray{
    categorias = [GerenciadorBD listarTodos:[Categoria class] ordenacao:@"descricao"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    //title = [@"" stringByAppendingFormat:@"%d",row];
    Categoria *categoria = [categorias objectAtIndex:row];
    
    return categoria.descricao;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

/*INIT PickerViewDataSouce*/
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return categorias.count;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
/*END PickerViewDataSouce*/

//End PickerView

@end
