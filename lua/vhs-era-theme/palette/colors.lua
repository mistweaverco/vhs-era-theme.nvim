local colorparser = require("vhs-era-theme.lib.colorparser")
local hsl = require("vhs-era-theme.lib.hsl.type")
local shade = require("vhs-era-theme.lib.shade")
local config = require("vhs-era-theme").config

local t = {
  bg = hsl("#161616"),
  bgFloat = hsl("#131313"),
  fg = hsl("#f2f4f8"),
  cursor = hsl("#ffffff"),

  -- Syntax colors
  keyword = hsl("#78a9ff"), -- base09
  comment = hsl("#525252"), -- base03 (adjusted)
  punctuation = hsl("#3ddbd9"), -- base08
  method = hsl("#ff7eb6"), -- base12
  type = hsl("#78a9ff"), -- base09
  string = hsl("#be95ff"), -- base14
  number = hsl("#82cfff"), -- base15
  constant = hsl("#42be65"), -- base13
  tag = hsl("#3ddbd9"), -- base08
  attribute = hsl("#08bdba"), -- base07
  property = hsl("#33b1ff"), -- base11
  parameter = hsl("#ee5396"), -- base10
  label = hsl("#08bdba"), -- base07

  -- Workspace colors
  primary = hsl("#78a9ff"), -- base09
  selection = hsl("#353535"),
  search = hsl("#484848"),
  diffAdd = hsl("#42be65"), -- base13
  diffChange = hsl("#78a9ff"), -- base09
  diffDelete = hsl("#ee5396"), -- base10
  added = hsl("#42be65"), -- base13
  changed = hsl("#78a9ff"), -- base09
  deleted = hsl("#ee5396"), -- base10

  diffText = hsl("#78a9ff").lighten(15),
  error = hsl("#ff7eb6"), -- base12 (adjusted for error)
  errorBG = hsl("#3d2932"),
  warning = hsl("#be95ff"), -- base14
  warningBG = hsl("#332e40"),
  info = hsl("#78a9ff"), -- base09
  infoBG = hsl("#1f2d3d"),
  hint = hsl("#82cfff"), -- base15
  mergeCurrent = hsl("#2d3139"),
  mergeCurrentLabel = hsl("#3d414d"),
  mergeIncoming = hsl("#1d2d3d"),
  mergeIncomingLabel = hsl("#2d3d4d"),
  mergeParent = hsl("#2d2539"),
  mergeParentLabel = hsl("#3d354d"),

  -- Inline diff highlighting
  diffInline = hsl("#42be65"),
}

-- Generate shades for backgrounds and UI
t.shade1 = shade(t.bg, 1)
t.shade2 = shade(t.bg, 2)
t.shade3 = shade(t.bg, 3)
t.shade4 = shade(t.bg, 4)
t.shade5 = shade(t.bg, 5)
t.shade6 = shade(t.bg, 6)
t.shade7 = shade(t.bg, 7)
t.shade8 = shade(t.bg, 8)
t.shade9 = shade(t.bg, 9)
t.shade10 = shade(t.bg, 10)
t.shade20 = shade(t.bg, 20)
t.shade25 = shade(t.bg, 25)
t.shade30 = shade(t.bg, 30)
t.shade40 = shade(t.bg, 40)
t.shade50 = shade(t.bg, 50)
t.shade60 = shade(t.bg, 60)
t.shade70 = shade(t.bg, 70)
t.shade80 = shade(t.bg, 80)
t.shade90 = shade(t.bg, 90)

-- Grey scale with primary color tint
t.grey3 = t.shade3.mix(t.primary, 3)
t.grey5 = t.shade5.mix(t.primary, 5)
t.grey7 = t.shade7.mix(t.primary, 7)
t.grey10 = t.shade10.mix(t.primary, 10)
t.grey20 = t.shade20.mix(t.primary, 10)
t.grey25 = t.shade25.mix(t.primary, 10)
t.grey30 = t.shade30.mix(t.primary, 10)
t.grey40 = t.shade40.mix(t.primary, 12)

t.white = hsl("#ffffff")
t.green = hsl("#42be65")

local colors = {}

-- Normal text
colors["Normal"] = { fg = t.fg, bg = t.bg }

-- Cursor and visual
colors["CursorLine"] = { bg = t.grey7 }
colors["CursorColumn"] = colors["CursorLine"]
colors["Whitespace"] = { fg = t.grey10 }

-- Comments
colors["Comment"] = { fg = t.comment, italic = config.italic_comments }

-- Line numbers
colors["LineNr"] = { fg = t.comment }
colors["CursorLineNr"] = { fg = t.comment }

-- Search
colors["Search"] = { bg = t.search }
colors["IncSearch"] = { bg = t.cursor.mix(t.bg, 10), fg = t.bg }
colors["CurSearch"] = colors["Search"]

-- Floating windows
colors["NormalFloat"] = { bg = t.bgFloat, blend = 5 }
colors["FloatBorder"] = { fg = t.punctuation }
colors["NormalSB"] = { bg = t.bgFloat }

-- UI Elements
colors["ColorColumn"] = { bg = t.grey5 }
colors["Conceal"] = {}
colors["Cursor"] = { bg = t.cursor, fg = t.bg }
colors["lCursor"] = colors["Cursor"]
colors["CursorIM"] = colors["Cursor"]
colors["Directory"] = { fg = t.keyword }

