# Content Synchronization Audit Report
**Date:** November 10, 2025
**Repository:** rudzainy.github.io
**Task:** Pre-Jekyll Migration Content Audit

---

## Executive Summary

✅ **Audit Status:** COMPLETE
⚠️ **Action Required:** YES - 36 files need content synchronization

### Key Findings

| Category | Count | Details |
|----------|-------|---------|
| **Total Posts** | 79 | Balance: 42, Life: 16, Work: 21 |
| **Identical Files** | 10 | HTML and Markdown match perfectly |
| **Minor Differences** | 33 | <10% difference (likely formatting) |
| **Major Differences** | 36 | ≥10% difference (content updates needed) |
| **Missing Markdown** | 1 | `work/2025-09-11-website-logs.html` |

---

## Detailed Analysis

### Files with Major Differences (≥10% Content Mismatch)

These files have significant content in HTML that is missing from markdown:

#### Balance Category (20 files)
1. `balance/2003-08-28-family.html` - 14.72%
2. `balance/2009-08-24-tm-parody-ad.html` - 24.02%
3. `balance/2013-09-25-jantan.html` - 15.57%
4. `balance/2015-09-25-hearts.html` - 18.15%
5. `balance/2016-05-19-browsercrush-clone.html` - 23.31%
6. `balance/2016-07-23-teng-quora-k-a-quora-clone.html` - **93.33%** ⚠️ CRITICAL
7. `balance/2017-07-09-self-improvement.html` - 15.38%
8. `balance/2019-04-24-orang-kasar.html` - **64.71%** ⚠️ HIGH
9. `balance/2019-09-19-life.html` - 29.75%
10. `balance/2019-12-30-teater-neon.html` - 41.11%
11. `balance/2020-02-24-melihat.html` - 26.96%
12. `balance/2020-07-11-thoughts-explosion.html` - **84.11%** ⚠️ CRITICAL
13. `balance/2020-09-01-not-the-stage-manager-for-sudirmania.html` - 30.7%
14. `balance/2023-11-02-16-384.html` - **71.11%** ⚠️ HIGH
15. `balance/2024-01-22-rails-7-dropdown-image.html` - 18.0%
16. `balance/2024-03-16-setup-python-3-on-macos.html` - 13.27%
17. `balance/2024-03-16-tutorial-generate-qr-for-wifi.html` - 10.43%
18. `balance/2024-03-27-why-rigid-corporate-structure-is-bad-for-me.html` - 16.0%
19. `balance/2024-04-07-uiux-design-for-agriculture.html` - 18.86%
20. `balance/2024-06-16-an-answer-to-the-question-of-windows-vs-macos.html` - 11.83%

#### Life Category (8 files)
1. `life/2017-05-02-baloons-over-bagan.html` - **84.11%** ⚠️ CRITICAL
2. `life/2019-06-08-railway-market.html` - **83.96%** ⚠️ CRITICAL
3. `life/2021-01-03-kenapa-rudzainy-buat-hoojah.html` - **58.36%** ⚠️ HIGH
4. `life/2022-03-19-happyness-unlocked.html` - **100%** ⚠️⚠️ CRITICAL
5. `life/2022-09-15-maya.html` - **100%** ⚠️⚠️ CRITICAL
6. `life/2024-01-03-of-books.html` - **79.41%** ⚠️ CRITICAL
7. `life/2024-01-03-of-video-games.html` - 12.14%
8. `life/2024-06-20-of-operating-systems.html` - 15.32%

#### Work Category (8 files)
1. `work/2010-09-01-marliyati-froz-logo.html` - 16.04%
2. `work/2017-09-01-next-academy-learning-portal.html` - 11.07%
3. `work/2019-09-01-dxc-bionix-central.html` - 38.63%
4. `work/2019-09-01-dxc-bionix-design-system.html` - **99.48%** ⚠️⚠️ CRITICAL
5. `work/2020-09-01-the-hoojah-project.html` - **99.42%** ⚠️⚠️ CRITICAL
6. `work/2022-09-01-flip-down-numbers-and-characters.html` - 10.93%
7. `work/2023-05-18-slide-to-select.html` - 23.03%
8. `work/2025-09-11-day-food-catalogue.html` - **98.61%** ⚠️⚠️ CRITICAL

