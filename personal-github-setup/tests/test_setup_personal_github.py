import importlib.util
import pathlib
import unittest


SCRIPT = pathlib.Path(__file__).parents[1] / "setup_personal_github.py"
SPEC = importlib.util.spec_from_file_location("setup_personal_github", SCRIPT)
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class SetupPersonalGitHubTests(unittest.TestCase):
    def test_renders_personal_host_for_1password_agent(self):
        block = MODULE.render_ssh_host_block(
            host="github-personal.com",
            public_key_path="~/.ssh/id_personal.pub",
        )

        self.assertEqual(
            block,
            "Host github-personal.com\n"
            "  HostName github.com\n"
            "  User git\n"
            "  IdentityFile ~/.ssh/id_personal.pub\n"
            "  IdentitiesOnly yes\n",
        )

    def test_renders_personal_git_signing_include(self):
        config = MODULE.render_git_signing_config(
            signing_key="ssh-ed25519 test-personal-key",
            signer="/Applications/1Password.app/Contents/MacOS/op-ssh-sign",
        )

        self.assertIn("[user]", config)
        self.assertIn("signingkey = ssh-ed25519 test-personal-key", config)
        self.assertIn("format = ssh", config)
        self.assertIn("program = /Applications/1Password.app/Contents/MacOS/op-ssh-sign", config)
        self.assertIn("gpgsign = true", config)

    def test_reads_public_key_from_the_configured_path(self):
        key_file = pathlib.Path(self.enterContext(__import__("tempfile").TemporaryDirectory())) / "id_personal.pub"
        key_file.write_text("ssh-ed25519 test-personal-key personal@example.com\n")

        self.assertEqual(
            MODULE.read_public_key(key_file),
            "ssh-ed25519 test-personal-key",
        )

if __name__ == "__main__":
    unittest.main()
