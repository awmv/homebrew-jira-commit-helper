class JiraCommitHelper < Formula
  depends_on "fzf"
  depends_on "git"
  desc "Automate Jira ticket number extraction and Git commit message creation"
  homepage "https://github.com/awmv/homebrew-jira-commit-helper"
  url "https://github.com/awmv/homebrew-jira-commit-helper/blob/main/archive/v0.1.tar.gz"
  # sha256 "dafd99d07f532cd5786cbff80e431a308a74a0caacdb09eb6cc98c0a440ceb44"

  def install
    # Install the Bash script into /usr/local/bin
    bin.install "ci.sh"

    # Set the Git alias
    system "git", "config", "--global", "alias.ci", "\"!#{bin}/ci.sh\""
  end

  def uninstall
    # Remove the Bash script from /usr/local/bin
    rm bin/"ci.sh"

    # Unset the Git alias
    system "git", "config", "--global", "--unset", "alias.ci"
  end

  test do
    # Add test logic here if needed
  end
end
