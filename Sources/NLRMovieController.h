//
//  NLRMovieController.h
//  MovieSearch
//
//  Created by Nick Reichard on 3/17/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@class NLRMovie;

NS_ASSUME_NONNULL_BEGIN

@interface NLRMovieController : NSObject

// Singleton
+ (NLRMovieController *)shared;

- (void)fetchMovieForSearchTerm:(NSString *)searchTerm completion:(void (^) (NSArray *movies))completion;

- (void)fetchMoviePosterImage:(NSString *)imageURLString completion:(void (^) (UIImage *))completion;

- (NSString *)fetchAPIKeyFromPlist;

@end

NS_ASSUME_NONNULL_END
