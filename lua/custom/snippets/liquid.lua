local ls = require 'luasnip'
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require('luasnip.extras').lambda
local rep = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local types = require 'luasnip.util.types'
local conds = require 'luasnip.extras.conditions'
local conds_expand = require 'luasnip.extras.conditions.expand'

ls.add_snippets('liquid', {
  -- render
  s('render', {
    t "{% render '",
    i(1),
    t "'",
    c(2, {
      t '',
      sn(nil, {
        t ', ',
        i(1),
        t ': ',
        i(2),
      }),
    }),
    t ' %}',
    i(0),
  }),

  -- if block
  s('if', {
    t '{% if ',
    i(1),
    t { ' %}', '\t' },
    i(2),
    c(3, {
      t { '', '' },
      sn(nil, {
        t { '', '{% elsif ' },
        i(1),
        t { ' %}', '\t' },
        i(2),
        t { '', '{% else %}', '\t' },
        i(3),
        t { '', '' },
      }),
    }),
    t { '{% endif %}', '' },
    i(0),
  }),

  -- inline if block
  s('iff', {
    t '{%- if ',
    i(1),
    t ' -%} ',
    i(2),
    t ' {%- endif -%}',
    i(0),
  }),

  -- For loop over array
  s('for', {
    t '{% for ',
    i(1),
    t ' in ',
    i(2),
    t { ' %}', '\t' },
    i(3),
    t { '', '{% endfor %}', '' },
    i(0),
  }),

  -- Comment block
  s('cc', {
    t '{% comment %}',
    t { '', '\t' },
    i(1),
    t { '', '{% endcomment %}', '' },
    i(0),
  }),

  -- Assign variable
  s('assign', {
    t '{% assign ',
    i(1),
    t ' = ',
    i(2),
    t { ' %}', '' },
    i(0),
  }),

  -- Capture block
  s('capture', {
    t '{% capture ',
    i(1),
    t ' %}',
    t { '', '\t' },
    i(2),
    t { '', '{% endcapture %}', '' },
    i(0),
  }),

  -- Unless block
  s('unless', {
    t '{% unless ',
    i(1),
    t { ' %}', '\t' },
    i(2),
    t { '', '{% endunless %}', '' },
    i(0),
  }),

  -- Case/when block
  s('case', {
    t '{% case ',
    i(1),
    t ' %}',
    t { '', '\t{% when ' },
    i(2),
    t ' %}',
    t { '', '\t\t' },
    i(3),
    t { '', '{% endcase %}', '' },
    i(0),
  }),

  -- img tag
  s('imgg', {
    t '<img src="{{ \'',
    i(1),
    t '\' | asset_url }}" alt="',
    i(2),
    t '" class="h-full w-full object-cover object-center">',
    i(0),
  }),
})
