from typing import List, Optional

from fastapi import FastAPI
from strawberry.fastapi import GraphQLRouter
import strawberry


@strawberry.type
class Book:
    id: int
    name: str
    genre: str
    author: str



books = [
    Book(id=1, name="Journey to the Unknown", genre="Adventure", author="Mark Shumakher"),
    Book(id=2, name="Whispers of the Night", genre="Romance", author="Kate Johnson"),
    Book(id=3, name="The Silent Forest", genre="Thriller", author="Anna Taylor"),
    Book(id=4, name="Cosmos Unveiled", genre="Science", author="Carl Vane"),
    Book(id=5, name="The Art of Code", genre="Programming", author="John Doe"),
    Book(id=6, name="Shadows of the Past", genre="Historical Fiction", author="Emily Green"),
    Book(id=7, name="Adventures in AI", genre="Sci-Fi", author="Sophia K. Brown"),
    Book(id=8, name="The Hidden Truth", genre="Mystery", author="Robert Lane"),
]


@strawberry.type
class Query:
    @strawberry.field
    def book_by_id(self, id: int) -> Optional[Book]:
        return next((book for book in books if book.id == id), None)

    @strawberry.field
    def books(self) -> List[Book]:
        return books


@strawberry.type
class Mutation:
    @strawberry.mutation
    def create_book(self, name: str, genre: str, author: str) -> Book:
        new_book = Book(id=len(books) + 1, name=name, genre=genre, author=author)
        books.append(new_book)
        return new_book

    @strawberry.mutation
    def update_book(self, id: int, name: Optional[str] = None, genre: Optional[str] = None, author: Optional[str] = None) -> Optional[Book]:
        book = next((book for book in books if book.id == id), None)
        if book:
            if name is not None:
                book.name = name
            if genre is not None:
                book.genre = genre
            if author is not None:
                book.author = author
        return book

    @strawberry.mutation
    def delete_book(self, id: int) -> str:
        global books
        # Найти книгу перед изменением списка
        book_exists = any(book.id == id for book in books)
        
        if book_exists:
            books = [book for book in books if book.id != id]
            return f"Book with ID {id} was successfully deleted"
        else:
            return "Book not found"



schema = strawberry.Schema(query=Query, mutation=Mutation)


app = FastAPI()
graphql_app = GraphQLRouter(schema)
app.include_router(graphql_app, prefix="/graphql")
