//
//  FeedViewController.m
//  halgram
//
//  Created by Halima Monds on 7/9/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import "FeedViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "FeedCell.h"
#import "DetailsViewController.h"
#import "ProfileViewController.h"
@interface FeedViewController ()<UITableViewDelegate,UITableViewDataSource, UINavigationControllerDelegate, UIPickerViewDelegate>
- (IBAction)logoutButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *feedView;
@property(strong, nonatomic) NSArray *posts;
@property(strong, nonatomic) UIRefreshControl *refreshControl;
@property(strong, nonatomic) UIImage *profileImage;
@end

@implementation FeedViewController
//**********************************************************
- (void)viewDidLoad {
    [super viewDidLoad];
    self.feedView.dataSource = self;
    self.feedView.delegate = self;
    [self fetchPost];
    self.feedView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(fetchPost) forControlEvents:UIControlEventValueChanged];
    [self.feedView insertSubview:self.refreshControl atIndex:0];
    [self.feedView addSubview:self.refreshControl];
}
//**********************************************************
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"profileSegue"]) {
        UIButton *button = sender;
        int row = button.tag;
        //NSIndexPath *indexPath = [self.feedView indexPathForCell:tappedCell];
        Post *post = self.posts[button.tag];
        ProfileViewController *profileViewController = [segue destinationViewController];
        profileViewController.user = post.author;
        NSLog(@"Tapping on a post!");
        //[self.feedView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.feedView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = post;
        NSLog(@"Tapping on a post!");
        [self.feedView deselectRowAtIndexPath:indexPath animated:YES];
    } else {
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

}

//**********************************************************
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FeedCell *cell= [tableView dequeueReusableCellWithIdentifier:@"FeedCell" forIndexPath:indexPath];
    
    Post *post = self.posts[indexPath.row];
    
    [cell configureCell:post rowNumber:(int)indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)fetchPost {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;
    [query includeKey:@"image"];
    
    [query includeKey:@"caption"];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            /*for (Post; *post;) {
                NSLog(<#NSString * _Nonnull format, ...#>)
            }*/
            self.posts = posts;
            [self.feedView reloadData];
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}


- (IBAction)logoutButton:(id)sender {
[PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error){
    if (error) {
            // Handle error
            NSLog(@"Error");
        }
    else {
            NSLog(@"User logged out successfully");
            [UIApplication sharedApplication].delegate;
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            appDelegate.window.rootViewController = loginViewController;
            //[self.performSegueWithIdentifier:@"logoutSegue", sender:nil];
        }

        // PFUser.current() will now be nil
    }];
}
@end
