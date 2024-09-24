-- https://github.com/Robitx/gp.nvim

return {
  'robitx/gp.nvim',
  config = function()
    local targets = {
      rewrite = 'rewrite',
      append = 'append',
      prepend = 'prepend',
      popup = 'popup',
      vsplit = 'vnew',
      split = 'new',
      tabnew = 'tabnew',
    }

    local custom_prompt = [[
    Keep the answer short and concise.
    ]]

    local conf = {
      chat_confirm_delete = false,
      toggle_target = 'tabnew',
      chat_template = require('gp.defaults').short_chat_template,

      whisper = {
        disable = true,
      },

      image = {
        disable = true,
      },

      hooks = {
        -- New chat with the whole buffer as context
        BufferChatNew = function(gp, _)
          vim.api.nvim_command('%' .. gp.config.cmd_prefix .. 'ChatNew')
        end,

        -- Writes unit test for the selection
        UnitTest = function(gp, params)
          local target = gp.Target[targets[params.args]] or gp.Target.enew

          local filetype_to_framework = {
            python = 'pytest',
          }

          local test_framework = filetype_to_framework[vim.bo.filetype] or 'an appropriate test framework'

          local template = [[I have the following code from {{filename}}:

          ```{{filetype}}
          {{selection}}
          ```

          Write unit tests for the code above.
          Respond exclusively with code.
          If you need to explain something, add code comments.
          Use ]] .. test_framework

          local agent = gp.get_command_agent()
          gp.Prompt(params, target, agent, template)
        end,

        -- Writes docstring for the selection
        DocString = function(gp, params)
          local target = gp.Target[targets[params.args]] or gp.Target.enew
          local response = 'the added docstring, nothing else'

          if target == gp.Target.rewrite then
            response = 'the original code and the added docstring'
          end

          local template = [[I have the following code from {{filename}}:

          ```{{filetype}}
          {{selection}}
          ```

          Write a docstring for the code above.
          Write it in a concise style.
          Try to keep line length to 80 columns.
          Do not change the original code nor comments.
          Respond exclusively with ]] .. response

          local agent = gp.get_command_agent()
          gp.Prompt(params, target, agent, template)
        end,

        -- Toggles the chat and displays it in the given target.
        -- If the chat is alredy toggled it will be diplayed in
        -- new target instead. Calling this function without a
        -- target toggles the chat using the previous target.
        CustomChatToggle = function(gp, params)
          local new_target = #params.args > 0 and params.args ~= gp.config.toggle_target

          if new_target then
            gp.config.toggle_target = params.args
            gp._toggle_close(gp._toggle_kind.chat)
          end

          vim.api.nvim_command(gp.config.cmd_prefix .. 'ChatToggle')
        end,
      },

      agents = {
        {
          name = 'ChatGPT4o',
          chat = true,
          command = false,
          model = { model = 'gpt-4o', temperature = 1.1, top_p = 1 },
          system_prompt = require('gp.defaults').chat_system_prompt .. custom_prompt,
        },
        {
          provider = 'openai',
          name = 'ChatGPT4o-mini',
          chat = true,
          command = false,
          model = { model = 'gpt-4o-mini', temperature = 1.1, top_p = 1 },
          system_prompt = require('gp.defaults').chat_system_prompt .. custom_prompt,
        },
      },
    }

    require('gp').setup(conf)

    local function options(desc)
      return {
        noremap = true,
        silent = true,
        nowait = true,
        desc = desc,
      }
    end

    -- Chat commands
    vim.keymap.set('n', '<C-g>cc', '<cmd>GpChatNew<cr>', options 'New Chat in Current Window')
    vim.keymap.set('n', '<C-g>cs', '<cmd>GpChatNew split<cr>', options 'New Chat in Horizontal Split')
    vim.keymap.set('n', '<C-g>cv', '<cmd>GpChatNew vsplit<cr>', options 'New Chat Vertical Split')
    vim.keymap.set('n', '<C-g>ct', '<cmd>GpChatNew tabnew<cr>', options 'New Chat in Tab')

    vim.keymap.set('n', '<C-g>f', '<cmd>GpChatFinder<cr>', options 'Chat Finder')

    vim.keymap.set('n', '<C-g>tc', '<cmd>GpCustomChatToggle<cr>', options 'Toggle Chat')
    vim.keymap.set('n', '<C-g>tt', '<cmd>GpCustomChatToggle tabnew<cr>', options 'Toggle Chat in Tab')
    vim.keymap.set('n', '<C-g>ts', '<cmd>GpCustomChatToggle split<cr>', options 'Toggle Chat in Horizontal Split')
    vim.keymap.set('n', '<C-g>tv', '<cmd>GpCustomChatToggle vsplit<cr>', options 'Toggle Chat in Vertical Split')

    vim.keymap.set('v', '<C-g>cc', ":<C-u>'<,'>GpChatNew<cr>", options 'New Chat in Current Window')
    vim.keymap.set('v', '<C-g>cs', ":<C-u>'<,'>GpChatNew split<cr>", options 'New Chat in Horizontal Split')
    vim.keymap.set('v', '<C-g>cv', ":<C-u>'<,'>GpChatNew vsplit<cr>", options 'New Chat in Vertical Split')
    vim.keymap.set('v', '<C-g>ct', ":<C-u>'<,'>GpChatNew tabnew<cr>", options 'New Chat in Tab')

    vim.keymap.set('v', '<C-g>p', ":<C-u>'<,'>GpChatPaste<cr>", options 'Paste to Chat')

    vim.keymap.set('v', '<C-g>tc', ":<C-u>'<,'>GpCustomChatToggle<cr>", options 'Toggle Chat')
    vim.keymap.set('v', '<C-g>tt', ":<C-u>'<,'>GpCustomChatToggle tabnew<cr>", options 'Toggle Chat in Tab')
    vim.keymap.set('v', '<C-g>ts', ":<C-u>'<,'>GpCustomChatToggle split<cr>", options 'Toggle Chat in Horizontal Split')
    vim.keymap.set('v', '<C-g>tv', ":<C-u>'<,'>GpCustomChatToggle vsplit<cr>", options 'Toggle Chat in Vertical Split')

    -- Prompt commands
    vim.keymap.set('n', '<C-g>a', '<cmd>GpAppend<cr>', options 'Append (After)')
    vim.keymap.set('n', '<C-g>b', '<cmd>GpPrepend<cr>', options 'Prepend (Before)')

    vim.keymap.set('n', '<C-g>rr', '<cmd>GpRewrite<cr>', options 'Rewrite Line')
    vim.keymap.set('n', '<C-g>rs', '<cmd>GpNew<cr>', options 'Rewrite in Horizontal Split')
    vim.keymap.set('n', '<C-g>rv', '<cmd>GpVnew<cr>', options 'Rewrite in Vertical Split')
    vim.keymap.set('n', '<C-g>rt', '<cmd>GpTabnew<cr>', options 'Rewrite in Tab')

    vim.keymap.set('v', '<C-g>a', ":<C-u>'<,'>GpAppend<cr>", options 'Append (After)')
    vim.keymap.set('v', '<C-g>b', ":<C-u>'<,'>GpPrepend<cr>", options 'Prepend (Before)')

    vim.keymap.set('v', '<C-g>rr', ":<C-u>'<,'>GpRewrite<cr>", options 'Rewrite Selection')
    vim.keymap.set('v', '<C-g>rs', ":<C-u>'<,'>GpNew<cr>", options 'Rewrite in Horizontal Split')
    vim.keymap.set('v', '<C-g>rv', ":<C-u>'<,'>GpVnew<cr>", options 'Rewrite in Vertical Split')
    vim.keymap.set('v', '<C-g>rt', ":<C-u>'<,'>GpTabnew<cr>", options 'Rewrite in Tab')

    vim.keymap.set('v', '<C-g>us', ":<C-u>'<,'>GpUnitTest split<cr>", options 'Write Unit Tests in Horizontal Split')
    vim.keymap.set('v', '<C-g>uv', ":<C-u>'<,'>GpUnitTest vsplit<cr>", options 'Write Unit Tests in Vertical Split')
    vim.keymap.set('v', '<C-g>ut', ":<C-u>'<,'>GpUnitTest tabnew<cr>", options 'Write Unit Tests in Tab')

    vim.keymap.set('v', '<C-g>dr', ":<C-u>'<,'>GpDocString rewrite<cr>", options 'Rewrite Selection with Docstring')
    vim.keymap.set('v', '<C-g>db', ":<C-u>'<,'>GpDocString prepend<cr>", options 'Prepend Selection with Docstring')
    vim.keymap.set('v', '<C-g>ds', ":<C-u>'<,'>GpDocString split<cr>", options 'Write Docstring in Horizonal Split')
    vim.keymap.set('v', '<C-g>dv', ":<C-u>'<,'>GpDocString vsplit<cr>", options 'Write Docstring in Vertical Split')
    vim.keymap.set('v', '<C-g>dt', ":<C-u>'<,'>GpDocString tabnew<cr>", options 'Write Docstring in Tab')

    vim.keymap.set('n', '<C-g>x', '<cmd>GpContext<cr>', options 'Toggle Context')
    vim.keymap.set('v', '<C-g>x', ":<C-u>'<,'>GpContext<cr>", options 'Toggle Context')

    vim.keymap.set({ 'n', 'v', 'x' }, '<C-g>s', '<cmd>GpStop<cr>', options 'Stop')
    vim.keymap.set({ 'n', 'v', 'x' }, '<C-g>n', '<cmd>GpNextAgent<cr>', options 'Next Agent')
  end,
}
