user = require './user.coffee'
fs = require 'fs'
url = require 'url'
pug = require 'pug'


renderResource = (filename, type, res, callback) ->
  if type == "html"
    # pug rendering
    console.log "rendering pug resource #{filename}"
    pug.renderFile "views/#{filename}",
      pretty: true
    , (err, html) ->
      throw err if err
      res.writeHead 200,
        'Content-Type': "text/#{type}"
      res.write html
      res.end()

  else if type == "css"
    # css => stylus
    console.log "rendering resource #{filename} of type #{type}"
    fs.readFile "public/#{type}/#{filename}", (err, file) ->
      throw err if err
      res.writeHead 200,
        'Content-Type': "text/#{type}"
      res.write file
      res.end()

  else if type == "js"
    # js
    console.log "rendering resource #{filename} of type #{type}"
    fs.readFile "public/#{type}/#{filename}", (err, file) ->
      throw err if err
      res.writeHead 200,
        'Content-Type': "text/#{type}"
      res.write file
      res.end()

  else if type == "img"
    # img
    console.log "rendering resource #{filename} of type #{type}"
    fs.readFile "public/#{type}/#{filename}", (err, file) ->
      res.writeHead 200,
        'Content-Type': "text/#{type}"
      if(typeof file != 'undefined' && file != null)
        res.write file
        res.end()
      else
        console.log("Fichier Introuvable")
        fs.readFile "public/img/Not-found.jpg", (err, file) ->
          res.writeHead 200,
            'Content-Type': "text/#{type}"
          res.write file
          res.end()
        console.log("Requested file is missing or unfound");

module.exports =
  logic: (req, res) ->
    url = url.parse req.url
    [ _, directory, filetype, filename ] = url.pathname.split "/"
    directory = "/" if directory == ""

    switch directory
      when "/"
        renderResource "index.pug", "html", res
      when "team"
        renderResource "project.pug", "html", res
      when "proj"
        renderResource "project.pug", "html", res
      when "save"
        user.save "testu", "testpwd", () ->
          res.writeHead 201,
            'Content-Type': 'text/plain'
          res.end 'User is saved'
      when "get"
        console.log "/get"
        user.get "testu", () ->
          res.writeHead 200,
            'Content-Type': 'text/plain'
          res.end 'got the users'
      when "public"
        renderResource filename, filetype, res
      else
        renderResource "notfound.pug", "html", res

  port: "8888"
  address: "127.0.0.1"
