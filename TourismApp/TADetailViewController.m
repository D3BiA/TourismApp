//
//  TADetailViewController.m
//  TourismApp
//
//  Created by Andrea Bianco on 02/06/14.
//  Copyright (c) 2014 Alex De Biasi. All rights reserved.
//

#import "TADetailViewController.h"
#import "TAMapsViewController.h"

@interface TADetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *detailDesription;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@end

@implementation TADetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailDesription.text = self.placeDescription;
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < self.placeImage.count; i++) {
        CGRect frame;
        frame.origin.x = self.scroller.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scroller.frame.size;
        
        UIImageView *subview = [[UIImageView alloc] initWithFrame:frame];
        subview.image=[UIImage imageNamed:self.placeImage[i]];
        [self.scroller addSubview:subview];
    }
    
    self.scroller.contentSize = CGSizeMake(self.scroller.frame.size.width * self.placeImage.count, self.scroller.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showMap"]){
        
        TAMapsViewController *destViewController = segue.destinationViewController;
        destViewController.latitudine = self.placeLatitudine;
        destViewController.longitudine = self.placeLongitudine;
        destViewController.name = self.placeName;
    }}

- (IBAction)backHome:(UIButton*)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
