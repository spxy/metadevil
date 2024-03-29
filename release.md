Developer Notes
===============

Release Checklist
-----------------

Perform the following tasks for every release:

  - Update version in devil.el (two places).
  - Update copyright notice in devil.el (in a new year only).
  - Update copyright notice in LICENSE.org (in a new year only).
  - Update CHANGES.org.
  - Run checks:

    ```sh
    (cd ~/git/metadevil && make release-checks)
    ```

  - Commit changes:

    ```sh
    git add -p
    git status
    ```

  - Tag the release:

    ```
    VERSION=

    git commit -em "Set version to $VERSION"
    git tag $VERSION -m "Devil $VERSION"
    git push origin main $VERSION
    ```