-- Diffs
colors["DiffAdd"] = { bg = t.diffAdd.mix(t.bg, 12), fg = t.bg.darken(25) }
colors["DiffChange"] = { bg = t.diffChange.mix(t.bg, 12), fg = t.bg.darken(25) }
colors["DiffDelete"] = { bg = t.diffDelete.mix(t.bg, 12), fg = t.bg.darken(25) }
colors["DiffText"] = { bg = t.diffInline.mix(t.bg, 15), fg = t.bg.darken(30) }

-- Misc UI
colors["EndOfBuffer"] = { fg = t.punctuation }
colors["TermCursor"] = colors["Cursor"]
colors["TermCursorNC"] = {}
colors["ErrorMsg"] = { fg = t.error }
colors["VertSplit"] = { fg = t.grey30 }
colors["Winseparator"] = colors["VertSplit"]
colors["Folded"] = { bg = t.shade7, fg = t.tag }
colors["SignColumn"] = colors["Normal"]
colors["FoldColumn"] = colors["SignColumn"]
colors["Substitute"] = colors["IncSearch"]
colors["MatchParen"] = { bg = t.punctuation, fg = t.bg }
colors["ModeMsg"] = colors["Normal"]
colors["MsgArea"] = colors["Normal"]
colors["MoreMsg"] = { fg = t.primary }
colors["NonText"] = { fg = t.shade30 }
colors["NormalNC"] = colors["Normal"]

-- Popup menu
colors["Pmenu"] = colors["NormalFloat"]
colors["PmenuSel"] = { bg = t.selection }
colors["PmenuSbar"] = { bg = t.grey5 }
colors["PmenuThumb"] = { bg = t.shade20 }

colors["Question"] = { fg = t.primary }
colors["QuickFixLine"] = { bg = t.primary, fg = t.white }
colors["SpecialKey"] = { fg = t.attribute }

-- Status line
colors["StatusLine"] = { bg = t.grey10, gui = "" }
colors["StatusLineNC"] = { bg = t.shade5 }

-- Tab line
colors["TabLine"] = { bg = t.shade3, fg = t.shade30 }
colors["TabLineFill"] = { bg = t.bg }
colors["TabLineSel"] = { bg = t.shade10, sp = t.primary, gui = "underline" }

colors["Title"] = { fg = t.primary }
colors["Visual"] = { bg = t.selection }
colors["VisualNOS"] = { bg = t.selection }
colors["WarningMsg"] = { fg = t.warning }
colors["WildMenu"] = { bg = t.selection }

-- Syntax groups
colors["Constant"] = { fg = t.constant }
colors["String"] = { fg = t.string }
colors["Character"] = { fg = t.attribute }
colors["Number"] = { fg = t.number }
colors["Boolean"] = { fg = t.keyword }
colors["Identifier"] = { fg = t.fg }
colors["Function"] = { fg = t.method }
colors["Method"] = { fg = t.method }
colors["Property"] = { fg = t.property }
colors["Field"] = colors["Property"]
colors["Parameter"] = { fg = t.parameter }
colors["Statement"] = { fg = t.keyword }
colors["Punctuation"] = { fg = t.punctuation }
colors["Operator"] = { fg = t.punctuation }
colors["Keyword"] = colors["Statement"]
colors["PreProc"] = { fg = t.keyword }
colors["Type"] = { fg = t.type }
colors["Struct"] = colors["Type"]
colors["Class"] = colors["Type"]
colors["Special"] = colors["Character"]
colors["Attribute"] = colors["Character"]
colors["Tag"] = { fg = t.tag }
colors["Underlined"] = { gui = "underline" }
colors["Bold"] = { gui = "bold" }
colors["Italic"] = { gui = "italic" }
colors["Ignore"] = { fg = t.bg }
colors["Error"] = colors["ErrorMsg"]
colors["Todo"] = { bg = t.info, fg = t.white }
colors["WinBar"] = { fg = t.tag, gui = "bold" }
colors["WinBarNC"] = { fg = t.fg, gui = "" }

-- Diagnostics
colors["DiagnosticError"] = colors["Error"]
colors["DiagnosticWarn"] = colors["WarningMsg"]
colors["DiagnosticInfo"] = { fg = t.info }
colors["DiagnosticHint"] = { fg = t.hint }
colors["DiagnosticVirtualTextError"] = { colors["DiagnosticError"], bg = t.bg.mix(t.error, 20) }
colors["DiagnosticVirtualTextWarn"] = { colors["DiagnosticWarn"], bg = t.bg.mix(t.warning, 20) }
colors["DiagnosticVirtualTextInfo"] = { colors["DiagnosticInfo"], bg = t.bg.mix(t.info, 20) }
colors["DiagnosticVirtualTextHint"] = { colors["DiagnosticHint"], bg = t.bg.mix(t.hint, 20) }
colors["DiagnosticUnderlineError"] = { gui = "undercurl", sp = t.error }
colors["DiagnosticUnderlineWarn"] = { gui = "undercurl", sp = t.warning }
colors["DiagnosticUnderlineInfo"] = { gui = "undercurl", sp = t.info }
colors["DiagnosticUnderlineHint"] = { gui = "undercurl", sp = t.hint }

