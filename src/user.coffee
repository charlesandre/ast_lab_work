module.exports = 
  # Save a user
  # Usage : save(name, pwd, callback)
  # - Name = user name
  # - Pwd = password
  # - Callback = function to call when done 
  save: (name, pwd, callback) ->
    if callback == null
      callback = pwd
      callback new Error "missing parameters"
    else 
      #console.log("saving " + name  + " with pwd " + pwd)
      callback()
      
  get: (name, callback) ->
    #console.log("saving " + name)
    callback()
