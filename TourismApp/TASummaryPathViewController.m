//
//  TASummaryPathViewController.m
//  TourismApp
//
//  Created by Riccardo on 11/06/14.
//  Copyright (c) 2014 Alex De Biasi. All rights reserved.
//

#import "TASummaryPathViewController.h"

@interface TASummaryPathViewController ()
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *instructionsLabel;
@end

@implementation TASummaryPathViewController

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
    self.distanceLabel.text = self.distance;
    self.timeLabel.text = self.time;
    
    NSString *htmlString = [self.instructions componentsJoinedByString:@"<br><br>"];
    NSAttributedString *string = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
    self.instructionsLabel.attributedText = string;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)backToHome:(UIButton*)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