-- Treesitter
colors["@constructor"] = { fg = t.type }
colors["@punctuation"] = { fg = t.punctuation }
colors["@punctuation.bracket"] = { fg = t.punctuation }
colors["@punctuation.delimiter"] = { fg = t.punctuation }
colors["@punctuation.special"] = { fg = t.punctuation }
colors["@symbol"] = { fg = t.constant }
colors["@constant"] = { fg = t.constant }
colors["@constant.builtin"] = { fg = t.keyword }
colors["@string.escape"] = colors["Character"]
colors["@method"] = { fg = t.method }
colors["@function"] = { fg = t.method }
colors["@function.call"] = { fg = t.method }
colors["@function.builtin"] = { fg = t.method }
colors["@parameter"] = { fg = t.parameter }
colors["@field"] = colors["Property"]
colors["@property"] = colors["Property"]
colors["@label"] = { fg = t.label }
colors["@type"] = colors["Type"]
colors["@type.builtin"] = { fg = t.keyword }
colors["@type.qualifier"] = colors["Statement"]
colors["@keyword"] = colors["Statement"]
colors["@keyword.modifier"] = colors["Statement"]
colors["@namespace"] = colors["Type"]
colors["@annotation"] = colors["@label"]
colors["@text"] = colors["Identifier"]
colors["@text.strong"] = colors["Bold"]
colors["@text.italic"] = colors["Italic"]
colors["@text.underline"] = colors["Underlined"]
colors["@text.title"] = { fg = t.keyword }
colors["@text.literal"] = colors["Property"]
colors["@text.uri"] = { fg = t.tag, sp = t.tag, gui = "underline" }
colors["@variable"] = colors["Identifier"]
colors["@variable.builtin"] = colors["Statement"]
colors["@tag"] = colors["Tag"]
colors["@attribute"] = { fg = t.label }
colors["@tag.attribute"] = { fg = t.attribute }
colors["@error"] = colors["Error"]
colors["@warning"] = colors["WarningMsg"]
colors["@info"] = { fg = t.info }

-- Treesitter standard capture groups update
colors["@variable.parameter"] = colors["@parameter"]
colors["@variable.member"] = colors["@field"]
colors["@module"] = colors["@namespace"]
colors["@string.special.symbol"] = colors["@symbol"]
colors["@markup.strong"] = colors["@text.strong"]
colors["@markup.underline"] = colors["@text.underline"]
colors["@markup.heading"] = colors["@text.title"]
colors["@markup.link.url"] = colors["@text.uri"]
colors["@markup.raw"] = colors["@text.literal"]
colors["@markup.list"] = colors["@punctuation.special"]

-- Helix capture groups
colors["@function.method"] = colors["@method"]
colors["@string.special.url"] = colors["@text.uri"]

-- LSP Semantic highlighting
colors["@lsp.type.namespace"] = colors["@namespace"]
colors["@lsp.type.type"] = colors["@type"]
colors["@lsp.type.class"] = colors["@type"]
colors["@lsp.type.enum"] = colors["@type"]
colors["@lsp.type.interface"] = colors["@type"]
colors["@lsp.type.struct"] = colors["@type"]
colors["@lsp.type.parameter"] = colors["@parameter"]
colors["@lsp.type.variable"] = colors["@variable"]
colors["@lsp.type.property"] = colors["@property"]
colors["@lsp.type.enumMember"] = colors["@constant"]
colors["@lsp.type.function"] = colors["@function"]
colors["@lsp.type.method"] = colors["@method"]
colors["@lsp.type.macro"] = colors["@label"]
colors["@lsp.type.decorator"] = colors["@label"]
colors["@lsp.mod.readonly"] = colors["@constant"]
colors["@lsp.typemod.function.declaration"] = colors["@function"]
colors["@lsp.typemod.function.readonly"] = colors["@function"]

-- GitSigns
colors["GitSignsAdd"] = { fg = t.added }
colors["GitSignsChange"] = { fg = t.changed }
colors["GitSignsDelete"] = { fg = t.deleted }
colors["GitSignsAddNr"] = { fg = t.added }
colors["GitSignsChangeNr"] = { fg = t.changed }
colors["GitSignsDeleteNr"] = { fg = t.deleted }
colors["GitSignsAddLn"] = { bg = t.added.mix(t.bg, 15) }
colors["GitSignsChangeLn"] = { bg = t.changed.mix(t.bg, 15) }
colors["GitSignsDeleteLn"] = { bg = t.deleted.mix(t.bg, 15) }

-- Git related
colors["GitGutterAdd"] = { fg = t.added, bg = t.added.mix(t.bg, 15) }
colors["GitGutterChange"] = { fg = t.changed, bg = t.changed.mix(t.bg, 15) }
colors["GitGutterDelete"] = { fg = t.deleted, bg = t.deleted.mix(t.bg, 15) }
colors["GitGutterChangeDelete"] = { fg = t.number, bg = t.number.mix(t.bg, 15) }
colors["GitBlame"] = { fg = t.comment, bg = t.comment.mix(t.bg, 10) }
colors["GitBlameLine"] = { fg = t.fg, bg = t.grey7 }

