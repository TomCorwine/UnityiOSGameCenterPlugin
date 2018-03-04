//
//  UnityBridge.m
//  UnityGameCenterPlugin
//
//  Created by Tom Corwine on 3/3/18.
//  Copyright © 2018 Tom Corwine. All rights reserved.
//

#import "UnityBridge.h"

UGCGameLoadDelegate loadDelegate = NULL;
UGCGameSaveDelegate saveDelegate = NULL;

@interface UnityBridge : NSObject <UGCGameDelegate>
@end

@implementation UnityBridge

- (void)gameSaved:(BOOL)success error:(NSError *)error
{
    if (NULL == saveDelegate) {
        return;
    }

    saveDelegate(success, error.localizedDescription.UTF8String);
}

- (void)gameLoaded:(NSData *)data error:(NSError *)error
{
    if (NULL == loadDelegate) {
        return;
    }

    if (error) {
        loadDelegate(NULL, error.localizedDescription.UTF8String);
        return;
    }

    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    loadDelegate(string.UTF8String, NULL);
}

@end

static UnityBridge *_delegate = nil;

void framework_setLoadDelegate(UGCGameLoadDelegate callback)
{
    if (NULL == _delegate) {
        _delegate = [[UnityBridge alloc] init];
        [UGCGame setDelegate:_delegate];
    }

    loadDelegate = callback;
}

void framework_setSaveDelegate(UGCGameSaveDelegate callback)
{
    if (NULL == _delegate) {
        _delegate = [[UnityBridge alloc] init];
        [UGCGame setDelegate:_delegate];
    }

    saveDelegate = callback;
}

void framework_saveGame(const char *dictionaryString)
{
    NSString *string = [NSString stringWithUTF8String:dictionaryString];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    [UGCGame saveGameToGameCenter:data];
}

void framework_loadGame(void)
{
    [UGCGame loadGameFromGameCenter];
}
