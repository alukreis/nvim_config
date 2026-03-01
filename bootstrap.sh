#!/bin/sh

nvim --headless +"lua require('config.bootstrapLazy')()" +q
