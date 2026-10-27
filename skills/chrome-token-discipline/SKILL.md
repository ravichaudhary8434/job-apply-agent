---
name: chrome-token-discipline
description: Rules for driving Claude in Chrome cheaply and safely - text over screenshots, bulk JS fills, call caps, one browser agent at a time, tab hygiene. Read before any browser automation task (applications, LinkedIn, WhatsApp, form filling, page extraction).
---

# Claude in Chrome: token-efficient technique

Every tool call re-sends the whole conversation, and a screenshot adds ~1,500 tokens that stay in
context for the rest of the run. Click-by-click automation with screenshots burns through usage limits
fast. Everything below exists to stop that. Follow it in every session and every browser agent.

## Start of a run
- Use the Claude in Chrome MCP tools (`mcp__claude-in-chrome__*`).
- If the browser tools are missing, say so; do not work around it.
- Load the tools in ONE ToolSearch call (comma-separated `select:`), never one call per tool.
- Several Chrome profiles may be connected: `list_connected_browsers`, then `select_browser` the one
  the user's profile file names (match on deviceId, not display name, since names swap on reconnect).
  If it is ambiguous, stop and ask; never pick silently.
- Call `tabs_context_mcp` first. Open work in a NEW tab; never hijack the user's tabs.

## Cheapest route first
- API before browser: ATS feeds, job-board apply endpoints and similar JSON endpoints beat any page automation.
- Read as text, not pixels: `get_page_text` once per page, `find` / `read_page` (interactive filter) to
  locate fields. Screenshot only when text cannot tell you, on the final review page, or when stuck:
  at most ~5 per task. Verify custom widgets with `find`, not a screenshot.
- Bulk, not click-by-click: map all fields once, fill via ONE `javascript_tool` (set values + dispatch
  `input`/`change`) or several `form_input` inside one `browser_batch`. Chain click, wait, read in one
  `browser_batch`. Use `computer` clicks only for widgets that refuse the bulk fill.

## Call caps
- Applications / form filling: ~40 tool calls. At the cap stop, leave the tab, report
  `blocked: call budget`. After 2-3 failed tries on one element, stop and report.
- Feed / page extraction (scrolling lists): no call cap, because respawning re-pays startup context and
  loses page state. Instead do scroll + wait + collect inside ONE `javascript_tool` call, keep a
  `window.__seen` set, return only new items, and cap output to a few hundred characters per item.
- Only ONE browser agent at a time: they share one Chrome and fight over tabs and profile.

## Isolation and hygiene
- Put bulk browser work (many applications, WhatsApp/LinkedIn sends) in a subagent so screenshots and
  page text never land in the main context. Subagent reports stay under ~25 lines.
- Close every tab you opened when done. Only a form blocked on the user (upload, OTP, final submit)
  stays open; say so in the report.
- Fresh session per task from a handoff note; compact early; no polling loops.

## Sending messages (WhatsApp / LinkedIn / email)
- Test once on a number or account the user names, wait for their OK, then send in batches with gaps.
- Stop on any warning or captcha. Never print phone numbers in chat.
- Never send in the user's name without their OK on the text.

## Forms
- Fill every field unless explicitly marked optional. A "Website" field gets the user's portfolio URL
  from their profile file.
- Never create accounts, use Google sign-in, type passwords, or bypass CAPTCHAs.
- A fact not in the profile file: stop and ask; never guess.