### Critical Priority Files (>80% difference)

These files have MASSIVE content differences and should be reviewed FIRST:

1. ⚠️⚠️ `life/2022-03-19-happyness-unlocked.html` - **100%**
2. ⚠️⚠️ `life/2022-09-15-maya.html` - **100%**
3. ⚠️⚠️ `work/2019-09-01-dxc-bionix-design-system.html` - **99.48%**
4. ⚠️⚠️ `work/2020-09-01-the-hoojah-project.html` - **99.42%**
5. ⚠️⚠️ `work/2025-09-11-day-food-catalogue.html` - **98.61%**
6. ⚠️ `balance/2016-07-23-teng-quora-k-a-quora-clone.html` - **93.33%**
7. ⚠️ `balance/2020-07-11-thoughts-explosion.html` - **84.11%**
8. ⚠️ `life/2017-05-02-baloons-over-bagan.html` - **84.11%**
9. ⚠️ `life/2019-06-08-railway-market.html` - **83.96%**
10. ⚠️ `life/2024-01-03-of-books.html` - **79.41%**

---

## Tools & Resources Created

### 1. Content Comparison Script
**File:** `compare_content.rb`
**Purpose:** Automated detection of content differences
**Usage:** `ruby compare_content.rb`

**Features:**
- Compares HTML and markdown content
- Calculates difference percentages
- Color-coded output (identical/minor/major)
- UTF-8 encoding support

### 2. HTML Content Extractor
**File:** `extract_html_to_md.rb`
**Purpose:** Extracts HTML article content for review
**Usage:** `ruby extract_html_to_md.rb`

**Output:** `html_content_review/` directory with:
- `*_extracted.html` - Raw article content from HTML
- `*_comparison.txt` - Side-by-side comparison with markdown

### 3. Review Directory Structure
```
html_content_review/
├── balance/      (20 files × 2 = 40 files)
├── life/         (8 files × 2 = 16 files)
└── work/         (8 files × 2 = 16 files)
Total: 72 review files for 36 posts
```

### 4. Audit Reports
- `content_audit_report.txt` - Full comparison results
- `CONTENT_SYNC_REPORT.md` - This document

---

## Action Plan

### Phase 1: Critical Files (Priority 1) - Estimated 2-3 hours

Review and sync the 10 files with >80% difference:

**Process for each file:**
1. Open `html_content_review/{category}/{filename}_comparison.txt`
2. Compare HTML content vs markdown content
3. Open the HTML file in browser to see rendered version
4. Manually update the markdown file with missing content
5. Preserve existing frontmatter, update if needed
6. Test markdown renders correctly

**Files:**
- [ ] `life/2022-03-19-happyness-unlocked.md`
- [ ] `life/2022-09-15-maya.md`
- [ ] `work/2019-09-01-dxc-bionix-design-system.md`
- [ ] `work/2020-09-01-the-hoojah-project.md`
- [ ] `work/2025-09-11-day-food-catalogue.md`
- [ ] `balance/2016-07-23-teng-quora-k-a-quora-clone.md`
- [ ] `balance/2020-07-11-thoughts-explosion.md`
- [ ] `life/2017-05-02-baloons-over-bagan.md`
- [ ] `life/2019-06-08-railway-market.md`
- [ ] `life/2024-01-03-of-books.md`

### Phase 2: High Priority (10-80% difference) - Estimated 3-4 hours

Review and sync 26 files with moderate differences.

### Phase 3: Low Priority (<10% difference) - Estimated 1-2 hours

Review 33 files with minor differences (likely just formatting).

**Note:** Many of these may not need changes if the difference is just whitespace/formatting.

### Phase 4: Missing File - Estimated 30 minutes

