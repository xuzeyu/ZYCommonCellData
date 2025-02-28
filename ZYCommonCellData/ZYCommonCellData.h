//
//  ZYCommonCellData.h
//  YNFCGJ
//
//  Created by XUZY on 2022/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZYCellDataSearchResult;
typedef void (^ZYCellDataCallbackKey)(NSString *key);
typedef void (^ZYCellDataCallbackKeyValue)(NSString *key, id value);
@interface ZYCellData : NSObject
@property (nonatomic, strong, nullable) NSString *identifier;
@property (nonatomic, strong, nullable) Class cellClass;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong, nullable) ZYCellDataCallbackKey rValueCallback;
@property (nonatomic, strong, nullable) ZYCellDataCallbackKeyValue sValueCallback;

//快速链式操作
@property (nonatomic, strong) ZYCellData * (^sIdentifier)(NSString *identifier);
@property (nonatomic, strong) ZYCellData * (^sCellClass)(Class cellClass);
@property (nonatomic, strong) ZYCellData * (^sValue)(NSString *key, id value);
@property (nonatomic, strong) ZYCellData * (^sValueNotCallback)(NSString *key, id value);
@property (nonatomic, strong) ZYCellData * (^sSValueCallback)(ZYCellDataCallbackKeyValue sValueCallback); //.sSValueCallback(^void(NSString *key, id value) {});
@property (nonatomic, strong) id (^gValue)(NSString *key);
@property (nonatomic, strong) ZYCellData * (^rValue)(NSString *key);
@property (nonatomic, strong) ZYCellData * (^sRValueCallback)(ZYCellDataCallbackKey rValueCallback);//.sRValueCallback(^void(NSString *key) {});
@property (nonatomic, strong) ZYCellData * (^sSelected)(BOOL selected);
@end

@interface ZYSectionData : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *rows;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL isAlone; //是否单独的一个section，即section之间需不需要间距
@property (nonatomic, strong) ZYSectionData * (^sTitle)(NSString *title);
@property (nonatomic, strong) ZYSectionData * (^sIsAlone)(BOOL isAlone);
@property (nonatomic, strong) ZYSectionData * (^sValue)(NSString *key, id value);
@property (nonatomic, strong) id (^gValue)(NSString *key);
@property (nonatomic, strong) ZYSectionData * (^sSelected)(BOOL selected);

- (ZYCellDataSearchResult * _Nullable)searchCellDataByIdentifier:(NSString *)identifier; //在当前sectionData里面查询，所以indexPath.section默认为0
+ (ZYCellDataSearchResult * _Nullable)searchCellDataByIdentifier:(NSString *)identifier sectionDatas:(NSArray *)sectionDatas;
@end

@interface ZYCellDataSearchResult : NSObject
@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, strong) ZYSectionData *sectionData;
@property (nonatomic, strong) ZYCellData *cellData;
@end

NS_ASSUME_NONNULL_END
