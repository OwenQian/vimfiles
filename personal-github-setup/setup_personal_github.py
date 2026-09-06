#!/usr/bin/env python3
"""Configure a personal GitHub SSH alias and 1Password SSH commit signing."""

import argparse
import os
import subprocess
import sys
from pathlib import Path


DEFAULT_SIGNER = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"


def render_ssh_host_block(host: str, public_key_path: str) -> str:
    return (
        f"Host {host}\n"
        "  HostName github.com\n"
        "  User git\n"
        f"  IdentityFile {public_key_path}\n"
        "  IdentitiesOnly yes\n"
    )


def render_git_signing_config(signing_key: str, signer: str) -> str:
    return (
        "[user]\n"
        f"\tsigningkey = {signing_key}\n\n"
        "[gpg]\n"
        "\tformat = ssh\n\n"
        '[gpg "ssh"]\n'
        f"\tprogram = {signer}\n\n"
        "[commit]\n"
        "\tgpgsign = true\n"
    )


def read_public_key(path: Path) -> str:
    fields = path.read_text().strip().split()
    if len(fields) < 2 or not fields[0].startswith("ssh-"):
        raise ValueError(f"Invalid SSH public key: {path}")
    return " ".join(fields[:2])


def read_env(path: Path) -> dict[str, str]:
    values: dict[str, str] = {}
    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        key, separator, value = line.partition("=")
        if not separator or not key:
            raise ValueError(f"Invalid .env line: {line!r}")
        values[key.strip()] = value.strip().strip('"').strip("'")
    return values


def host_block_exists(config: str, host: str) -> bool:
    return any(line.strip() == f"Host {host}" for line in config.splitlines())


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--env", type=Path, default=Path(__file__).with_name(".env"))
    parser.add_argument("--apply", action="store_true", help="Write configuration; otherwise show the plan.")
    args = parser.parse_args()

    if not args.env.exists():
        print(f"Missing {args.env}. Copy .env.example to .env and fill it in.", file=sys.stderr)
        return 2

    try:
        env = read_env(args.env)
        host = env["PERSONAL_GITHUB_HOST"]
        key_path_text = env.get("PERSONAL_SSH_PUBLIC_KEY_PATH", "~/.ssh/id_personal.pub")
        repos_dir = Path(os.path.expanduser(env.get("PERSONAL_REPOS_DIR", "~/Projects/personal"))).resolve()
        signer = env.get("ONEPASSWORD_SSH_SIGN_PROGRAM", DEFAULT_SIGNER)
    except (KeyError, ValueError) as error:
        print(f"Invalid environment file: {error}", file=sys.stderr)
        return 2

    key_path = Path(os.path.expanduser(key_path_text))
    if not key_path.exists():
        print(f"Public key file not found: {key_path}", file=sys.stderr)
        return 2
    try:
        signing_key = read_public_key(key_path)
    except ValueError as error:
        print(error, file=sys.stderr)
        return 2
    if not Path(signer).exists():
        print(f"1Password SSH signer not found: {signer}", file=sys.stderr)
        return 2

    ssh_config = Path.home() / ".ssh/config"
    current_ssh_config = ssh_config.read_text() if ssh_config.exists() else ""
    ssh_block = render_ssh_host_block(host, key_path_text)
    personal_gitconfig = Path.home() / ".gitconfig-personal"
    git_config = render_git_signing_config(signing_key, signer)
    include_name = f"includeIf.gitdir:{repos_dir}/.path"

    print(f"SSH host: {host} -> github.com")
    print(f"Personal repositories: {repos_dir}")
    print(f"Signing program: {signer}")
    if host_block_exists(current_ssh_config, host):
        print(f"SSH config already has Host {host}; it will not be overwritten.")
    else:
        print(f"Would append Host {host} to {ssh_config}")
    print(f"Would write signing settings to {personal_gitconfig}")
    print(f"Would enable that file for repositories under {repos_dir}")

    if not args.apply:
        print("Dry run only. Re-run with --apply to make these changes.")
        return 0

    if not host_block_exists(current_ssh_config, host):
        ssh_config.parent.mkdir(mode=0o700, exist_ok=True)
        with ssh_config.open("a") as file:
            if current_ssh_config and not current_ssh_config.endswith("\n"):
                file.write("\n")
            file.write("\n" + ssh_block)
    personal_gitconfig.write_text(git_config)
    subprocess.run(
        ["git", "config", "--global", include_name, str(personal_gitconfig)],
        check=True,
    )
    print("Personal GitHub setup applied.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
