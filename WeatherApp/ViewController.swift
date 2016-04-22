//
//  ViewController.swift
//  WeatherApp
//
//  Created by Luke Morse on 4/22/16.
//  Copyright © 2016 Luke Morse. All rights reserved.
//

import UIKit

/// Page delegate protocol
///
/// This is a protocol implemented by all of the child view controllers. I'm using it
/// just to keep track of the page number. In practical usage, you might also pass a
/// reference to a model object, too.

@objc protocol PageDelegate {
    var pageNumber: Int { get set }
}

class ViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    private let identifiers = ["A", "B", "C", "D", "E"]  // the storyboard ids for the four child view controllers
    private var cache = NSCache()
    private var observer: NSObjectProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observer = NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationDidReceiveMemoryWarningNotification, object: nil, queue: NSOperationQueue.mainQueue()) { [unowned self] notification in
            self.cache.removeAllObjects()
        }
        self.dataSource = self
        
        setViewControllers([viewControllerForPage(0)!], direction: .Forward, animated: false, completion: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(observer)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let page = (viewController as! PageDelegate).pageNumber + 1
        
        return viewControllerForPage(page)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let page = (viewController as! PageDelegate).pageNumber - 1
        
        return viewControllerForPage(page)
    }
    
    private func viewControllerForPage(page: Int) -> UIViewController? {
        if page >= 0 && page < identifiers.count {
            if let controller = cache.objectForKey(page) as? UIViewController {
                return controller
            }
            if let controller = storyboard?.instantiateViewControllerWithIdentifier(identifiers[page]) {
                (controller as? PageDelegate)?.pageNumber = page
                cache.setObject(controller, forKey: page)
                return controller
            }
        }
        
        return nil
    }
}

