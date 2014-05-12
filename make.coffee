#!/usr/bin/env coffee

require 'shelljs/make'
path = require 'path'
mission = require 'mission'

mission.time()

coffee = ->
  mission.coffee
    find: /\.coffee$/, from: 'coffee/', to: 'js/', extname: '.js'
    options:
      bare: yes

target.compile = ->
  coffee()

target.watch = ->
  mission.watch
    files: ['cirru/', 'coffee/']
    trigger: (filepath, extname) ->
      switch extname
        when '.coffee'
          filepath = path.relative 'coffee/', filepath
          mission.coffee
            file: filepath, from: 'coffee/', to: 'js/', extname: '.js'
            options:
              bare: yes

target.pre = ->
  target.compile()
  mission.bump
    files: [
      'manifest.json'
      'package.json'
    ]
    options:
      at: 'prerelease'