-- Bufferline/BarBar
colors["BufferlineFill"] = colors["NormalFloat"]
colors["BufferCurrent"] = colors["Normal"]
colors["BufferCurrentIndex"] = colors["BufferCurrent"]
colors["BufferCurrentIcon"] = colors["BufferCurrentIndex"]
colors["BufferCurrentMod"] = colors["BufferCurrent"]
colors["BufferCurrentSign"] = { fg = t.keyword, bg = colors["BufferCurrent"].bg }
colors["BufferCurrentTarget"] = { colors["BufferCurrent"], fg = t.type }
colors["BufferCurrentWARN"] = { fg = colors["DiagnosticWarn"].fg, bg = colors["BufferCurrent"].bg }
colors["BufferCurrentINFO"] = { fg = colors["DiagnosticInfo"].fg, bg = colors["BufferCurrent"].bg }
colors["BufferCurrentERROR"] = { fg = colors["DiagnosticError"].fg, bg = colors["BufferCurrent"].bg }
colors["BufferCurrentHINT"] = { fg = colors["DiagnosticHint"].fg, bg = colors["BufferCurrent"].bg }

colors["BufferInactive"] = { fg = t.shade40, bg = t.bgFloat }
colors["BufferInactiveIcon"] = colors["BufferInactive"]
colors["BufferInactiveIndex"] = colors["BufferInactive"]
colors["BufferInactiveMod"] = colors["BufferInactive"]
colors["BufferInactiveSign"] = colors["BufferInactive"]
colors["BufferInactiveTarget"] = { colors["BufferInactive"], fg = t.type }
colors["BufferInactiveWARN"] = { colors["BufferCurrentWARN"], bg = colors["BufferInactive"].bg }
colors["BufferInactiveINFO"] = { colors["BufferCurrentINFO"], bg = colors["BufferInactive"].bg }
colors["BufferInactiveERROR"] = { colors["BufferCurrentERROR"], bg = colors["BufferInactive"].bg }
colors["BufferInactiveHINT"] = { colors["BufferCurrentHINT"], bg = colors["BufferInactive"].bg }

colors["BufferVisible"] = { colors["BufferCurrent"], bg = t.bgFloat }
colors["BufferVisibleIndex"] = colors["BufferVisible"]
colors["BufferVisibleIcon"] = colors["BufferVisibleIndex"]
colors["BufferVisibleMod"] = colors["BufferVisible"]
colors["BufferVisibleSign"] = colors["BufferVisible"]
colors["BufferVisibleTarget"] = { colors["BufferVisible"], fg = t.type }
colors["BufferVisibleWARN"] = colors["BufferInactiveWARN"]
colors["BufferVisibleINFO"] = colors["BufferInactiveINFO"]
colors["BufferVisibleERROR"] = colors["BufferInactiveERROR"]
colors["BufferVisibleHINT"] = colors["BufferInactiveHINT"]

colors["BufferAlternate"] = colors["BufferInactive"]
colors["BufferAlternateIndex"] = colors["BufferAlternate"]
colors["BufferAlternateIcon"] = colors["BufferAlternateIndex"]
colors["BufferAlternateMod"] = colors["BufferInactiveMod"]
colors["BufferAlternateSign"] = { colors["BufferInactiveSign"], fg = t.constant }
colors["BufferAlternateTarget"] = { colors["BufferAlternate"], fg = t.type }
colors["BufferAlternateWARN"] = colors["BufferInactiveWARN"]
colors["BufferAlternateINFO"] = colors["BufferInactiveINFO"]
colors["BufferAlternateERROR"] = colors["BufferInactiveERROR"]
colors["BufferAlternateHINT"] = colors["BufferInactiveHINT"]

colors["BufferTabpages"] = { colors["BufferInactive"], fg = t.fg }
colors["BufferTabpageFill"] = { colors["BufferTabpages"], fg = t.bg }
colors["BufferOffset"] = colors["BufferTabpageFill"]

-- Telescope
colors["TelescopeMultiSelection"] = { fg = t.attribute }
colors["TelescopeMultiIcon"] = { fg = t.primary }
colors["TelescopeNormal"] = colors["NormalFloat"]
colors["TelescopeBorder"] = { colors["NormalFloat"], fg = t.punctuation }
colors["TelescopeMatching"] = { fg = t.keyword }
colors["TelescopePromptPrefix"] = { fg = t.punctuation }
colors["TelescopePreviewLink"] = { fg = t.label }
colors["TelescopePreviewSocket"] = { fg = t.property }
colors["TelescopePreviewWrite"] = { fg = t.type }
colors["TelescopePreviewExecute"] = { fg = t.method }
colors["TelescopePreviewSize"] = { fg = t.number }
colors["TelescopePreviewUser"] = { fg = t.property }
colors["TelescopePreviewGroup"] = { fg = t.property }
colors["TelescopePreviewDate"] = { fg = t.string }
colors["TelescopeResultsClass"] = colors["Class"]
colors["TelescopeResultsField"] = colors["Field"]
colors["TelescopeResultsVariable"] = colors["Identifier"]
colors["TelescopeResultsSpecialComment"] = colors["Comment"]

-- LSP Saga
colors["TitleIcon"] = colors["Function"]
colors["SagaNormal"] = colors["NormalFloat"]
colors["SagaExpand"] = colors["Normal"]
colors["SagaCollapse"] = colors["SagaExpand"]
colors["SagaCount"] = colors["Number"]
colors["SagaBeacon"] = { bg = t.cursor, blend = 70 }
colors["CodeActionNumber"] = colors["Statement"]
colors["FinderSelection"] = colors["Visual"]
colors["FinderCount"] = colors["Number"]
colors["FinderIcon"] = colors["Punctuation"]
colors["FinderType"] = colors["Title"]
colors["SagaLightBulb"] = colors["Attribute"]
colors["OutlineIndent"] = colors["Whitespace"]
colors["SagaWinbarFile"] = { fg = t.fg }
colors["SagaWinbarSnippet"] = { fg = t.label }
colors["SagaWinbarKey"] = colors["Property"]
colors["SagaWinbarValue"] = colors["String"]
colors["SagaWinbarEnum"] = colors["Type"]
colors["SagaWinbarClass"] = colors["Type"]
colors["SagaWinbarFolder"] = colors["Tag"]
colors["SagaWinbarEnumMember"] = colors["Property"]
colors["SagaWinbarNull"] = colors["Statement"]
colors["SagaWinbarFilename"] = colors["SagaWinbarFile"]
colors["SagaWinbarFolderName"] = {}
colors["SagaWinbarFileIcon"] = {}
colors["SagaWinbarSep"] = { fg = t.punctuation }

