import UIKit

var greeting = "Hello, playground"

//task 1

class Book {
    var bookID: Int
    var title: String
    var author: String
    var isBorrowed: Bool
    
    init(bookID: Int,title: String,author: String, isBorrowed: Bool) {
        self.bookID = bookID
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }
    
    func borrowed() {
        isBorrowed = true
    }
    
    func returned() {
        isBorrowed = false
    }
}


class Owner {
    var ownerId: Int
    var name: String
    var borrowedBooks: [Book]
    
    init(ownerId: Int, name: String) {
        self.ownerId = ownerId
        self.name = name
        self.borrowedBooks = []
    }
    
    func accesToBorrow(book: Book) {
        if !book.isBorrowed {
            book.borrowed()
            borrowedBooks.append(book)
            print("\(name) get access to the: \(book.title)")
        } else {
            print("\(name) you can't  borrow the book, this book already borrowed.")
        }
    }
    
    func returnBook(book: Book) {
        if let index = borrowedBooks.firstIndex(where: {$0.bookID == book.bookID}){
            borrowedBooks.remove(at: index)
            book.returned()
            print("\(name) return the book: \(book.title)")
        } else {
            print(" \(name) cannot return the book")
        }
    }
}



class Library {
    var booksArray: [Book]
    var ownerArray: [Owner]
    
    init(booksArray: [Book] = [],ownerArray: [Owner] = []) {
        self.booksArray = booksArray
        self.ownerArray = ownerArray
    }
    
    func addBook(book: Book) {
        booksArray.append(book)
    }
    
    func addOwner(owner: Owner) {
        ownerArray.append(owner)
    }
    
    func availableBook() -> [Book] {
        return booksArray.filter{!$0.isBorrowed}
    }
    
    func BorrowedBooks() -> [Book] {
        return booksArray.filter{$0.isBorrowed}
    }
    
    func ownerById(ownerId: Int) -> Owner? {
        return ownerArray.first { $0.ownerId == ownerId }
    }
    
    func booksBorrowedByOwner(owner: Owner) -> [Book] {
        return owner.borrowedBooks
    }
    
    func allowToBorrowBook(book: Book, owner: Owner) -> Bool {
        if book.isBorrowed {
            print("book is already borrowed.")
            return false
        }
        
        if owner.borrowedBooks.contains(where: { $0.bookID == book.bookID }) {
            print("book is already borrowed by the owner.")
            return false
        }
        
        owner.accesToBorrow(book: book)
        return true
    }
}


let book1 = Book(bookID: 1, title: "Harry potter", author: "J. K. Rowling", isBorrowed: false)
let book2 = Book(bookID: 2, title: "jane Eyre", author: "Charlotte Bronte", isBorrowed: false)
let book3 = Book(bookID: 3, title: "Dracula", author: "Bram Stoker", isBorrowed: false)

let owner1 = Owner(ownerId: 1, name: "mariami")
let owner2 = Owner(ownerId: 2, name: "rezo")
let owner3 = Owner(ownerId: 3, name: "gio")

let library = Library()

library.addBook(book: book1)
library.addBook(book: book2)
library.addBook(book: book3)
library.addOwner(owner: owner1)
library.addOwner(owner: owner2)
library.addOwner(owner: owner3)

let availableBooks = library.availableBook()
print("Available Books: ")
for book in availableBooks {
    print("Title: \(book.title)")
}

library.allowToBorrowBook(book: book1, owner: owner1)

library.allowToBorrowBook(book: book1, owner: owner2)

let borrowedBooksOwner1 = library.booksBorrowedByOwner(owner: owner1)
print("\nBooks borrowed by \(owner1.name):")
for book in borrowedBooksOwner1 {
    print("Title: \(book.title), Author: \(book.author)")
}

library.allowToBorrowBook(book: book1, owner: owner1)




//task 2


class Product {
    var productID: Int
    var name: String
    var price: Double
    
    init(productID: Int,
         name: String,
         price: Double) {
        self.price = price
        self.name = name
        self.productID = productID
    }
}


class Cart {
    var cartID: Int
    var items: [Product]
    
    init(cartID: Int,
         items: [Product]) {
        self.cartID = cartID
        self.items = items
    }
    
    func addProduct(product: Product) {
        items.append(product)
    }
    
    func deleteProduct(productID: Int) {
        if let index = items.firstIndex(where: { $0.productID == productID }) {
            items.remove(at: index)
        }
    }
    
    func calculateTotalPrice() -> Double {
        let totalPrice = items.reduce(0) { $0 + $1.price }
        return totalPrice
    }
    
    func clearCart() {
        items.removeAll()
    }
    
}


class User {
    var userID: Int
    var username: String
    var cart: Cart
    
    init(userID: Int, username: String, cart: Cart) {
        self.userID = userID
        self.username = username
        self.cart = cart
    }
    
    func addProductToCart(product: Product) {
        cart.addProduct(product: product)
    }
    
    func removeProductFromCart(productID: Int) {
        cart.deleteProduct(productID: productID)
    }
    
    func checkout() -> Double {
        let totalPrice = cart.calculateTotalPrice()
        cart.clearCart()
        return totalPrice
    }
}


let product1 = Product(productID: 1, name: "Product 1", price: 20.0)
let product2 = Product(productID: 2, name: "Product 2", price: 8.0)
let product3 = Product(productID: 3, name: "Product 3", price: 10.0)

let user1Cart = Cart(cartID: 1, items: [])
let user2Cart = Cart(cartID: 2, items: [])
let user3Cart = Cart(cartID: 3, items: [])


let user1 = User(userID: 1, username: "User one", cart: user1Cart)
let user2 = User(userID: 2, username: "User two", cart: user2Cart)
let user3 = User(userID: 3, username: "User three", cart: user3Cart)



user1.addProductToCart(product: product1)
user1.addProductToCart(product: product2)
user2.addProductToCart(product: product2)
user2.addProductToCart(product: product3)
user3.addProductToCart(product: product2)

print("\(user1.username)'s Cart Total amount: $\(user1.checkout())")
print("\(user2.username)'s Cart Total amount: $\(user2.checkout())")
print("\(user3.username)'s Cart Total amount: $\(user3.checkout())")



user1.cart.clearCart()
user2.cart.clearCart()

