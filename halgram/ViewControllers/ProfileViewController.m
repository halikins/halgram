//
//  ProfileViewController.m
//  halgram
//
//  Created by Halima Monds on 7/12/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import "ProfileViewController.h"
#import "Post.h"
#import "ParseUI.h"
#import "ProfileCollectionViewCell.h"
#import "PFUser+ExtendedUser.h"
@interface ProfileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *profileCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
- (IBAction)selectProfileImage:(id)sender;
@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (strong, nonatomic) UIImage *sharedImage2;
@property (strong, nonatomic) NSArray *postImages;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    self.profileCollectionView.delegate = self;
    self.profileCollectionView.dataSource = self;
    if (self.user == nil) {
        self.user = PFUser.currentUser;
    }
    self.profileImage.file = self.user.image;
    [self.profileImage loadInBackground];
    self.profileName.text = self.user.username;
    [self fetchPics];
    [super viewDidLoad];
    
    //[self fetchPosts];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.profileCollectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 5;
    CGFloat postsPerLine = 3;
    CGFloat itemWidth = (self.profileCollectionView.frame.size.width - layout.minimumInteritemSpacing * (postsPerLine - 1))/ postsPerLine;
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)selectPicture {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    PFUser.currentUser.image = [self getPFFileFromImage:editedImage];
    
    [PFUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
    }];
    self.profileImage.image = editedImage;
    
    //editedImage = self.uploadPhoto;
    //self.sharedImage2 = editedImage;
    // Do something with the images (based on your use case)
    //self.sharedImage = [self resizeImage:editedImage withSize:editedImage.size];
    //self.profileImage.image = self.sharedImage2;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}
*/

- (IBAction)selectProfileImage:(id)sender {
    [self selectPicture];
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"Anythinggg");
    
    ProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionViewCell" forIndexPath:indexPath];
    
    
    Post *post = self.postImages[indexPath.row];
    [cell configureCell:post];
    
    return cell;

}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return self.postImages.count;
    
}

- (void)fetchPics {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:self.user];
    query.limit = 20;
    [query includeKey:@"image"];
    [query orderByDescending:@"createdAt"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *postImages, NSError *error) {
        if (postImages != nil) {
            // do something with the array of object returned by the call
            /*for (Post; *post;) {
             NSLog(<#NSString * _Nonnull format, ...#>)
             }*/
            self.postImages= postImages;
            [self.profileCollectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
@end
