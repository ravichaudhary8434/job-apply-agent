---
name: job-apply-setup
description: >
  One-time onboarding for the job-apply agent. The user pastes their resume
  text (or gives a path to their resume PDF), and this skill extracts it into
  ~/.claude/job-apply-profile.md — the profile the job-apply agent uses to fill
  applications. Use when the user wants to set up or update their job
  application profile, or when the job-apply agent reported that no profile
  exists.
---

# Job Apply Setup

Build or update the applicant profile at `~/.claude/job-apply-profile.md` from the user's resume.

## Steps

1. **Get the resume.**
   - If the user pasted resume text or gave a file path in this conversation, use that.
   - A PDF/DOCX path → Read the file directly (Read handles PDFs). Note the absolute path — it doubles as the upload path.
   - If neither is present, ask the user to paste their resume text or give the path to their resume PDF.

2. **Extract into the template.** Use the template at `templates/job-apply-profile.template.md` in this skill's kit (or reproduce its structure from memory if the kit isn't nearby): identity, contact, links, resume path, summary, experience (newest first with metric-bearing bullets), skills, education, standard form answers, cover-letter guidance.
   - Copy facts faithfully — do not embellish, round up years, or add skills the resume doesn't claim.
   - Anything the resume doesn't state stays `TODO`.

3. **Ask for the gaps in ONE round.** Resumes almost never contain these, and the agent refuses to guess them, so collect them now (AskUserQuestion or plain questions):
   - Phone (if not in resume) and resume PDF absolute path (if they pasted text)
   - Notice period
   - Current / expected compensation (or "prefer not to disclose")
   - Work authorization / visa / sponsorship needs
   - Relocation and remote preferences
   - Which Chrome profile to apply from, if they use several (the Claude in Chrome extension must be installed in it; leave unset to use the currently connected browser)
   Accept "skip" — leave those as TODO and warn that forms needing them will pause.

4. **Write the profile** to `~/.claude/job-apply-profile.md`. If one already exists, show a short diff summary and confirm before overwriting.

5. **Confirm setup.** Tell the user:
   - Profile written; list any remaining TODOs.
   - Usage: paste any job link and say "apply" — the `job-apply` agent fills the application in their Chrome browser and stops before the final Submit for review; adding "auto-submit" skips the review pause.
   - Requirements: Chrome with the Claude in Chrome extension connected, and logged-in sessions for sites like LinkedIn if they'll apply there.
