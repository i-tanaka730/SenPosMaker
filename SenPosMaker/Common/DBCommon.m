//
//  DBCommon.m
//  SenPosMaker
//
//  Created by 田中郁也 on 2013/03/21.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import "DBCommon.h"

@implementation DBCommon

// 定数定義
NSString * const DB_FILE_NAME_FULL   = @"senpos.sqlite";
NSString * const DB_FILE_NAME   = @"senpos";
NSString * const DB_FILE_EXT   = @"sqlite";


@synthesize database;


- (BOOL)loadDb {
	LOG_CURRENT_METHOD;
	//起動時にDBファイルの準備
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
	NSString *storePath = [basePath stringByAppendingPathComponent: DB_FILE_NAME_FULL];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// 端末内にDBファイルが存在しない場合、リソースからコピーする
	if (![fileManager fileExistsAtPath:storePath]) {
		NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:DB_FILE_NAME ofType:DB_FILE_EXT];
        NSError *error;
        if (![fileManager copyItemAtPath:defaultStorePath toPath:storePath error:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            return NO;  // Fail
            
		}
	}
    
    return YES;
}

- (void) openDb  {
	LOG_CURRENT_METHOD;
    //DBのオープン
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
	NSString *path = [basePath stringByAppendingPathComponent: DB_FILE_NAME_FULL];
    
    database = nil;
    if( sqlite3_open([ path UTF8String ], &database ) != SQLITE_OK ) {
        // DB ファイルオープン失敗
        sqlite3_close( database );
        NSLog( @"Failed to open databese with following message '%s'.", sqlite3_errmsg( database ));
        database = nil;
        
    }
}

- (NSString *) getPhrase {
    LOG_CURRENT_METHOD;

    
    // DB からフレーズを取得
    sqlite3_stmt *statement = NULL;

    const char *sqlcnt = "SELECT COUNT(*) FROM catchphrase";
    
    int statuscnt = sqlite3_prepare_v2( database, sqlcnt, -1, &statement, NULL );
    
    int cnt = 0;
    if( statuscnt == SQLITE_OK ) {
        sqlite3_reset(statement);
        
        if (sqlite3_step( statement ) == SQLITE_ROW ) {
            
            // データが存在する場合は、メッセージを抽出する
            cnt = sqlite3_column_int(statement, 0 );
            NSLog(@"%d",cnt);

            
        }
    } else {
        NSLog( @"Failed to prepare statement with '%s'.", sqlite3_errmsg( g_dbCommon.database ));
    }
    sqlite3_finalize( statement );

    //乱数初期化
    srand(time(nil));
    int key = rand()%cnt;
    
    
    const char *sql = "SELECT phrase FROM catchphrase where cd = ?";
    
    int status = sqlite3_prepare_v2( database, sql, -1, &statement, NULL );
    
    NSString * msg = nil;
    if( status == SQLITE_OK ) {
        sqlite3_reset(statement);
        sqlite3_bind_int(statement, 1, key);
        
        if (sqlite3_step( statement ) == SQLITE_ROW ) {
            
            // データが存在する場合は、メッセージを抽出する
            msg = [self dbtext:statement index:0 ];
//            NSLog(@"%@",msg);
            
        }
    } else {
        NSLog( @"Failed to prepare statement with '%s'.", sqlite3_errmsg( g_dbCommon.database ));
    }
    sqlite3_finalize( statement );
    
    return msg;

}
- ( NSString * ) dbtext:( sqlite3_stmt *) statement index:(int)i {
	LOG_CURRENT_METHOD;
    char *value = (char *)sqlite3_column_text(statement, i );
    if (value == nil) {
        //DBにnullが設定されている場合、空文字に変更
        NSString *str = @"";
        value = (char *)[str UTF8String];
    }
    return [NSString stringWithUTF8String:value];
    
}
/*
- (NSString *)makeImageName:(NSString *)origin
{
    return [NSString stringWithFormat:@"%@_%@", g_lang, origin];
}

- (NSString *)webLanguage:(NSString *)lang
{
    return ([lang isEqualToString:@"zh-Hans"])?@"zh":lang;
}

- (NSString *)trimErrcd:(NSString *)errcd
{
    NSString * errcd2 = [errcd stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    errcd2 = [errcd2 stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    return errcd2;
}

*/

@end
