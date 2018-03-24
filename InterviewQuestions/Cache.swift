//
//  Cache.swift
//  InterviewQuestions
//
//  Created by 李玲 on 3/24/18.
//  Copyright © 2018 Jay. All rights reserved.
//

import Foundation

//LRU: least recently used strategy.
class Cache<Key:Hashable, Value:Hashable> {

    private var container:[Key:Value] = [:]
    private var priorityQueue = List<Key>()
    private let capacity:UInt
    
    var description:String{
        return log()
    }
    
    init(_ max:UInt) {
        capacity = max
    }
    
    func save(value:Value, with key:Key){
        if priorityQueue.depth >= capacity {
            let key = priorityQueue.dropLast()!
            container.removeValue(forKey: key)
        }
        if priorityQueue.contains(key) {
            priorityQueue.push(key)
        }else{
            priorityQueue.add(key)
        }
        container[key] = value
    }
    
    func value(For key:Key)->Value? {
        guard let value = container[key] else{
            return nil
        }
        priorityQueue.push(key)
        return value
    }
    
    private func log()->String{
        guard !container.isEmpty else{
            return "Cache is empty"
        }
        var result = "Cache content:["
        for (_,value) in container.enumerated() {
            result.append("\(value),")
        }
        result = String(result.dropLast())
        result += "]"
        return result
    }
    
}

//Linked List
class List<T:Hashable> {
    
    class Node<T:Hashable> {
        var value:T
        weak var previous:Node?
        var next:Node?
        
        init(_ value:T) {
            self.value = value
        }
    }
    
    private var head:Node<T>?
    private var tail:Node<T>?
    
    var depth:UInt = 0
    var description:String{
        return log()
    }
    
    //Add value to the tail of the list
    func append(_ value:T){
        depth += 1
        guard head != nil else{
            head = Node(value)
            return
        }
        guard tail != nil else{
            tail = Node(value)
            head?.next = tail
            tail?.previous = head
            return
        }
        let temp = tail!
        tail = Node(value)
        temp.next = tail
        tail?.previous = temp
    }
    
    //Add value to the head of the list
    func add(_ value:T){
        depth += 1
        guard head != nil else{
            head = Node(value)
            return
        }
        guard tail != nil else{
            let temp = head!
            tail = temp
            head = Node(value)
            head?.next = tail
            tail?.previous = head
            return
        }
        let temp = head!
        head = Node(value)
        head?.next = temp
        temp.previous = head
    }
    
    func contains(_ value:T)->Bool{
        guard tail != nil else{
            return head?.value == value
        }
        var current = head
        while current?.next != nil {
            defer{
                current = current?.next
            }
            if current?.value == value {
                return true
            }
        }
        return current?.value == value
    }
    
    //Push value to the head of the list
    @discardableResult
    func push(_ value:T)->Bool{
        guard head != nil && head?.value != value else{
            return false
        }
        guard tail?.value != value else{
            let newHead = tail
            let last = tail?.previous
            tail = last
            tail?.next = nil
            let second = head
            newHead?.next = second
            newHead?.previous = nil
            second?.previous = newHead
            return true
        }
        var current = head!
        while current.next != nil {
            defer{
                current = current.next!
            }
            if current.value == value{
                let previous = current.previous
                let next = current.next
                previous?.next = next
                next?.previous = previous
                let temp = head!
                head = current
                head?.previous = nil
                head?.next = temp
                temp.previous = head
                return true
            }
        }
        return false
    }
    
    @discardableResult
    func remove(_ value:T)->Bool{
        guard head != nil else{
            return false
        }
        guard head!.value != value else{
            depth = 0
            head = head?.next
            head?.previous = nil
            return true
        }
        var current = head!
        while current.next != nil{
            defer{
                current = current.next!
            }
            if current.value == value {
                depth -= 1
                let previous = current.previous
                let next = current.next
                previous?.next = next
                next?.previous = previous
                return true
            }
        }
        if current.value == value {
            depth -= 1
            let previous = current.previous
            let next = current.next
            previous?.next = next
            next?.previous = previous
            return true
        }
        return false
    }
    
    func dropLast()->T?{
        guard head != nil else{
            return nil
        }
        guard tail != nil else{
            reset()
            return nil
        }
        let result = tail!.value
        let last = tail!.previous
        last?.next = nil
        tail = last
        return result
    }
    
    func reset(){
        depth = 0
        head = nil
        tail = nil
    }
    
    private func log()->String{
        guard head != nil else{
            return "Empty List"
        }
        var description = "List:["
        var current = head!
        while current.next != nil {
            defer{
                current = current.next!
            }
            description += "\(current.value),"
        }
        description += "\(current.value)]"
        return description
    }
}
