const tasksDOM = document.querySelector('.tasks');
const tasks2DOM = document.querySelector('.tasks2');
const issueCount = document.getElementById('issueCount');
const issueCount2 = document.getElementById('issueCount2');
var count = 0;
var count2 = 0;
const showTask = async () => {
  try {
    const {
      data: { books },
    } = await axios.get('/api/v1/books')
    //const { issuer, _id, name, author, status, duedate } = books
    const allBooks = books.map((book) =>{
      
      if(book.issuer === "NA")
        return
      const today = new Date();
      const yyyy = today.getFullYear();
      let mm = today.getMonth() + 1; // Months start at 0!
      let dd = today.getDate();
      
      if (dd < 10) dd = '0' + dd;
      if (mm < 10) mm = '0' + mm;
      
      var Today = dd + '-' + mm + '-' + yyyy;
      var date2 = book.issuedate;

      
      //Today = new Date(Today.split('-')[2],Today.split('-')[1]-1,Today.split('-')[0]);
      //date2 = new Date(date2.split('-')[2],date2.split('-')[1]-1,date2.split('-')[0]);
      //var timeDiff = date2.getTime() - today.getTime();
      //var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24)); 
      //if(Today != date2)
        //return
      //alert(diffDays)​; //1008 */
      if(date2 != Today)
        return
       return `<table id = ${count}><tr><td id = "name">${book.issuer}</td><td id = "author">${book.name}</td><td id = "status">${book.author}</td><td id = "issuer">${book.duedate}</td><td id = "duedate">${book._id.substring(7,25)}</td></tr><table>`
    }).join('')
    tasksDOM.innerHTML = allBooks;
    ++count;
    
  } catch (error) {
    console.log(error)
  }
}

const showTask2 = async () => {
    try {
      const {
        data: { books },
      } = await axios.get('/api/v1/books')
      //const { issuer, _id, name, author, status, duedate } = books
      const allBooks = books.map((book) =>{
        
        if(book.issuer === "NA")
          return
        const today = new Date();
        const yyyy = today.getFullYear();
        let mm = today.getMonth() + 1; // Months start at 0!
        let dd = today.getDate();
        
        if (dd < 10) dd = '0' + dd;
        if (mm < 10) mm = '0' + mm;
        
        var Today = dd + '-' + mm + '-' + yyyy;
        var date2 = book.duedate;
  
        
        //Today = new Date(Today.split('-')[2],Today.split('-')[1]-1,Today.split('-')[0]);
        //date2 = new Date(date2.split('-')[2],date2.split('-')[1]-1,date2.split('-')[0]);
        //var timeDiff = date2.getTime() - today.getTime();
        //var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24)); 
        //if(Today != date2)
          //return
        //alert(diffDays)​; //1008 */
        if(date2 != Today)
          return
        let id = book._id
        id = id.substring(7,25)
        return `<table id = ${count}><tr><td id = "name">${book.issuer}</td><td id = "author">${book.name}</td><td id = "status">${book.author}</td><td id = "issuer">${book.issuedate}</td><td id = "duedate">${id}</td></tr><table>`
      }).join('')
      tasks2DOM.innerHTML = allBooks;
      ++count2;
     
    } catch (error) {
      console.log(error)
    }
  }

showTask()
showTask2()
