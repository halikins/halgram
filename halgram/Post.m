//
//  Post.m
//  halgram
//
//  Created by Halima Monds on 7/10/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import "Post.h"
#import "Parse.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage:(UIImage * _Nullable)image withCaption:(NSString * _Nullable)caption withCompletion:(PFBooleanResultBlock _Nullable)completion {
    Post *newPost = [Post new];
    image = [self resizeImage:image withSize:image.size];
    //[self resizeImage:editedImage withSize:editedImage.size];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    [newPost saveInBackgroundWithBlock:completion];
    
    
}

+ (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.height, size.width)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    //check if image is not nil
    if (!image){
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    //get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}
@end
