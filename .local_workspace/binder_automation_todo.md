# Binder Automation Todo

## Goal

Create an automated system for paired Binder repositories that sync content from main course repositories without manual intervention.

## Background

Current approach (manual):
1. Create `COURSE-NAME-Binder` repository
2. Add `.binder/postBuild` that clones main repo
3. Manually keep environment.yml updated
4. Students get outdated content between updates

## Proposed Automated Approach

### Option 1: GitHub Actions Sync (Recommended)

**Main Course Repository** (e.g., EMSC-4033)
- Contains workflow that triggers on push
- Sends repository dispatch event to Binder repo

**Binder Repository** (e.g., EMSC-4033-Binder)
- Receives dispatch event
- Pulls latest notebooks/data from main repo
- Commits changes
- Binder rebuilds automatically

#### Implementation Tasks

- [ ] Create GitHub Actions workflow template for main repository
  - Trigger on push to main branch
  - Filter to only trigger on notebook/data changes
  - Send repository dispatch to Binder repo

- [ ] Create GitHub Actions workflow template for Binder repository
  - Listen for repository dispatch
  - Clone/pull from main repository
  - Copy notebooks and data files
  - Commit changes if different
  - Trigger Binder rebuild (via commit)

- [ ] Add authentication considerations
  - Use GitHub tokens for cross-repo access
  - Document token setup in secrets

- [ ] Test with example course

### Option 2: Git Submodules

**Binder Repository Structure:**
```
COURSE-Binder/
├── .binder/
│   ├── environment.yml
│   └── postBuild
├── course-content/  (submodule -> main repo)
└── start.sh
```

#### Implementation Tasks

- [ ] Create template structure with submodule
- [ ] Document submodule setup process
- [ ] Test Binder build with submodules
- [ ] Handle submodule updates (manual git submodule update?)

### Option 3: Dynamic Fetch (Current with Caching)

Enhance current approach with caching:

**postBuild:**
```bash
#!/bin/bash

# Check if content exists and is recent
if [ -d "course-content" ]; then
    cd course-content
    git pull
    cd ..
else
    git clone --depth 1 https://github.com/ANU-RSES-Education/COURSE-NAME.git course-content
fi

# Copy content
cp -r course-content/WebBook/Notebooks/* notebooks/
```

#### Implementation Tasks

- [ ] Create optimized postBuild template
- [ ] Test caching behavior
- [ ] Document limitations (always fetches on rebuild)

## Decision Criteria

| Approach | Pros | Cons |
|----------|------|------|
| **GitHub Actions** | Always up to date, automatic | Complex setup, requires tokens |
| **Submodules** | Git-native, version control | Manual updates needed |
| **Dynamic Fetch** | Simple, already working | Slow, refetches every rebuild |

## Recommended Path Forward

**Phase 1: Enhance Current (Dynamic Fetch)**
- Improve caching in postBuild
- Create template with best practices
- Document for manual setup

**Phase 2: Add GitHub Actions**
- Create workflow templates
- Test with pilot course
- Add to template documentation

**Phase 3: Template Integration**
- Add Binder setup as optional template feature
- Create script to initialize paired repo
- Automate token setup

## Additional Considerations

### Security
- Binder repo should be public (required for mybinder.org)
- Don't sync sensitive data or answers
- Use .gitignore to exclude assessment solutions

### Performance
- Keep Binder environment lean
- Cache package builds when possible
- Consider custom binderhub for ANU?

### Maintenance
- Monitor for breaking changes in Binder
- Update environment.yml when packages evolve
- Test rebuilds periodically

## Next Steps

1. Create enhanced postBuild template (Phase 1)
2. Document Binder setup in template docs (DONE)
3. Test with existing course
4. Design GitHub Actions approach
5. Implement and test automation

## Resources

- [Binder Documentation](https://mybinder.readthedocs.io/)
- [repo2docker](https://repo2docker.readthedocs.io/)
- [GitHub Actions - Repository Dispatch](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#repository_dispatch)