-- Trouble
colors["TroubleCount"] = { fg = t.number }
colors["TroubleNormal"] = { bg = t.bgFloat }
colors["TroubleLocation"] = { fg = t.attribute }
colors["TroubleText"] = {}

-- Cmp
colors["CmpDocumentation"] = { fg = t.fg, bg = t.bgFloat }
colors["CmpDocumentationBorder"] = { fg = t.punctuation, bg = t.bgFloat }
colors["CmpItemAbbr"] = { fg = t.fg }
colors["CmpItemAbbrDeprecated"] = { fg = t.fg, gui = "strikethrough" }
colors["CmpItemAbbrMatch"] = { fg = t.primary }
colors["CmpItemAbbrMatchFuzzy"] = { fg = t.primary }
colors["CmpItemMenu"] = { fg = t.attribute }
colors["CmpItemKindText"] = { fg = t.comment }
colors["CmpItemKindDefault"] = { fg = t.fg }
colors["CmpItemKindKeyword"] = { fg = t.keyword }
colors["CmpItemKindVariable"] = { fg = t.fg }
colors["CmpItemKindConstant"] = { fg = t.constant }
colors["CmpItemKindReference"] = { fg = t.fg }
colors["CmpItemKindValue"] = { fg = t.fg }
colors["CmpItemKindFunction"] = { fg = t.method }
colors["CmpItemKindMethod"] = { fg = t.method }
colors["CmpItemKindConstructor"] = { fg = t.type }
colors["CmpItemKindClass"] = { fg = t.type }
colors["CmpItemKindInterface"] = { fg = t.type }
colors["CmpItemKindStruct"] = { fg = t.type }
colors["CmpItemKindEvent"] = { fg = t.label }
colors["CmpItemKindEnum"] = { fg = t.type }
colors["CmpItemKindUnit"] = { fg = t.number }
colors["CmpItemKindModule"] = { fg = t.keyword }
colors["CmpItemKindProperty"] = { fg = t.property }
colors["CmpItemKindField"] = { fg = t.property }
colors["CmpItemKindTypeParameter"] = { fg = t.type }
colors["CmpItemKindEnumMember"] = { fg = t.type }
colors["CmpItemKindOperator"] = { fg = t.punctuation }
colors["CmpItemKindSnippet"] = { fg = t.label }

-- Blink Cmp
colors["BlinkCmpDoc"] = { fg = t.fg, bg = t.bgFloat }
colors["BlinkCmpDocBorder"] = { fg = t.punctuation, bg = t.bgFloat }
colors["BlinkCmpLabel"] = { fg = t.fg }
colors["BlinkCmpLabelDeprecated"] = { fg = t.fg, gui = "strikethrough" }
colors["BlinkCmpLabelMatch"] = { fg = t.primary }
colors["BlinkCmpLabelDetail"] = { fg = t.attribute }
colors["BlinkCmpLabelDescription"] = { fg = t.attribute }
colors["BlinkCmpSource"] = { fg = t.attribute }
colors["BlinkCmpKindText"] = { fg = t.comment }
colors["BlinkCmpKindDefault"] = { fg = t.fg }
colors["BlinkCmpKindKeyword"] = { fg = t.keyword }
colors["BlinkCmpKindVariable"] = { fg = t.fg }
colors["BlinkCmpKindConstant"] = { fg = t.constant }
colors["BlinkCmpKindReference"] = { fg = t.fg }
colors["BlinkCmpKindValue"] = { fg = t.fg }
colors["BlinkCmpKindFunction"] = { fg = t.method }
colors["BlinkCmpKindMethod"] = { fg = t.method }
colors["BlinkCmpKindConstructor"] = { fg = t.type }
colors["BlinkCmpKindClass"] = { fg = t.type }
colors["BlinkCmpKindInterface"] = { fg = t.type }
colors["BlinkCmpKindStruct"] = { fg = t.type }
colors["BlinkCmpKindEvent"] = { fg = t.label }
colors["BlinkCmpKindEnum"] = { fg = t.type }
colors["BlinkCmpKindUnit"] = { fg = t.number }
colors["BlinkCmpKindModule"] = { fg = t.keyword }
colors["BlinkCmpKindProperty"] = { fg = t.property }
colors["BlinkCmpKindField"] = { fg = t.property }
colors["BlinkCmpKindTypeParameter"] = { fg = t.type }
colors["BlinkCmpKindEnumMember"] = { fg = t.type }
colors["BlinkCmpKindOperator"] = { fg = t.punctuation }
colors["BlinkCmpKindSnippet"] = { fg = t.label }
colors["BlinkCmpMenuBorder"] = { fg = t.primary, bg = t.bg }

