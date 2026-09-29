return {
	"AlexandrosAlexiou/kotlin.nvim",
	ft = { "kotlin" },
	config = function()
		local kotlin = require("kotlin")
		require("custom.kotlin").isolate_concurrent_workspaces(kotlin)

		kotlin.setup({
			-- Optional: Specify a custom Java path to run the server
			jre_path = nil,
			jdk_for_symbol_resolution = os.getenv("JAVA_HOME_21"),
			-- Optional: Specify additional JVM arguments
			jvm_args = {
				"-Xmx16g",
			},
		})
	end,
}
