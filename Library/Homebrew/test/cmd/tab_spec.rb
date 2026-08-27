# typed: true
# frozen_string_literal: true

require "cmd/tab"
require "cmd/shared_examples/args_parse"
require "tab"

RSpec.describe Homebrew::Cmd::TabCmd do
  def installed_on_request?(formula)
    # `brew` subprocesses can change the tab, invalidating the cached values.
    Tab.clear_cache
    Tab.for_formula(formula).installed_on_request
  end

  def cask_installed_on_request?(cask)
    # `brew` subprocesses can change the tab, invalidating the cached values.
    Cask::Tab.clear_cache
    cask.tab.installed_on_request
  end

  it_behaves_like "parseable arguments"

  it "marks a Formula and Cask as installed on request", :cask, :integration_test do
    setup_test_formula "foo",
                       tab_attributes: { "installed_on_request" => false }
    foo = Formula["foo"]

    expect { brew "tab", "--installed-on-request", "foo" }
      .to be_a_success
      .and output(/foo is now marked as installed on request/).to_stdout
      .and not_to_output.to_stderr
    expect(installed_on_request?(foo)).to be true

    cask = Cask::CaskLoader.load(cask_path("local-caffeine"))
    InstallHelper.install_with_caskfile(cask)
    tab_path = cask.metadata_main_container_path/AbstractTab::FILENAME

    expect(tab_path).not_to exist

    expect { brew "tab", "--installed-on-request", "--cask", cask.token }
      .to output(/local-caffeine is now marked as installed on request/).to_stdout
      .and not_to_output.to_stderr
      .and be_a_success
    expect(tab_path).to exist
    expect(cask_installed_on_request?(cask)).to be true

    tab_path.delete
    Cask::Tab.clear_cache

    expect { brew "tab", "--no-installed-on-request", "--cask", cask.token }
      .to output(/local-caffeine is already marked as not installed on request/).to_stdout
      .and not_to_output.to_stderr
      .and be_a_success
    expect(tab_path).to exist
    expect(cask_installed_on_request?(cask)).to be false
  end
end