-- Illuminate
colors["IlluminatedWordText"] = { bg = t.grey7 }
colors["IlluminatedWordRead"] = { bg = t.grey7 }
colors["IlluminatedWordWrite"] = { bg = t.grey7 }

-- Cursor word
colors["CursorWord"] = { bg = t.grey7 }
colors["CursorWord0"] = { bg = t.grey7 }
colors["CursorWord1"] = { bg = t.grey7 }

-- Mason
colors["MasonNormal"] = colors["NormalFloat"]
colors["MasonHeader"] = { bg = t.primary, fg = t.bg }
colors["MasonHeaderSecondary"] = { bg = t.constant, fg = t.bg }
colors["MasonHighlight"] = { fg = t.primary }
colors["MasonHighlightBlock"] = { bg = t.primary, fg = t.bg }
colors["MasonHighlightBlockBold"] = { bg = t.primary, fg = t.bg, gui = "bold" }
colors["MasonHighlightSecondary"] = { fg = t.constant }
colors["MasonHighlightBlockSecondary"] = { bg = t.constant, fg = t.bg }
colors["MasonHighlightBlockBoldSecondary"] = { bg = t.constant, fg = t.bg, gui = "bold" }
colors["MasonLink"] = colors["@text.uri"]
colors["MasonMuted"] = { fg = t.shade50 }
colors["MasonMutedBlock"] = { bg = t.shade40, fg = t.bg }
colors["MasonMutedBlockBold"] = { bg = t.shade40, fg = t.bg, gui = "bold" }
colors["MasonError"] = colors["Error"]
colors["MasonHeading"] = { gui = "bold,underline", fg = t.fg }

-- Neogit
colors["NeogitHunkHeader"] = { bg = t.bg, fg = t.added }
colors["NeogitDiffContext"] = { bg = t.bg, fg = t.fg }
colors["NeogitDiffAdd"] = { bg = t.added.mix(t.bg, 8), fg = t.bg.darken(25) }
colors["NeogitDiffDelete"] = { bg = t.deleted.mix(t.bg, 8), fg = t.bg.darken(25) }
colors["NeogitDiffHeader"] = { bg = t.bg, fg = t.added }
colors["NeogitActiveItem"] = { bg = t.primary.mix(t.bg, 20), fg = t.bg.darken(10) }
colors["NeogitHunkHeaderHighlight"] = { bg = t.added.mix(t.bg, 10), fg = t.bg.darken(15) }
colors["NeogitDiffContextHighlight"] = { bg = t.grey7, fg = t.fg }
colors["NeogitDiffAddHighlight"] = { bg = t.added.mix(t.bg, 12), fg = t.bg.darken(30) }
colors["NeogitDiffDeleteHighlight"] = { bg = t.deleted.mix(t.bg, 12), fg = t.bg.darken(30) }
colors["NeogitDiffHeaderHighlight"] = { bg = t.added.mix(t.bg, 10), fg = t.bg.darken(15) }
colors["NeogitDiffAddInline"] = { bg = t.diffInline.mix(t.bg, 15), fg = t.bg.darken(30) }
colors["NeogitDiffDeleteInline"] = { bg = t.deleted.mix(t.bg, 15), fg = t.bg.darken(30) }

-- Which-key
colors["WhichKey"] = colors["Character"]
colors["WhichKeyGroup"] = colors["Tag"]
colors["WhichKeySeparator"] = colors["Operator"]
colors["WhichKeyDesc"] = colors["@text.title"]

-- Diffview
colors["DiffviewStatusAdded"] = { fg = t.added, bg = t.added.mix(t.bg, 15) }
colors["DiffviewStatusModified"] = { fg = t.changed, bg = t.changed.mix(t.bg, 15) }
colors["DiffviewStatusRenamed"] = { fg = t.changed, bg = t.changed.mix(t.bg, 15) }
colors["DiffviewStatusCopied"] = { fg = t.changed, bg = t.changed.mix(t.bg, 15) }
colors["DiffviewStatusTypeChanged"] = { fg = t.changed, bg = t.changed.mix(t.bg, 15) }
colors["DiffviewStatusUnmerged"] = { fg = t.number, bg = t.number.mix(t.bg, 15) }
colors["DiffviewStatusUnknown"] = { fg = t.property, bg = t.property.mix(t.bg, 15) }
colors["DiffviewStatusDeleted"] = { fg = t.deleted, bg = t.deleted.mix(t.bg, 15) }
colors["DiffviewStatusIgnored"] = { fg = t.comment, bg = t.comment.mix(t.bg, 15) }
colors["DiffviewFilePanelInsertions"] = { fg = t.added, bg = t.added.mix(t.bg, 10) }
colors["DiffviewFilePanelDeletions"] = { fg = t.deleted, bg = t.deleted.mix(t.bg, 10) }
colors["DiffviewFilePanelRootPath"] = { fg = t.tag, bg = t.tag.mix(t.bg, 10) }
colors["DiffviewFilePanelTitle"] = { fg = t.constant, bg = t.constant.mix(t.bg, 10) }
colors["DiffviewFilePanelCounter"] = { fg = t.attribute, bg = t.attribute.mix(t.bg, 10) }
colors["DiffviewFilePanelPath"] = { fg = t.comment, bg = t.comment.mix(t.bg, 10) }
colors["DiffviewFilePanelConflicts"] = { fg = t.number, bg = t.number.mix(t.bg, 10) }
colors["DiffviewFolderName"] = colors["Directory"]
colors["DiffviewPrimary"] = { fg = t.keyword, bg = t.keyword.mix(t.bg, 10) }
colors["DiffviewSecondary"] = { fg = t.tag, bg = t.tag.mix(t.bg, 10) }
colors["DiffviewDiffAdd"] = { bg = t.diffInline.mix(t.bg, 15), fg = t.bg.darken(30) }
colors["DiffviewDiffDelete"] = { bg = t.deleted.mix(t.bg, 15), fg = t.bg.darken(30) }

