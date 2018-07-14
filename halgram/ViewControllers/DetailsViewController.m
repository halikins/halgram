//
//  DetailsViewController.m
//  halgram
//
//  Created by Halima Monds on 7/12/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import "DetailsViewController.h"


@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [self detailUser: (Post *)self.post];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)detailUser: (Post *)post {
    self.detailCaption.text = self.post.caption;
    self.detailImage.image = nil;
    self.detailImage.file = self.post[@"image"];
    [self.detailImage loadInBackground];
    
    NSDate *timeStamp = self.post.createdAt;
    NSDateFormatter *objDateFormatter = [[NSDateFormatter alloc] init];
    [objDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [objDateFormatter setDateStyle:NSDateFormatterLongStyle];
    [objDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *stringDate = [objDateFormatter stringFromDate:timeStamp];
    self.detailTimestamp.text = stringDate;
    //[objDateFormatter dateF romString: ];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
