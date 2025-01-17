# frozen_string_literal: true

shared_context "dip command", runner: true do
  let(:exec_runner) { spy("exec runner") }
  let(:subshell_runner) { spy("subshell runner") }

  before do
    stub_const("Dip::Command::ExecRunner", exec_runner)
    stub_const("Dip::Command::SubshellRunner", subshell_runner)
  end
end

def expected_exec(cmd, argv, options = kind_of(Hash))
  argv = Array(argv) if argv.is_a?(String)
  cmdline = [cmd, *argv].compact.join(" ").strip
  expect(exec_runner).to have_received(:call).with(cmdline, options)
end

def expected_subshell(cmd, argv, options = kind_of(Hash))
  argv = Array(argv) if argv.is_a?(String)
  cmdline = [cmd, *argv].compact.join(" ").strip
  expect(subshell_runner).to have_received(:call).with(cmdline, options)
end