-- vim-fugitive
colors["diffAdded"] = { fg = t.added, bg = t.diffInline.mix(t.bg, 15) }
colors["diffRemoved"] = { fg = t.deleted, bg = t.deleted.mix(t.bg, 15) }

-- nvim-tree
colors["NvimTreeNormal"] = { bg = t.bgFloat }
colors["NvimTreeNormalNC"] = { bg = t.bgFloat }
colors["NvimTreeWindowPicker"] = { fg = t.fg, bg = t.selection, gui = "bold" }
colors["NvimTreeIndentMarker"] = { fg = t.punctuation }
colors["NvimTreeRootFolder"] = { fg = t.tag }
colors["NvimTreeFolderIcon"] = { fg = t.keyword }
colors["NvimTreeFolderName"] = { fg = t.tag }
colors["NvimTreeOpenedFolderName"] = { fg = t.keyword }
colors["NvimTreeSpecialFile"] = { fg = t.constant }
colors["NvimTreeExecFile"] = { fg = t.method }
colors["NvimTreeGitStaged"] = { fg = t.method }
colors["NvimTreeGitDirty"] = { fg = t.type }
colors["NvimTreeGitMerge"] = { fg = t.number }
colors["NvimTreeGitDeleted"] = { fg = t.deleted }
colors["NvimTreeGitNew"] = { fg = t.method }

-- git-conflict
colors["GitConflictCurrent"] = { bg = t.mergeCurrent, blend = 5 }
colors["GitConflictIncoming"] = { bg = t.mergeIncoming, blend = 5 }
colors["GitConflictAncestor"] = { bg = t.mergeParent, blend = 5 }
colors["GitConflictCurrentLabel"] = { bg = t.mergeCurrentLabel, blend = 5 }
colors["GitConflictIncomingLabel"] = { bg = t.mergeIncomingLabel, blend = 5 }
colors["GitConflictAncestorLabel"] = { bg = t.mergeParentLabel, blend = 5 }

-- Notify
colors["NotifyBackground"] = colors["NormalFloat"]
colors["NotifyERRORBorder"] = { colors["Normal"], fg = t.error }
colors["NotifyWARNBorder"] = { colors["Normal"], fg = t.warning }
colors["NotifyINFOBorder"] = { colors["Normal"], fg = t.info }
colors["NotifyDEBUGBorder"] = { colors["Normal"], fg = t.punctuation }
colors["NotifyTRACEBorder"] = { colors["Normal"], fg = t.property }
colors["NotifyERRORIcon"] = colors["NotifyERRORBorder"]
colors["NotifyWARNIcon"] = colors["NotifyWARNBorder"]
colors["NotifyINFOIcon"] = colors["NotifyINFOBorder"]
colors["NotifyDEBUGIcon"] = colors["NotifyDEBUGBorder"]
colors["NotifyTRACEIcon"] = colors["NotifyTRACEBorder"]
colors["NotifyERRORTitle"] = colors["NotifyERRORBorder"]
colors["NotifyWARNTitle"] = colors["NotifyWARNBorder"]
colors["NotifyINFOTitle"] = colors["NotifyINFOBorder"]
colors["NotifyDEBUGTitle"] = colors["NotifyDEBUGBorder"]
colors["NotifyTRACETitle"] = colors["NotifyTRACEBorder"]

-- hlargs (semantic parameter highlighting)
colors["Hlargs"] = colors["@parameter"]

-- virt-column
colors["VirtColumn"] = colors["Whitespace"]

-- mini.indentscope
colors["MiniIndentScopeSymbol"] = colors["Whitespace"]
colors["MiniIndentScopeSymbolOff"] = colors["DiagnosticWarn"]

-- Neotest
colors["NeotestPassed"] = { fg = t.added }
colors["NeotestRunning"] = colors["DiagnosticInfo"]
colors["NeotestSkipped"] = colors["DiagnosticWarn"]
colors["NeotestFailed"] = colors["DiagnosticError"]
colors["NeotestAdapterName"] = {}
colors["NeotestBorder"] = {}
colors["NeotestDir"] = colors["Directory"]
colors["NeotestExpandMarker"] = {}
colors["NeotestFile"] = { fg = t.tag }
colors["NeotestFocused"] = {}
colors["NeotestIndent"] = {}
colors["NeotestMarked"] = {}
colors["NeotestNamespace"] = {}
colors["NeotestWinSelect"] = {}
colors["NeotestTarget"] = {}
colors["NeotestTest"] = {}
colors["NeotestUnknown"] = {}
colors["NeotestWatching"] = { fg = t.constant }

-- Language specific highlights
-- JavaScript
colors["javaScript"] = colors["Identifier"]
colors["javaScriptIdentifier"] = colors["Statement"]
colors["javaScriptFunction"] = colors["Statement"]
colors["javaScriptParens"] = colors["Punctuation"]
colors["javaScriptBraces"] = colors["Punctuation"]
colors["javaScriptNumber"] = colors["Number"]

