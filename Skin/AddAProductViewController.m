//
//  AddAProductViewController.m
//  Skin
//
//  Created by intel on 10/4/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import "AddAProductViewController.h"
#import "ProductSearchTableViewController.h"

@interface AddAProductViewController ()
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *listPicker;

@end

@implementation AddAProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    //sending the list of transactions to table view
    //ProductSearchTableViewController *dest = segue.destinationViewController;
    //dest.transTableList = self.productTextField.text;
}


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
