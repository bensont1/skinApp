//
//  AddAProductViewController.m
//  Skin
//
//  Created by intel on 10/4/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import "AddAProductViewController.h"

@interface AddAProductViewController ()
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *listPicker;
@property Product *productToAdd;


@end

/*@protocol ProductSearchDelegate <NSObject>

- (void)productSearchTableViewController:(ProductSearchTableViewController *)productSearchTableViewController didSelectProduct:(Product *)aNewProduct;

@end*/

@implementation AddAProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.productLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Nav search

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //Product *theProduct = [[Product alloc] init];
    
    
    //[segue.destinationViewController setDelegate:dest];
    
    if ([segue.identifier isEqualToString:@"productSearch"]) {
        //we are handing off control to another navigation controller, get a reference to it
        //UINavigationController *navigationController = segue.destinationViewController;
        // in that navigation controller the first view shown will be our AddItemViewController
        // get a reference to that controller
        //ProductSearchTableViewController *controller = (ProductSearchTableViewController *) navigationController.topViewController;
        ProductSearchTableViewController *controller = segue.destinationViewController;
        
        controller.query = self.productTextField.text;
        // set ourselves as its delegate
        controller.delegate = self;
        
        NSLog(@"in prepare for product search...");
    }

    
}

- (void)ProductSearchTableViewController:(ProductSearchTableViewController *)controller didFinishAddingItem:(Product *)item
{
    //int newRowIndex = [items count]; [items addObject:item];
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection :0];
    //NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    // this is a more efficient way of doung [self.tableView reloadData]
    // reloadData just says that things have changed and that the table
    // should reload itself, which triggers a big table refresh
    // this simply tells the table that one new element has appeared
    // if it is in the view then changes are animated(possibly)
    // if the object is our of view then the table doesn’t change visually
    //[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic]
    // dismiss our modal view we are done with it
    self.productToAdd = item;
    self.productLabel.text = [NSString stringWithFormat:@"%@ %@", self.productToAdd.brand, self.productToAdd.productName];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*- (void)productSearchTableViewController:(ProductSearchTableViewController *)productSearchTableViewController didSelectProduct:(Product *)aNewProduct {
    if (aNewProduct) {
        self.productToAdd = aNewProduct;
        self.productLabel.text = self.productToAdd.productName;
    }
    [self dismissViewControllerAnimated:YES completion: nil];
}*/

/*-(void)createSelectedProduct:(NSString *) brand productName:(NSString *)productName ingredients:(NSArray *)ingredients thumbnailURL:(NSString *)thumbnailURL {
    self.productToAdd = [[Product alloc] init];
    
    self.productToAdd.productName = productName;
    self.productToAdd.brand = brand;
    self.productToAdd.ingredients = ingredients;
    self.productToAdd.thumbnailURL = thumbnailURL;
    
    self.productLabel.text = productName;
}*/


#pragma mark - Picker

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *) pickerView {
    return 1;
}

-(NSInteger) pickerView :(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger) component {

    return 3; //number of lists
}

-(NSString *) pickerView : (UIPickerView *) pickerView titleForRow:( NSInteger)row forComponent: (NSInteger) component {
    
    NSArray *productLists = [NSArray arrayWithObjects:@"Current Products", @"Favorites", @"Dislikes", nil];
    
    return [productLists objectAtIndex:row];
}

/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //we should also be checking if the segue is the one we want
    //Get that shared bookshelf
    Bookshelf *books = [Bookshelf sharedBookshelf];
    
    //Which book?
    int index = [self.picker selectedRowInComponent : 0 ];
    books.currentBook = [ books.booklist objectAtIndex: index];
}*/

@end
