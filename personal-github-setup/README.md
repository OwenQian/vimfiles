# Personal GitHub setup

This configures two independent things:

- `github-personal.com` as a local SSH alias for GitHub. The alias uses only
  the personal public key through the 1Password SSH agent.
- SSH commit signing through 1Password for every Git repository under
  `~/Projects/personal`.

## One-time GitHub and 1Password checks

1. In 1Password, enable **Settings → Developer → Use the SSH agent** and make
   the personal SSH key available to the agent.
2. In the personal GitHub account, add the key's public value under **Settings
   → SSH and GPG keys** as both an authentication key and an SSH signing key.
3. Copy `.env.example` to `.env` and confirm that
   `PERSONAL_SSH_PUBLIC_KEY_PATH` points to the personal public-key file. The
   script reads that public value itself; do not put a private key in `.env`.

## Run

Preview first:

```bash
python3 setup_personal_github.py
```

Apply after checking the preview:

```bash
python3 setup_personal_github.py --apply
```

The script does not overwrite an existing `Host github-personal.com` block in
`~/.ssh/config`. It writes `~/.gitconfig-personal` and conditionally includes
it only when Git is operating inside `~/Projects/personal`.

## New personal repositories

Create the repository in the personal GitHub account, then use the alias in
the remote URL:

```bash
git clone git@github-personal.com:OwenQian/REPOSITORY.git
```

For a local repository:

```bash
git remote add origin git@github-personal.com:OwenQian/REPOSITORY.git
```

No per-repository signing command is needed for repositories inside
`~/Projects/personal`. 1Password prompts when Git needs to use the key.
