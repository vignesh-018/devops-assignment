Branching Strategy
main: The main branch contains the production-ready code.  Only stable and tested code is merged into this branch.
develop: The develop branch is the primary branch for development.  All new features and bug fixes are integrated into this branch.
Feature Branches: Feature branches are created for each new feature or bug fix.  They branch off from `develop` and are merged back into `develop` after review.
- Code review & PR guidelines
- Workflow
1. A new feature is started by creating a feature branch from develop: git checkout -b feature/new-feature develop
2. Changes are made in the feature branch and committed.
3. The feature branch is pushed to the remote repository: git push origin feature/new-feature
4. A pull request is created to merge the feature branch into develop.
5. The pull request is reviewed.
6. After review, the pull request is merged into develop.
7. Periodically, the develop branch is merged into "main" for releases.

![image](https://github.com/user-attachments/assets/be6ce292-187b-4e98-843b-765823d24100) - screens shot of the branches ans also i edited this line in feature branch.
created a feature branch and apply some chnages in the file and merged it into the develop branch
![Update branching-strategy md #1](https://github.com/user-attachments/assets/35519aa9-e049-4ecf-9590-f94a1b5ea264)

Now merging the develop branch into main and find out the logs from below images.
![image](https://github.com/user-attachments/assets/e0641385-66a2-439c-9d6b-abee71c8fa4f)
![Git hub](https://github.com/user-attachments/assets/e1f0ce40-c0a0-4d57-a7b4-165dddd6a1b4)