Create markdown for:
- [ ] `work/2025-09-11-website-logs.md`

**Content exists in HTML** - extract and create new markdown file with proper frontmatter.

### Phase 5: Verification - Estimated 1 hour

1. Re-run `ruby compare_content.rb` to verify all files synced
2. Ensure 79 markdown files match their HTML counterparts
3. Commit changes with clear message
4. Proceed with Jekyll migration

---

## Sync Workflow Recommendation

### Option A: Automated Extraction (Faster, Needs Review)

Create a script to automatically extract HTML content and update markdown files, then manually review each change.

**Pros:**
- Fast bulk processing
- Consistent extraction

**Cons:**
- May miss nuances
- Requires careful review
- Risk of breaking existing content

### Option B: Manual Review (Recommended)

For each file in `html_content_review/`:

1. **Open comparison file** - See metadata and content differences
2. **Open HTML in browser** - Understand the rendered content
3. **Open markdown file in editor** - Ready to edit
4. **Compare side-by-side** - Identify what's missing
5. **Update markdown** - Add missing content
6. **Preserve structure** - Keep frontmatter, just update content
7. **Save and verify** - Check markdown format is valid

**Pros:**
- Highest accuracy
- Understand content changes
- Preserve formatting choices
- No data loss risk

**Cons:**
- Time-intensive
- Manual work

### Option C: Hybrid Approach (Balanced)

1. Use automated extraction for structure
2. Manual review for critical files (>50% difference)
3. Spot-check for minor differences (<20%)
4. Full manual review for 10 critical priority files

---

## Next Steps

### Immediate Actions:

1. ✅ **Review this report** - Understand the scope
2. ⬜ **Choose sync approach** - Decide on Option A, B, or C
3. ⬜ **Start with critical files** - Tackle the 10 files with >80% difference
4. ⬜ **Work through priorities** - Phase 1 → Phase 2 → Phase 3 → Phase 4
5. ⬜ **Verify completion** - Re-run comparison script
6. ⬜ **Commit changes** - Git commit before Jekyll migration
7. ⬜ **Proceed with Jekyll setup** - Once content is synced

### Questions to Answer:

- **Do you want to automate?** Or prefer manual control?
- **Which files are most important?** Portfolio/work files? Recent posts?
- **Are there files you want to skip?** Old posts that don't matter?
- **Timeline?** How quickly do you need this done?

---

## Risk Assessment

### Low Risk
- Files with <10% difference (likely just formatting)
- Files with matching frontmatter
- Files modified on same date

### Medium Risk
- Files with 10-50% difference (partial updates)
- Need content comparison

### High Risk
- Files with >80% difference (almost complete rewrites)
- Missing markdown files
- May have custom HTML components

---

## Recommendations

### Before Jekyll Migration

1. **Sync ALL 36 files with major differences**
2. **Create missing markdown file**
3. **Verify with comparison script**
4. **Git commit with message:** "Sync HTML→Markdown before Jekyll migration"
5. **Create backup branch** for safety

### During Jekyll Migration

1. Use synced markdown as source of truth
2. HTML files can be deleted after Jekyll build works
3. Preserve custom HTML components in `_includes/`
4. Test all 79 posts render correctly in Jekyll

---

## Conclusion

**Current State:**
- 79 posts in 3 categories
- 36 posts need content sync
- 1 post needs markdown creation

**Target State:**
- 79 markdown files (single source of truth)
- All content synced from HTML
- Ready for Jekyll migration
- HTML files can be deleted

**Estimated Time to Complete:**
- Manual sync: 7-10 hours
- Automated + review: 4-6 hours
- Critical only: 2-3 hours

**Recommendation:**
Start with the 10 critical files (>80% difference) to capture the most important content updates. These represent major additions that shouldn't be lost. Then decide if you want to continue manually or automate the rest.

---

**Generated:** November 10, 2025
**By:** Content Audit Automation Script
**Status:** READY FOR REVIEW
