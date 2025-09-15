local fmt = string.format

return {
  strategy = "chat",
  description = "Generate a commit message prefixed with ticket from branch name",
  opts = {
    index = 10,
    is_default = true,
    is_slash_cmd = true,
    short_name = "bcommit",
    auto_submit = true,
  },
  prompts = {
    {
      role = "user",
      content = function()
        local branch = vim.fn.system("git symbolic-ref --short HEAD")
        return fmt(
          [[
            You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me.
              Also follow these rules:
            if branch name started with some ticket prefix like ABC-XXX use it in a commit message as a prefix
              If branch name starts with a ticket prefix like ABC-XXX, use it in the commit message as a prefix.
            Branch name: GMS-1234-some-stuff
            Commit message: GMS-1234 <generated commit message>

            Branch name: ABC-12345-other-stuff
            Commit message: ABC-12345 <generated commit message>

            If there is no ticket in branch name use just a commit message without a ticket prefix or any other prefix like feature, fix, etc.
              If there is no ticket in the branch name, use just a commit message without a ticket prefix or any other prefix like feature, fix, etc.
            Branch name: some-stuff
            Commit message: <generated commit message>
            ```diff
            %s,
            ```
            %s
          ]],
          vim.fn.system("git diff --no-ext-diff --staged"),
          branch and "Branch name: " .. branch or ""
        )
      end,
      opts = {
        contains_code = true,
      },
    },
  },
}
