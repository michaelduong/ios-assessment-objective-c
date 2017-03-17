//
//  NLRMovieController.m
//  MovieSearch
//
//  Created by Nick Reichard on 3/17/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//



#import "NLRMovieController.h"
#import "NLRMovie.h"

static NSString *const apiKey = @"3e6fc78d34ea9b6595d61441a091daf9";

@interface NLRMovieController ()
@property (nonatomic, copy)NSString *baseURLStirng;
@property (nonatomic, copy)NSString *imageURLString;

@end

@implementation NLRMovieController

- (instancetype)init {
    if (self) {
        _baseURLStirng = @"https://api.themoviedb.org/3/search/movie";
        _imageURLString = @"http://image.tmdb.org/t/p/w500";
    }
    return self;
}

+ (NLRMovieController *)shared {
    static NLRMovieController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [NLRMovieController new];
    });
    return shared;
}

-(void)fetchMovieForSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray *movies))completion
{
    if (!completion) { completion = ^(NSArray *p){}; }
    
    NSURL *baseURL = [[NSURL alloc] initWithString:self.baseURLStirng];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    // The way we want it to be formated. Like the datestyle in journal.styel
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
    NSURLQueryItem *posterItem = [NSURLQueryItem queryItemWithName:@"query" value:searchTerm];
    
    NSArray *queryItems = @[apiKeyItem, posterItem];
    urlComponents.queryItems = queryItems;
    NSURL *movieResultsEndpoint = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:movieResultsEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error %@", error);
            completion(nil);
        }
        
        if (!data) {
            NSLog(@"Error: No data returned from task");
            completion(nil);
        }
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error could not parse");
            completion(nil);
        }
        
        // Add Json to the movie array
        NSArray *movieDictionaries = jsonDictionary[@"results"];
        
        NSMutableArray *movies = [NSMutableArray new];
        
        for (NSDictionary *movie in movieDictionaries) {
            NLRMovie *newMovie = [[NLRMovie alloc] initWithDictionary:movie];
            if (newMovie) {
            [movies addObject:newMovie];
            }
        }
        completion(movies);
        
    }]resume];
    
}

-(void)fetchMoviePosterImage:(NSString *)imageURLString completion:(void (^)(UIImage *))completion
{
    if (!completion) { completion = ^(UIImage *p){}; }
    
    // Within NSURLSession, there are things called data tasks. Data tasks are a task for retriving the contents of a URL as an NSData object
    
    NSURL *imageURL = [[NSURL alloc] initWithString:self.imageURLString];
    NSURL *posterImageEndpoint = [imageURL URLByAppendingPathComponent:imageURLString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:posterImageEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error handeling image %@", error);
            completion(nil);
        }
        if (!data) {
            NSLog(@"Error: no data returned from image task");
            completion(nil);
        }
        UIImage *moviePoser = [[UIImage alloc] initWithData:data];
        completion(moviePoser);
        
    }]resume];
    
}

-(NSString *)fetchAPIKeyFromPlist
{
    NSURL *apiKeyPlistURL = [[NSBundle mainBundle] URLForResource:@"APIKeys" withExtension:@"plist"];
    if(!apiKeyPlistURL) {
        NSLog(@"Error: APIkey not found in p-list");
        return nil;
    }
    NSDictionary *apiKeys = [[NSDictionary alloc] initWithContentsOfURL:apiKeyPlistURL];
    NSString *apiKey = apiKeys[@"APIKey"];
    return apiKey;
}

@end
