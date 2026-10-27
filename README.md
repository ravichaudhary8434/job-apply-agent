# job-apply-agent

A Claude Code agent that applies to a job from a link: it reads the posting, fills the form in your
own Chrome browser from a profile file you control, uploads your resume, and stops before the final
Submit so you can review (add "auto-submit" to skip the pause).

| Path | What |
|---|---|
| `agents/job-apply.md` | The browser-driven application agent (needs Claude in Chrome) |
| `skills/job-apply-setup/` | One-time onboarding: paste your resume, it builds `~/.claude/job-apply-profile.md` |
| `skills/chrome-token-discipline/` | How to drive Chrome cheaply: text over screenshots, bulk fills, call caps, tab hygiene |
| `link.sh` | Symlinks the skills and agent into `~/.claude` |

## Setup
1. Install [Claude Code](https://claude.com/claude-code) and the Claude in Chrome extension.
2. `git clone <this repo> ~/job-apply-agent && ~/job-apply-agent/link.sh`
3. In Claude Code run `/job-apply-setup` and paste your resume. Answer the few gap questions.
4. Paste a job link and say "apply".

## Safety
The agent never invents facts (anything missing from your profile is asked, not guessed), never
creates accounts or types passwords, and stops at CAPTCHAs and OTPs. Review what it filled before
you submit, especially at first.
