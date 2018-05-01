//
//  TRLMovieController.m
//  Movie Search ObjC
//
//  Created by Michael Duong on 2/16/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

#import "TRLMovieController.h"
#import "TRLMovie.h"

@implementation TRLMovieController

+ (TRLMovieController *)shared {
    static TRLMovieController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [TRLMovieController new];
    });
    return shared;
}

+ (void)fetchMovieInfoWithTitle:(NSString *)title completion:(void (^)(NSArray *movies))completion;
{
    NSString *baseURLString = @"https://api.themoviedb.org/3/search/movie?";
    NSString *APIKey = @"api_key=c33253faf7c49b0fe479be705dbe9b0d";
    NSString* queryParam = @"&query=";

    NSString *combinedURL = [NSString stringWithFormat:@"%@%@%@%@", baseURLString, APIKey, queryParam, title];
    
    NSURL *URL = [NSURL URLWithString:combinedURL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error)  {
            NSLog(@"Error: %@", error);
            completion(nil);
            return;
        }
        if (!data)  {
            NSLog(@"Error: No data returned from data task");
            completion(nil);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *movieArray = jsonDictionary[@"results"];
        
        NSMutableArray *movies = [[NSMutableArray alloc]init];
        
        for(NSDictionary *dict in movieArray) {
            TRLMovie *movie = [[TRLMovie alloc]initWithDictionary:dict];
            
            [movies addObject:movie];
        }
        
        if (!jsonDictionary) {
            NSLog(@"Error: could not serialize data");
            completion(nil);
            return;
        }
        
        NSString *errorString = jsonDictionary[@"error"];
        
        if (errorString) {
            NSLog(@"%@", errorString);
            completion(nil);
            return;
        }
        
        completion(movies);
    }] resume];
}

@end
