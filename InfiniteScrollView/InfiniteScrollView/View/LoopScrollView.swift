//
//  LoopScrollView.swift
//  InfiniteScrollView
//
//  Created by 曾品瑞 on 2023/11/28.
//

import SwiftUI

fileprivate struct ScrollBackground: UIViewRepresentable {
    var width: CGFloat
    var spacing: CGFloat
    var number: Int
    var count: Int
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var width: CGFloat
        var spacing: CGFloat
        var number: Int
        var count: Int
        var add: Bool=false
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard self.number>0 else { return }
            
            let minX: CGFloat=scrollView.contentOffset.x
            let contentSize: CGFloat=CGFloat(self.number)*self.width
            let spacingSize: CGFloat=CGFloat(self.number)*self.spacing
            
            if(minX>(contentSize+spacingSize)) {
                scrollView.contentOffset.x-=contentSize+spacingSize
            } else if(minX<0) {
                scrollView.contentOffset.x+=contentSize+spacingSize
            }
        }
        
        init(width: CGFloat, spacing: CGFloat, number: Int, count: Int) {
            self.width=width
            self.spacing=spacing
            self.number=number
            self.count=count
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(width: self.width, spacing: self.spacing, number: self.number, count: self.count)
    }
    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {
            if let scrollView=uiView.superview?.superview?.superview as? UIScrollView, !context.coordinator.add {
                scrollView.delegate=context.coordinator
                context.coordinator.add=true
            }
        }
        
        context.coordinator.width=self.width
        context.coordinator.spacing=self.spacing
        context.coordinator.number=self.number
        context.coordinator.count=self.count
    }
}

struct LoopScrollView<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable {
    var width: CGFloat
    var spacing: CGFloat=0
    var item: Item
    
    @ViewBuilder var content: (Item.Element) -> Content
    
    var body: some View {
        GeometryReader {
            let size: CGSize=$0.size
            let count: Int=self.width>0 ? Int((size.width/self.width).rounded())+1:1
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: self.spacing) {
                    ForEach(self.item) {item in
                        self.content(item).frame(width: self.width)
                    }
                    
                    ForEach(0..<count, id: \.self) {index in
                        self.content(Array(self.item)[index%self.item.count]).frame(width: self.width)
                    }
                }
                .background {
                    ScrollBackground(width: self.width, spacing: self.spacing, number: self.item.count, count: count)
                }
            }
        }
    }
}
