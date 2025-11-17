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

ls.add_snippets('blade', {
  -- @if block
  s('if', {
    t '@if(',
    i(1, 'condition'),
    t { ')', '\t' },
    i(2),
    c(3, {
      t { '', '' },
      sn(nil, {
        t { '', '@elseif(' },
        i(1, 'condition'),
        t { ')', '\t' },
        i(2),
      }),
      sn(nil, {
        t { '', '@else', '\t' },
        i(1),
      }),
      sn(nil, {
        t { '', '@elseif(' },
        i(1, 'condition'),
        t { ')', '\t' },
        i(2),
        t { '', '@else', '\t' },
        i(3),
      }),
    }),
    t { '', '@endif', '' },
    i(0),
  }),

  -- @foreach loop
  s('foreach', {
    t '@foreach(',
    i(1, '$items'),
    t ' as ',
    i(2, '$item'),
    t { ')', '\t' },
    i(3),
    t { '', '@endforeach', '' },
    i(0),
  }),

  -- @for loop
  s('for', {
    t '@for(',
    i(1, '$i = 0'),
    t '; ',
    i(2, '$i < 10'),
    t '; ',
    i(3, '$i++'),
    t { ')', '\t' },
    i(4),
    t { '', '@endfor', '' },
    i(0),
  }),

  -- @while loop
  s('while', {
    t '@while(',
    i(1, 'condition'),
    t { ')', '\t' },
    i(2),
    t { '', '@endwhile', '' },
    i(0),
  }),

  -- @forelse loop
  s('forelse', {
    t '@forelse(',
    i(1, '$items'),
    t ' as ',
    i(2, '$item'),
    t { ')', '\t' },
    i(3),
    t { '', '@empty', '\t' },
    i(4, 'No items found'),
    t { '', '@endforelse', '' },
    i(0),
  }),

  -- @php block
  s('php', {
    t '@php',
    t { '', '\t' },
    i(1),
    t { '', '@endphp', '' },
    i(0),
  }),

  -- @isset
  s('isset', {
    t '@isset(',
    i(1, '$variable'),
    t { ')', '\t' },
    i(2),
    t { '', '@endisset', '' },
    i(0),
  }),

  -- @empty
  s('empty', {
    t '@empty(',
    i(1, '$variable'),
    t { ')', '\t' },
    i(2),
    t { '', '@endempty', '' },
    i(0),
  }),

  -- @switch
  s('switch', {
    t '@switch(',
    i(1, '$variable'),
    t ')',
    t { '', '\t@case(' },
    i(2, 'value'),
    t { ')', '\t\t' },
    i(3),
    t { '', '\t\t@break', '\t@default', '\t\t' },
    i(4),
    t { '', '@endswitch', '' },
    i(0),
  }),

  -- @include
  s('include', {
    t '@include(',
    i(1, 'view.name'),
    c(2, {
      t '',
      sn(nil, {
        t ', [',
        i(1, 'key'),
        t ' => ',
        i(2, 'value'),
        t ']',
      }),
    }),
    t ')',
    i(0),
  }),

  -- @extends
  s('extends', {
    t '@extends(',
    i(1, 'layouts.app'),
    t ')',
    i(0),
  }),

  -- @section
  s('section', {
    t '@section(',
    i(1, 'content'),
    t { ')', '\t' },
    i(2),
    t { '', '@endsection', '' },
    i(0),
  }),

  -- @yield
  s('yield', {
    t '@yield(',
    i(1, 'content'),
    c(2, {
      t '',
      sn(nil, {
        t ', ',
        i(1, 'default'),
      }),
    }),
    t ')',
    i(0),
  }),

  -- @push
  s('push', {
    t '@push(',
    i(1, 'scripts'),
    t { ')', '\t' },
    i(2),
    t { '', '@endpush', '' },
    i(0),
  }),

  -- @stack
  s('stack', {
    t '@stack(',
    i(1, 'scripts'),
    t ')',
    i(0),
  }),

  -- @csrf
  s('csrf', {
    t '@csrf',
    i(0),
  }),

  -- @error
  s('error', {
    t '@error(',
    i(1, 'field'),
    t { ')', '\t' },
    i(2, '{{ $message }}'),
    t { '', '@enderror', '' },
    i(0),
  }),

  -- @once
  s('once', {
    t '@once',
    t { '', '\t' },
    i(1),
    t { '', '@endonce', '' },
    i(0),
  }),

  -- @props (Blade components)
  s('props', {
    t '@props([',
    i(1, 'key'),
    t ' => ',
    i(2, 'default'),
    t '])',
    i(0),
  }),

  -- {{ }} - Echo escaped
  s('{{', {
    t '{{ ',
    i(1),
    t ' }}',
    i(0),
  }),

  -- {!! !!} - Echo unescaped
  s('{!', {
    t '{!! ',
    i(1),
    t ' !!}',
    i(0),
  }),

  -- @{{ }} - Verbatim (for Vue/Alpine)
  s('@{{', {
    t '@{{ ',
    i(1),
    t ' }}',
    i(0),
  }),

  -- @verbatim
  s('verbatim', {
    t '@verbatim',
    t { '', '\t' },
    i(1),
    t { '', '@endverbatim', '' },
    i(0),
  }),

  -- @json
  s('json', {
    t '@json(',
    i(1, '$data'),
    c(2, {
      t '',
      sn(nil, {
        t ', ',
        i(1, 'JSON_PRETTY_PRINT'),
      }),
    }),
    t ')',
    i(0),
  }),

  -- @dump
  s('dump', {
    t '@dump(',
    i(1, '$variable'),
    t ')',
    i(0),
  }),

  -- @dd
  s('dd', {
    t '@dd(',
    i(1, '$variable'),
    t ')',
    i(0),
  }),

  -- @component
  s('component', {
    t '@component(',
    i(1, 'components.alert'),
    c(2, {
      t '',
      sn(nil, {
        t ', [',
        i(1, 'key'),
        t ' => ',
        i(2, 'value'),
        t ']',
      }),
    }),
    t { ')', '\t' },
    i(3),
    t { '', '@endcomponent', '' },
    i(0),
  }),

  -- @slot
  s('slot', {
    t '@slot(',
    i(1, 'name'),
    c(2, {
      t '',
      sn(nil, {
        t ', [',
        i(1, 'key'),
        t ' => ',
        i(2, 'value'),
        t ']',
      }),
    }),
    t { ')', '\t' },
    i(3),
    t { '', '@endslot', '' },
    i(0),
  }),

  -- @class
  s('class', {
    t '@class([',
    i(1, 'base-class'),
    t ' => true, ',
    i(2, 'conditional-class'),
    t ' => ',
    i(3, '$condition'),
    t '])',
    i(0),
  }),

  -- @style
  s('style', {
    t '@style([',
    i(1, 'color: red'),
    t ' => ',
    i(2, '$condition'),
    t '])',
    i(0),
  }),

  -- @selected
  s('selected', {
    t '@selected(',
    i(1, 'condition'),
    t ')',
    i(0),
  }),

  -- @checked
  s('checked', {
    t '@checked(',
    i(1, 'condition'),
    t ')',
    i(0),
  }),

  -- @disabled
  s('disabled', {
    t '@disabled(',
    i(1, 'condition'),
    t ')',
    i(0),
  }),

  -- @readonly
  s('readonly', {
    t '@readonly(',
    i(1, 'condition'),
    t ')',
    i(0),
  }),

  -- @required
  s('required', {
    t '@required(',
    i(1, 'condition'),
    t ')',
    i(0),
  }),
})
