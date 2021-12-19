local g = vim.g

g.ale_fix_on_save = 0
g.ale_lint_on_save = 1
g.ale_lint_on_text_changed = 0
g.ale_open_list = 0
g.ale_linters_explicit = 1
g.ale_sign_error = '>>'
g.ale_sign_warning = '--'
-- g.ale_sign_error = "◉"
-- g.ale_sign_warning = "◉"
g.ale_set_highlights = 0
g.ale_set_quickfix = 1
g.ale_lint_delay = 0
g.ale_disable_lsp = 1

g.ale_linters = {
  latex = {'chktex', 'lacheck', 'texlab'},
  plaintex = {'chktex', 'lacheck'},
  tex = {'chktex', 'texlab'},
  markdown = {'mdl'},
	help = {},
	python = {'flake8', 'mype', 'pyls', 'pydocstyle', 'bandit', 'pylint'},
	text = {'write-good'},
	yaml = {'yamllint'}
}

