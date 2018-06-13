//
//  PageViewController.swift
//  PageViewController
//
//  Created by Ngọc Anh on 6/13/18.
//  Copyright © 2018 Ngọc Anh. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        // Dieu huong hien thi du lieu
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        self.delegate = self
        configurePageControl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    // Dieu Huong ViewControll
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "sbBlue"),
                self.newVc(viewController: "sbRed"),
                self.newVc(viewController: "sbGreen")]
    }()
    
    // Nguon Du lieu
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex > 0 else {
            return orderedViewControllers.last
            //   return nil                   {khi muoon so view ko lap lai }
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        guard orderedViewControllersCount > nextIndex else {
                return orderedViewControllers.last
             //   return nil                   {khi muoon so view ko lap lai }
        }
        return orderedViewControllers[nextIndex]
    }
    // them cac cham trang
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    // chuc nang uy quyen
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
