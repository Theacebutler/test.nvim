# test.nvim

A simple plugin to run tests for different filetypes

## Installation

Install the plugin with your preferred package manager:

- Packer

```lua
use {
  "theacebutler/test.nvim",
}
```

- Lazy.nvim

```lua
return {
  "theacebutler/test.nvim",
}
```

## Usage

Run `:Test` to open a new split with the test command for the current filetype.

## TODO

- Add .setup() function to configure the test commands for different filetypes
- Add color to the test results
