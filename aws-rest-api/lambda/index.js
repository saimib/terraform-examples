exports.handler =  function(event, context, callback) {
    
    let res = {
        status: 200,
        body: [
            {
              "id": "d290f1ee-6c54-4b01-90e6-d701748f0851",
              "author": "George Washington",
              "date": "2016-08-29T09:12:33.001Z",
              "content": "sample content",
              "comments": [
                {
                  "id": "d290f1ee-6c54-4b01-90e6-d701748f0855",
                  "author": "Raul nevari",
                  "date": "2016-08-29T09:12:33.001Z",
                  "content": "sample comment"
                }
              ]
            }
        ]
    }
    callback(null, res)
}