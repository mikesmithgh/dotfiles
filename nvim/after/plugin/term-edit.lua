local status, termedit = pcall(require, "term-edit")
if not status then
  print('bye')
  return
end
print('hi')
termedit.setup {
    prompt_end = {'%$ ', '%$', '$' },
    -- Setting this true will enable printing debug information with print()
    debug = false,

    -- Number of event loops it takes for <Left>, <Right> or <BS> keys to change
    -- the cursor's position.
    -- If term-edit.nvim is unreliable, increasing this value could help.
    -- Decreasing this value can increase the responsiveness of term-edit.nvim
    feedkeys_delay = 10,

    -- Use case 1: I want to press 'o' instead of 'i' to enter insert.
    --   `mapping = { n --[[normal mode]] = { i = 'o' } }`
    --   `vim.keymap.set('n', 'o', 'i', { remap = true })` will achieve the same
    --   thing. (won't work without remap = true)
    -- Use case 2: I want to map 'c' to 'd' and 'd' to 'c'
    --   (keymap with remap is no longer an option)
    --   `mapping = { n = { c = 'd', d = 'c' } }` (will also map 'cc' to 'dd'
    --   and 'dd' to 'cc')
    -- Use case 3: I already mapped s to something else and do not want
    --   term-edit.nvim to override my mapping.
    --   `mapping = { n = { s = false } }`
    --
    -- For more examples and detailed explaination, see :h term-edit.mapping
    mapping = {
        -- mode = {
        --     lhs = new_lhs
        -- }
    },

    -- Used to detect the start of the command
    -- prompt_end = no default, this is mandatory
}