-- TypeScript
colors["typeScriptImport"] = colors["Statement"]
colors["typeScriptExport"] = colors["Statement"]
colors["typeScriptIdentifier"] = colors["Statement"]
colors["typescriptVariable"] = colors["Statement"]
colors["typeScriptFunction"] = colors["Statement"]
colors["typescriptPredefinedType"] = colors["@type.builtin"]
colors["typescriptClassStatic"] = colors["Statement"]
colors["typescriptNodeGlobal"] = colors["Statement"]
colors["typescriptExceptions"] = colors["Statement"]
colors["typeScriptParens"] = colors["Punctuation"]
colors["typeScriptBraces"] = colors["Punctuation"]
colors["typescriptTypeBrackets"] = colors["Punctuation"]
colors["typescriptInterfaceTypeParameter"] = colors["Punctuation"]
colors["typescriptConditionalType"] = colors["Punctuation"]
colors["typeScriptNumber"] = colors["Number"]
colors["typeScriptAliasDeclaration"] = colors["Type"]
colors["typeScriptTypeReference"] = colors["Type"]
colors["typeScriptTypeParameter"] = colors["Type"]
colors["typescriptClassName"] = colors["Type"]
colors["typescriptClassHeritage"] = colors["Type"]
colors["typescriptProp"] = colors["Property"]
colors["typescriptOperator"] = colors["Operator"]
colors["typescriptBinaryOp"] = colors["Operator"]
colors["typescriptDocNotation"] = { fg = t.shade50 }
colors["typescriptDocTags"] = colors["typescriptDocNotation"]

-- JSON
colors["jsonKeyword"] = colors["Property"]
colors["jsonQuote"] = colors["String"]
colors["jsonBraces"] = colors["Punctuation"]

-- HTML
colors["htmlTagName"] = colors["Tag"]
colors["htmlSpecialTagName"] = colors["Tag"]
colors["htmlTag"] = colors["htmlTagName"]
colors["htmlEndTag"] = colors["htmlTagName"]
colors["htmlTagN"] = colors["htmlTagName"]
colors["htmlArg"] = colors["Special"]
colors["htmlSpecialChar"] = colors["Constant"]

-- XML
colors["xmlTag"] = colors["Tag"]
colors["xmlProcessing"] = colors["Tag"]
colors["xmlProcessingDelim"] = colors["Tag"]
colors["xmlDoctypeDecl"] = colors["Tag"]
colors["xmlTagName"] = colors["Tag"]
colors["xmlDoctype"] = colors["Statement"]
colors["xmlAttrib"] = colors["Attribute"]
colors["xmlEqual"] = colors["Punctuation"]
colors["xmlEntityPunct"] = colors["Punctuation"]
colors["xmlEntity"] = colors["Constant"]
colors["xmlCdataStart"] = colors["@label"]

-- CSS
colors["cssProp"] = colors["Property"]
colors["cssBraces"] = colors["Punctuation"]
colors["cssNoise"] = colors["Punctuation"]
colors["cssSelectorOp"] = colors["Punctuation"]
colors["cssSelectorOp2"] = colors["Punctuation"]
colors["cssAttrComma"] = colors["Punctuation"]
colors["cssClassNameDot"] = colors["Punctuation"]
colors["cssFunctionComma"] = colors["Punctuation"]
colors["cssClassName"] = colors["Special"]
colors["cssIdentifier"] = colors["Type"]
colors["cssImportant"] = colors["Statement"]
colors["cssTagName"] = colors["Tag"]
colors["cssUrl"] = { colors["String"], gui = "underline" }
colors["cssUnitDecorators"] = colors["Constant"]

-- Rust
colors["rustModPathSep"] = colors["Punctuation"]
colors["rustFoldBraces"] = colors["Punctuation"]
colors["rustBoxPlacementBalance"] = colors["Punctuation"]
colors["rustSigil"] = colors["Punctuation"]
colors["rustStorage"] = colors["Statement"]

-- Ruby
colors["rubyConstant"] = colors["Constant"]
colors["rubyCurlyBlockDelimiter"] = colors["Punctuation"]
colors["rubyInterpolation"] = colors["Punctuation"]
colors["rubyInterpolationDelimiter"] = colors["Punctuation"]
colors["rubyStringDelimiter"] = colors["String"]
colors["rubyKeywordAsMethod"] = colors["Function"]

-- Python
colors["pythonDecorator"] = colors["@annotation"]
colors["pythonDecoratorName"] = colors["@annotation"]
colors["pythonAttribute"] = colors["Property"]
colors["pythonBuiltin"] = colors["@type.builtin"]

-- YAML
colors["yamlBlockMappingKey"] = colors["Property"]
colors["yamlKeyValueDelimiter"] = colors["Punctuation"]
colors["yamlNodeTag"] = colors["Statement"]

-- flash.nvim
colors["FlashBackdrop"] = { fg = t.fg, bg = t.bg }
colors["FlashMatch"] = { fg = t.selection, bg = t.grey40 }
colors["FlashCurrent"] = { fg = t.fg, bg = t.bg }
colors["FlashLabel"] = { fg = t.primary, bg = t.bg }
colors["FlashPrompt"] = { fg = t.fg, bg = t.bg }
colors["FlashCursor"] = { fg = t.fg, bg = t.bg }

colorparser.parse(colors)

return colors
