#!/usr/bin/env -S nvim -l
--table.insert(arg, '--filter=#only')
require('busted.runner')({
  standalone = false,
})

