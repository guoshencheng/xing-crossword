Title:  Payload JSON Format Document
Author: Sherlock
Date:   Jul 9, 2014

## Puzzle

  {
    "id" : "xzm-20140714", //[code number]-[serial number]
    "title" : "周末074",
    "map" : "0101010101010,1101010101010,0100101010101...", // comma seperated rows, 0 stands for black cell, 1 stands for white cell
    "hints" : {
      "across" : ["一本杂志", "一本小说", ...],
      "down" : ["一位总理", "一个景点", ...]
    },
    "words" : {
      "across" : ["行周末", "红楼梦", ...],
      "down" : ["周恩来", "黄鹤楼", ...]
    }
  }