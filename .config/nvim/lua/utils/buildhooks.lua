local pack_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/"

vim.api.nvim_create_autocmd("PackChanged", {
	pattern = "*",
	callback = function(args)
		if args.data.spec.name == "telescope-fzf-native.nvim" then
			local plugin_path = pack_path .. args.data.spec.name
			local make_cmd = "make"

			vim.fn.jobstart(make_cmd, {
				cwd = plugin_path,
				on_exit = function(_, exit_code)
					if exit_code == 0 then
						vim.notify("telescope-fzf-native built successfully", vim.log.levels.INFO)
					else
						vim.notify("telescope-fzf-native build failed", vim.log.levels.ERROR)
					end
				end,
			})
		end
	end,
})
