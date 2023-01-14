const tasksDOM = document.querySelector('.tasks')
const showTask = async () => {
  try {
    const {
      data: { books },
    } = await axios.get('/api/v1/books')
    //const { issuer, _id, name, author, status, duedate } = books
    const allBooks = books.map((book) =>{
      return `<table><tr><td id = "name">${book.issuer}</td><td id = "author">${book.regno}</td><td id = "status">${book.name}</td><td id = "issuer">${book.issuedate}</td><td id = "duedate">${book.duedate}</td></tr><table>`
    }).join('')
    tasksDOM.innerHTML = allBooks
  } catch (error) {
    console.log(error)
  }
}

showTask()