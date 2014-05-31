//
//  TADescriptionViewController.m
//  TourismApp
//
//  Created by Alex De Biasi on 30/05/14.
//  Copyright (c) 2014 Alex De Biasi. All rights reserved.
//

#import "TADescriptionViewController.h"

@interface TADescriptionViewController ()
@property (strong, nonatomic) IBOutlet UIImageView* descimage;
@property (strong, nonatomic) IBOutlet UILabel* desctitle;
@property (strong, nonatomic) IBOutlet UILabel* descdescription;
@end

@implementation TADescriptionViewController{
    int pos;
}

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
    // Do any additional setup after loading the view.
    self.desctitle.text=[NSString stringWithFormat:@"(%d)",pos];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRow:(int)i{
    pos=i;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
