//
//  MovieController.h
//  MovieSearch
//
//  Created by Nick Reichard on 3/10/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.

//  Note: How and Why are all our controllers so different in each project. Throughly know THIS!!!

// We are using the + because its a class method?? KNOW THIS BETTER!!! (- vs the +)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Movie;

NS_ASSUME_NONNULL_BEGIN

@interface MovieController : NSObject
+ (MovieController *)shared;

+ (void) fetchMovieInformationFromAPIWithTitle:(NSString *)title completion: (void (^)(Movie *posterImage))completion;

// We need a function to grab the image

+ (void) fetchMoviePosterImageWithURL:(NSString *)urlString completion: (void (^) (UIImage *poster))completion;

+ (NSString *) fetchAPIKeyFromPlist;

@end

NS_ASSUME_NONNULL_END
