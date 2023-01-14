/*const Book = require('../models/book')

const getAllBooksStatic = async (req, res) => {
  //const Books = await Book.find({}) -> To get all 
  const books = await Book.find.sort('status').select('name')
  res.status(200).json({books, nbHits: books.length});
};

const getAllBooks = async (req, res) => {   
    const {name, status, issuer, duedate, issuedate, regno, sort, fields, numericFilters} = req.query // If the query on the server contains featured. localhost:5000/ap1/v1/Books?featured=true&page=2 
    //const {name, status, issuer, duedate, sort, fields, numericFilters} = req.query // If the query on the server contains featured. localhost:5000/ap1/v1/Books?featured=true&page=2 
    const queryObject = {}
    if(name){
      queryObject.name = {$regex: search, $options: 'i'}
    }
    if(issuer){
      queryObject.issuer = issuer
    }
    if(status){
      queryObject.status = status
    }
    if(duedate){
      queryObject.duedate = duedate
    }
    if(issuedate){
      queryObject.issuedate = issuedate
    }
    if(regno){
      queryObject.regno = regno
    }
    if (numericFilters) {
      const operatorMap = {
        '>': '$gt',
        '>=': '$gte',
        '=': '$eq',
        '<': '$lt',
        '<=': '$lte',
      };
      const regEx = /\b(<|>|>=|=|<|<=)\b/g;
      let filters = numericFilters.replace(
        regEx,
        (match) => `-${operatorMap[match]}-`
      );
      const options = ['price', 'rating'];
      filters = filters.split(',').forEach((item) => {
        const [field, operator, value] = item.split('-');
        if (options.includes(field)) {
          queryObject[field] = { [operator]: Number(value) };
        }
      });
    }
    // const Books = await Book.find(queryObject) 
    // console.log(queryObject) 
    let result = Book.find(queryObject)
    if(sort){
      const sortList = sort.split(',').join(' ')
      result = result.sort(sortList)
    }
    else{
      result = result.sort('name')
    }
    if(fields){
      const fieldsList = fields.split(',').join(' ')
      result = result.select(fieldsList)          // EX. localhost:3000/api/vi/books?sort=-name,price&fields=company,rating
    }
    
    //const page = Number(req.query.page) || 1
    //const limit = Number(req.query.limit) || 10
    //const skip = (page - 1) * limit               // Skip affects amount of items that we are skipping 
    //result = result.skip(skip).limit(limit)
    const books = await(result)
    res.status(200).json({books});
};

module.exports = {
    getAllBooks, 
    getAllBooksStatic,
}

//http://localhost:3000/api/v1/Books?sort=price
//http://localhost:3000/api/v1/Books?fields=name,price
*/
const Book = require('../models/book');

const getAllBooksStatic = async (req, res) => {
  const books = await Product.sort('status')
    

  res.status(200).json({ books, nbHits: books.length });
};
const getAllBooks = async (req, res) => {
  const { name, sort, fields, numericFilters } = req.query;
  const queryObject = {};

  /* if (featured) {
    queryObject.featured = featured === 'true' ? true : false;
  }
  if (company) {
    queryObject.company = company;
  } */
  if (name) {
    queryObject.name = { $regex: name, $options: 'i' };
  }
  if (numericFilters) {
    const operatorMap = {
      '>': '$gt',
      '>=': '$gte',
      '=': '$eq',
      '<': '$lt',
      '<=': '$lte',
    };
    const regEx = /\b(<|>|>=|=|<|<=)\b/g;
    let filters = numericFilters.replace(
      regEx,
      (match) => `-${operatorMap[match]}-`
    );
    const options = ['price', 'rating'];
    filters = filters.split(',').forEach((item) => {
      const [field, operator, value] = item.split('-');
      if (options.includes(field)) {
        queryObject[field] = { [operator]: Number(value) };
      }
    });
  }

  let result = Book.find(queryObject);
  // sort
  if (sort) {
    const sortList = sort.split(',').join(' ');
    result = result.sort(sortList);
  } else {
    result = result.sort('status');
  }

  if (fields) {
    const fieldsList = fields.split(',').join(' ');
    result = result.select(fieldsList);
  }
  /* const page = Number(req.query.page) || 1;
  const limit = Number(req.query.limit) || 10;
  const skip = (page - 1) * limit;

  result = result.skip(skip).limit(limit); */
  // 23
  // 4 7 7 7 2

  const books = await result;
  res.status(200).json({ books });
};

module.exports = {
  getAllBooks,
  getAllBooksStatic,
};