//
//  ComposeViewController.m
//  halgram
//
//  Created by Halima Monds on 7/10/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import "ComposeViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
@interface ComposeViewController ()
- (IBAction)shareButton:(id)sender;
- (IBAction)cancelButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *text;
- (IBAction)postTakePicture:(id)sender;
- (IBAction)postSelectPicture:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *placementImage;
@property (strong, nonatomic) UIImage *sharedImage;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)takePicture {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
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
    //editedImage = self.uploadPhoto;
    self.sharedImage = editedImage;
    // Do something with the images (based on your use case)
    //self.sharedImage = [self resizeImage:editedImage withSize:editedImage.size];
    self.placementImage.image = self.sharedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
//- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
//    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    
//    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
//    resizeImageView.image = image;
//    
//    UIGraphicsBeginImageContext(size);
//    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return newImage;
//}


- (IBAction)shareButton:(id)sender {
    [Post postUserImage:self.sharedImage withCaption:self.text.text withCompletion:^(BOOL succeeded, NSError *error){
        if(succeeded){
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        
        }];
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)postTakePicture:(id)sender {
    [self takePicture];
    //self.placementImage.image = self.sharedImage;
}

- (IBAction)postSelectPicture:(id)sender {
    [self selectPicture];
    //self.placementImage.image = self.sharedImage;
}
@end
