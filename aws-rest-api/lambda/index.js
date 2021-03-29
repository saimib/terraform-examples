exports.handler =  async function(event, context) {
    console.log(event.requestContext.path)
    return event.requestContext.path
}