{
  ...
}: {
  programs.nixvim = {
    enable = true;

    nixpkgs.useGlobalPackages = true;

    colorschemes.rose-pine.enable = true;

    keymaps = [
      {
	mode = "i";
	action = "<Esc>";
	key = "vj";
      }
    ];

    plugins = {
	lualine.enable = true;
	luasnip.enable = true;

	treesitter = {
	  enable = true;
	};

	tiny-inline-diagnostic.enable = true;

	transparent.enable = true;

	cmp = {
	  enable = true;
	  settings = {
	    completion = {
	      completeopt = "menu,menuone,noinsert";
	    };
	    autoEnableSources = true;
	    experimental = { ghost_text = true; };
	    performance = {
	      debounce = 60;
	      fetchingTimeout = 200;
	      maxViewEntries = 30;
	    };
	    snippet = { 
	      expand = ''
		function(args)
		  require('luasnip').lsp_expand(args.body)
		end
	      '';
	    };
	    formatting = { fields = [ "kind" "abbr" "menu" ]; };
	    sources = [
	      { name = "nvim_lsp"; }
	      { name = "emoji"; }
	      {
		name = "buffer"; # text within current buffer
		option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
		keywordLength = 3;
	      }
	      # { name = "copilot"; } # enable/disable copilot
	      {
		name = "path"; # file system paths
		keywordLength = 3;
	      }
	      {
		name = "luasnip"; # snippets
		keywordLength = 3;
	      }
	    ];

	    window = {
	      completion = { border = "solid"; };
	      documentation = { border = "solid"; };
	    };

	    mapping = {
	      "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
	      "<C-j>" = "cmp.mapping.select_next_item()";
	      "<C-k>" = "cmp.mapping.select_prev_item()";
	      "<C-e>" = "cmp.mapping.abort()";
	      "<C-b>" = "cmp.mapping.scroll_docs(-4)";
	      "<C-f>" = "cmp.mapping.scroll_docs(4)";
	      "<C-Space>" = "cmp.mapping.complete()";
	      "<CR>" = "cmp.mapping.confirm({ select = true })";
	      "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
	      "<C-l>" = ''
		cmp.mapping(function()
		  if luasnip.expand_or_locally_jumpable() then
		    luasnip.expand_or_jump()
		  end
		end, { 'i', 's' })
	      '';
	      "<C-h>" = ''
		cmp.mapping(function()
		  if luasnip.locally_jumpable(-1) then
		    luasnip.jump(-1)
		  end
		end, { 'i', 's' })
	      '';
	    };
	  };
	};
	cmp-nvim-lsp = {
	  enable = true; # LSP
	};
	cmp-buffer = {
	  enable = true;
	};
	cmp-path = {
	  enable = true; # file system paths
	};
	cmp_luasnip = {
	  enable = true; # snippets
	};
	cmp-cmdline = {
	  enable = true; # autocomplete for cmdline
	}; 	

	lsp = {
	  enable = true;

	  keymaps = {
	    lspBuf = {
	      gd = "definition";
	      gD = "references";
	      gt = "type_definition";
	      gi = "implementation";
	      re = "rename";
	    };
	  };

	  servers = {
	    nixd.enable = true;
	    rust_analyzer = {
	      enable = true;
	      installCargo = true;
	      installRustc = true;
	    };
	    basedpyright.enable = true;
	  };
	};
    };

    diagnostic.settings = {
      update_in_insert = true;
      severity_sort = true;
      float = {
	border = "rounded";
      };
      jump = {
	severity.__raw = "vim.diagnostic.severity.WARN";
      };
    };

    clipboard = {
      # Use system clipboard
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };

    opts = {
	number = true;
	relativenumber = true;
	shiftwidth = 2;

	scrolloff = 10;
	cursorline = true;
    };
  };
}
