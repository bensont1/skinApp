//
//  CurrentsTableViewController.m
//  Skin
//
//  Created by intel on 10/14/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import "CurrentsTableViewController.h"
#import "Product.h"
#import "List.h"
#import "ViewController.h"

@interface CurrentsTableViewController ()
@property List *main;
@property NSString *detailTextKey;

@end

@implementation CurrentsTableViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.parseClassName = @"CurrentProducts";
        self.textKey = @"productName";
        
        self.detailTextKey = @"brand";
        
        // Whether the built−in pull−to−refresh is enabled
        self.pullToRefreshEnabled = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.currentsList = [[NSMutableArray alloc] init];
    self.main = [List sharedList];
    //NSLog([NSString stringWithFormat:@"%@",self.main.currentsList]);
    [self loadObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view. - now can swipe to show delete option
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Editing");
    if (editingStyle == UITableViewCellEditingStyleDelete) { //edit = delete option
        //find selected object
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) { //delete object, then reload objects
            [self loadObjects];
        }];
    }
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *selected = [self.objects objectAtIndexPath:indexPath];
}*/

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.main.currentsList.count;
}*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"current" forIndexPath:indexPath];
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"current" forIndexPath:indexPath];
    
    // Configure the cell...
    /*Product *productinCell = (Product *) [self.main.currentsList objectAtIndex:indexPath.row];
    cell.textLabel.text = productinCell.productName;
    cell.detailTextLabel.text = productinCell.brand;*/
    
    if (cell == nil)
    {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"current"];
    }
    
    PFObject *object = [self.objects objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [object objectForKey:self.textKey];
    cell.detailTextLabel.text = [object objectForKey:self.detailTextKey];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *dest = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    dest.passedProduct = self.main.currentsList[indexPath.row];
}*/


@end
