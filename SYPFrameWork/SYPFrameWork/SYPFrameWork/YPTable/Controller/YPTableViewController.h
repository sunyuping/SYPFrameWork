//
//  YPTableViewController.h
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPBaseViewController.h"

@class YPTableViewDataSource;
@class YPSearchDisplayController;

@interface YPTableViewController : YPBaseViewController<UITableViewDelegate>{
    UITableView*  _tableView;
    UIView*       _tableWatermarkView;
    UIView*       _tableOverlayView;
    UIView*       _loadingView;
    UIView*       _errorView;
    UIView*       _emptyView;
    
    NSTimer*      _bannerTimer;
    
    UITableViewStyle        _tableViewStyle;
    
    UIInterfaceOrientation  _lastInterfaceOrientation;
    
    BOOL _showTableShadows;
    
    YPTableViewDataSource *_dataSource;
    
    YPSearchDisplayController  *_searchController;
    
@private
    BOOL _shouldLoadTableView;
}

@property (nonatomic, retain) NSError *error;
@property (nonatomic, assign) BOOL loadingData;//默认是NO, 载入数据时为YES,主要防止load more多次使用
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain)YPTableViewController *searchViewController;

/**
 * A view that is displayed over the table view.
 */
@property (nonatomic, retain) UIView* tableOverlayView;
@property (nonatomic, retain) UIView* tableWatermarkView;

@property (nonatomic, retain) UIView* loadingView;
@property (nonatomic, retain) UIView* errorView;
@property (nonatomic, retain) UIView* emptyView;

/**
 * The data source used to populate the table view.
 *
 * Setting dataSource has the side effect of also setting model to the value of the
 * dataSource's model property.
 */
@property (nonatomic, retain) YPTableViewDataSource *dataSource;

/**
 * The style of the table view.
 */
@property (nonatomic) UITableViewStyle tableViewStyle;

/**
 * When enabled, draws gutter shadows above the first table item and below the last table item.
 *
 * Known issues: When there aren't enough cell items to fill the screen, the table view draws
 * empty cells for the remaining space. This causes the bottom shadow to appear out of place.
 */
@property (nonatomic) BOOL showTableShadows;

/**
 * Initializes and returns a controller having the given style.
 */
- (id)initWithStyle:(UITableViewStyle)style;

/**
 * Tells the controller that the user selected an object in the table.
 *
 * By default, the object's URLValue will be opened in TTNavigator, if it has one. If you don't
 * want this to be happen, be sure to override this method and be sure not to call super.
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;


/**
 * Tells the controller that the user began dragging the table view.
 */
- (void)didBeginDragging;

/**
 * Tells the controller that the user stopped dragging the table view.
 */
- (void)didEndDragging;

/**
 * The rectangle where the overlay view should appear.
 */
- (CGRect)rectForOverlayView;
/**
 * 下拉刷新需要执行的方法
 */
- (void)pullToRefreshAction;
/**
 * 重置下拉刷新状态
 */
- (void)stopRefreshAction;
/**
 * 上拉刷新需要执行得方法
 */
- (void)infiniteScrollingAction;

- (void)refreshTable;

/**
 * emptyView 显示的时，点击button，需要执行的方法
 */
- (void)emptyViewButtonAction;

/**
 * 状态显示
 */

- (void)showEmpty:(BOOL)show;
- (void)showLoading:(BOOL)show;
- (void)showError:(BOOL)show;
/**
 * 搜索
 */

- (void)search:(NSString*)kw;
- (void)cancelSearch;

@end

