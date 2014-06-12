//
//  TAPlaceTableViewController.m
//  TourismApp
//
//  Created by Andrea Bianco on 02/06/14.
//  Copyright (c) 2014 Alex De Biasi. All rights reserved.
//

#import "TAPlaceTableViewController.h"
#import "TAPlaceTableViewCell.h"
#import "TADetailViewController.h"

@interface TAPlaceTableViewController () {
    NSArray *contentArray;
    int rowPosition;
}

@end

@implementation TAPlaceTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* tmp=[[NSBundle mainBundle] pathForResource:self.plistName ofType:@"plist"];
    contentArray = [NSArray arrayWithContentsOfFile:tmp];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"name"  ascending:YES];
    contentArray = [contentArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [contentArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TAPlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSDictionary *categoryDict = [contentArray objectAtIndex:indexPath.row];
    NSString *placeName = [categoryDict objectForKey:@"name"];
    NSString *placeImage = [categoryDict objectForKey:@"nameImage"];
    
    cell.rowLabel.text = placeName;
    cell.rowImage.image = [UIImage imageNamed:placeImage];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(NSIndexPath*) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    rowPosition = indexPath.row;
    return indexPath;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showPlaceDetail"]){
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TADetailViewController *destViewController = segue.destinationViewController;
        NSDictionary *placeDict = [contentArray objectAtIndex:rowPosition];
        NSString *placeName = [placeDict objectForKey:@"name"];
        NSString *placeImage = [placeDict objectForKey:@"nameImage"];
        NSString *placeDesc = [placeDict objectForKey:@"description"];
        NSString *placeLat = [placeDict objectForKey:@"latitudine"];
        NSString *placeLong = [placeDict objectForKey:@"longitudine"];
        destViewController.placeName = placeName;
        destViewController.title = placeName;
        destViewController.placeImage = placeImage;
        destViewController.placeDescription = placeDesc;
        destViewController.placeLatitudine = placeLat;
        destViewController.placeLongitudine = placeLong;
    }
}


@end
