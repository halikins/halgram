//
//  Post.h
//  halgram
//
//  Created by Halima Monds on 7/10/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import "PFObject.h"
#import "Parse/Parse.h"
#import "ParseUI.h"
@interface Post : PFObject <PFSubclassing>
@property (nonatomic,strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
// What is this for?
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFile *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

+ (void) postUserImage: (UIImage * _Nullable)image withCaption: (NSString * _Nullable)caption withCompletion: (PFBooleanResultBlock _Nullable)completion;

@end
