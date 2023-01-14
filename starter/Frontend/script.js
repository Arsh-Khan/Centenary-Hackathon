const tasksDOM = document.querySelector('.tasks')
const searchBtn = document.getElementById('btn')
const searchText = document.getElementById('searchText')
const showTask = async () => {
  try {
    const {
      data: { books },
    } = await axios.get('/api/v1/books')
    //const { issuer, _id, name, author, status, duedate } = books
    const allBooks = books.map((book) =>{
      return `<table><tr><td id = "name">${book.name}</td><td id = "author">${book.author}</td><td id = "status">${book.status}</td><td id = "issuer">${book.issuer}</td><td id = "duedate">${book.duedate}</td></tr><table>`
    }).join('')
    tasksDOM.innerHTML = allBooks
  } catch (error) {
    console.log(error)
  }
}

//showTask()
const showSearch = async () =>{
   try {
    const {
      data: { books },
    } = await axios.get('/api/v1/books?name=Data')
    //const { issuer, _id, name, author, status, duedate } = books
    const allBooks = books.map((book) =>{
      return `<table><tr><td id = "name">${book.name}</td><td id = "author">${book.author}</td><td id = "status">${book.status}</td><td id = "issuer">${book.issuer}</td><td id = "duedate">${book.duedate}</td></tr><table>`
    }).join('')
    tasksDOM.innerHTML = allBooks
  } catch (error) {
    console.log(error)
  }  
  tasksDOM.innerHTML = ''
}
showTask()