commit 05460a2d3a969aeb0fd4f499e194c0877f76fde3
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 26 17:43:43 2020 -0400

    Fixed CentOS 7 fact for docker_version_redhat

commit 5ed66996f5963b67bae0d7e539a3f90c8a2558c2
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 26 17:11:21 2020 -0400

    Fixed Ubuntu 16.04 installation failures
    
    - Was selecting the incorrect version
    - linux-image-extra doesn't work when linuxkit

commit 558bcec30b2bfbdbc454252430c5c83032e8cc8c
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 26 16:34:44 2020 -0400

    Code cleanup
    
    Cleaning up formatting, etc. of code.

commit e69ebe2c74ee28fe10cb1f73688f837f0f59d4e6
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 26 16:24:09 2020 -0400

    Disabled Fedora testing

commit 77ee5862473575d4fbf57c14b023db18cd618589
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 26 16:23:30 2020 -0400

    Removed RedHat pre-reqs

commit c1366b2327082b4ef30208c19799a78d2d6e3f88
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 26 14:01:47 2020 -0400

    Fixing Debian package to installl
    
    Ubuntu and Debian package selection is different

commit e37f292faaccb6b806f468dd3076592361d327a1
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 26 13:05:29 2020 -0400

    Fixed package installations
    
    - Updated packages to be removed prior to install. The packages have
      been updated since this was added.
    - Updated packages to install as this was updated as well.
    - Fixed CentOS/Fedora package idempotency for uninstalling older
      packages.

commit 9ba82429fec2fc3645500c2a01eb22590866e739
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 26 13:04:55 2020 -0400

    Fixed linting issues

commit 1939d98e3fc5e588b57ee169b92a43822b90f75b
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 26 12:25:14 2020 -0400

    Removed task to manage Python modules
    
    - This probably should not be here anyways

commit 9eea439802a7581ffea61e36670ac5c6b95f672f
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 26 11:10:40 2020 -0400

    Added new files, tests, etc from Cookiecutter template
    
    All new file structure, etc. added from Ansible Cookiecutter template.

commit c9e8b3622d564b6e350458b336f10746bea58116
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 26 01:34:51 2020 -0400

    Updated files based on Cookiecutter template

commit 9a2dba467c1be3837c1e430608599fb42efc74f5
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 26 01:31:32 2020 -0400

    Removed old testing and files not in new template

commit 6716b54a715827fa2fb80bcf6eadaf87ae19564e
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Mon Sep 30 17:48:26 2019 -0400

    Cleaning up code
    
    - Cleaned up conditionals
    - Cleaned up formatting

commit f894676db9649840d3f61b3fc95dcfdc33145cb0
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Thu Sep 5 15:00:54 2019 -0400

    Added Molecule testing for Ubuntu 18.04
    
    More distros will be added over time for Molecule testing.

commit 181daf19c0d31014c500139cf512e112b013845f
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 14 15:19:14 2019 -0400

    Fixed 18.09 install for Ubuntu

commit f724f5c010f483adec848dc161dd91e55122e29a
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Thu Dec 27 14:39:56 2018 -0500

    Refactored code
    
    Cleaned up code based on Ansible lint and YAML lint

commit 8dbd38683366c90d1ccfca0872fbca88c6bb4820
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Fri Dec 7 00:16:57 2018 -0500

    Cleaned up per yamllint and ansible-lint

commit 5216199185ec8baa762623778dfbcf3d36b2499b
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Thu Dec 6 23:44:08 2018 -0500

    Fixed issue with installing on Ubuntu 18.04

commit ff30dff9c4145ff97de6bc5f444b54fc4979d3ef
Author: bunchc <bunchc@gmail.com>
Date:   Mon Feb 19 21:57:57 2018 -0600

    Install failed if Docker was already on the system. This adds a check for an existing install.
    
    tasks/debian.yml - Add has_docker variable and check for existing Docker install

commit aa80283844d24efe1cf968fd07d3bcb730ff5fb0
Author: bunchc <bunchc@gmail.com>
Date:   Mon Feb 19 21:57:56 2018 -0600

    Raising Docker version.
    defaults/main.yml - Bumped version to 17.12.0
    tasks/set_facts.yml - Added version clause for versions >- 17.09

commit eca1f6f536d2716e7bbb6c82e8d22daccf350929
Author: jardleex <jardleex@users.noreply.github.com>
Date:   Wed Feb 14 08:15:42 2018 +0100

    added switch docker_install_bridge_utils

commit b8a47cf702ee14b37ee920319fccdbd476c6d57d
Author: jardleex <jardleex@users.noreply.github.com>
Date:   Wed Feb 14 08:15:35 2018 +0100

    added switch docker_linux_image_extra

commit 615099ab70f59467f88dfccbfb3b85858d34a156
Author: jardleex <jardleex@users.noreply.github.com>
Date:   Wed Feb 14 08:15:17 2018 +0100

    added switch docker_manage_python_modules

commit 3ed5817cca16970b65c8ab346c4cb856eabc35e8
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Tue Oct 31 12:01:12 2017 -0400

    Disabled docker-py module
    
    There is a conflict between docker-compose and docker-py modules.
    Preference is to use docker-compose module.

commit cd2078756cf3a108f7c661ed1e248ff0491991eb
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Fri Aug 11 15:14:15 2017 -0400

    Create LICENSE

commit 5bb00f4ab741bac866e31da79e649bb4ca6d472f
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Fri Aug 11 10:12:21 2017 -0400

    Updated Docker version to 17.06.0 as default
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 4bd860a675aa069f2eac6c75953d480ff006444a
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Fri Aug 11 10:11:55 2017 -0400

    Updated Ansible Galaxy Info
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 66e99d32908b797df4b8d5707ee17e16f62d5e2e
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Jun 11 01:33:13 2017 -0400

    Cleaned up repo info

commit 578c0fb2de012f5d6c7188301034d42a813cab0a
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sat Jun 10 00:21:39 2017 -0400

    Added different log-driver options
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 6a91d93711380c3ce18084531c511f1da591b488
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sat Jun 3 12:51:15 2017 -0400

    Added tasks to ensure legacy repo info is removed
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 789805dcef00b79a4f2230b8c4fe74331902ed23
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sat Jun 3 10:31:48 2017 -0400

    Fixing Travis test
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 29a80b8122b91aa7fe96b86729e5011f5195ecad
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sat Jun 3 10:27:38 2017 -0400

    Fixing missing packages for Ubuntu
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 486823b59b2efcb06bbae0c6431b6e4d349e84b6
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sat Jun 3 10:11:32 2017 -0400

    Updated install method/repos for newest info
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 86209b6e87fadd814b7640cd2cf7b8d8b6349cd5
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Wed May 3 22:32:03 2017 -0400

    Removed Alpine galaxy info
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit a8e3a8327b2fa05a503b882ab18d0e8146bb294a
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Wed May 3 22:19:53 2017 -0400

    Added Alpine Linux Support
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit aade61df53dc6874f2025e4382568fd965ae3670
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sat Apr 29 16:37:52 2017 -0400

    Added new functionality to configure Docker daemon.
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit caf66f36baf8edbb4aa586537ae909c3d8d90db8
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Mon Apr 24 18:24:56 2017 -0400

    Added ability to define Docker version to install
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 2f64dc6d81df40586e9a83371a8af6836458a63d
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Apr 23 22:56:46 2017 -0400

    Dev/become usage (#4)
    
    * Changed pip module install method from easy_install, also added become: true where needed
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>
    
    * Added become: true where needed
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>
    
    * Added Travis testing
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>
    
    * Fixed Ubuntu Precise install
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit fdf17b1713ede5355ef9daad8509af7a3d4e1578
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Tue Mar 28 08:47:46 2017 -0400

    fixed fedora install
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 2292c5ac51ce0d2dec79a7aea5100beb571b6e3d
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Thu Mar 23 13:56:22 2017 -0400

    Fixed CentOS configuration
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 5abec9d185801d52baa5c34d84dbb996bcf03cfa
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Wed Mar 22 20:25:56 2017 -0400

    Updated variables, added configuration options to daemon.json instead of other methods
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 44c37830ff648eab5864220693cf7246827257bf
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sat Mar 18 00:25:31 2017 -0400

    Cleaned up vars
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit d3e48e8bc947ad801826c7b366c2a976a0f9a791
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sat Mar 18 00:25:11 2017 -0400

    Fixed ansible-lint issues
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit f918372601dcf75367949889eec7d6bfb5c7823f
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sat Dec 10 23:04:10 2016 -0500

    Addresses issue #3
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit dadfeba7b1b38163c0f294209fe102eda1ab3892
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sat Dec 10 22:59:35 2016 -0500

    Cleaned up vars...addresses issue #2
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit f98a347ce1ee22be7d7cfc0e89d0d0c71e6868f5
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Tue Nov 8 19:33:34 2016 -0500

    Addresses issue #1
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit eba8a9bd14a6367e591bdf0a9aec3efe5e634586
Author: Lary Smith Jr <mrlesmithjr@gmail.com>
Date:   Wed Aug 31 15:52:44 2016 -0400

    Fixed Ubuntu SystemD drop-in
    
    Signed-off-by: Lary Smith Jr <mrlesmithjr@gmail.com>

commit 5cba0d535c65a97f404196ff7f1a3482615c81e0
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Aug 14 23:15:41 2016 -0400

    Fixed conditional
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 315ab39c790a6e1e35a9ca2c1192923b491d7e9e
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Aug 14 23:07:16 2016 -0400

    Fixed task names
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit aaf42a9af06cb33a200714b0d90516bce6dc18c3
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Aug 14 23:04:50 2016 -0400

    Fixed systemd Docker service override
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 76a9b644fc9fdc855fdc3c9612a5458d535d5c41
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Aug 14 22:02:55 2016 -0400

    Fixed systemd docker_opts for Ubuntu Xenial and RedHat
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit c73f605c9178ea1b6f51f94393e3b497284f8600
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Aug 14 16:32:43 2016 -0400

    Added var to define managing docker images
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 678d66cb3a1f559e5b6098500d21560bfde235f0
Author: Larry Smith Jr <mrlesmithjr@gmail.coml>
Date:   Sat May 7 21:47:25 2016 -0400

    Added RedHat support
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.coml>

commit 3b99bc4e0f4493ae370b4dea6701ab0f289f56d1
Author: Larry Smith Jr <mrlesmithjr@gmail.coml>
Date:   Sat May 7 21:47:03 2016 -0400

    Split out user management
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.coml>

commit 1749dded0d4eb0a9838e5afb1d457bb07e7bcd74
Author: Larry Smith Jr <mrlesmithjr@gmail.coml>
Date:   Sat May 7 21:46:44 2016 -0400

    Split out python module management
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.coml>

commit ac2e2c47876fcb24fb4be0aadc7939eaa022c208
Author: Larry Smith Jr <mrlesmithjr@gmail.coml>
Date:   Sat May 7 21:46:18 2016 -0400

    Split out configuration tasks
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.coml>

commit 597b69ac13e5f9e6e044e7ef1ec4712d767cade8
Author: Larry Smith Jr <mrlesmithjr@gmail.coml>
Date:   Sat May 7 21:45:56 2016 -0400

    Split out tasks
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.coml>

commit a58cb064cf342c8a38752edca8aab2565cd84a64
Author: Larry Smith Jr <mrlesmithjr@gmail.coml>
Date:   Sat May 7 21:45:32 2016 -0400

    Added new tasks
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.coml>

commit b21ebe8910119399ff9e3efc69c1fa1805762402
Author: Larry Smith Jr <mrlesmithjr@gmail.coml>
Date:   Sat May 7 21:45:15 2016 -0400

    Updated Galaxy info
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.coml>

commit 60209bfe9bd2c5ef720cfe3fe7d156398472b002
Author: Larry Smith Jr <mrlesmithjr@gmail.coml>
Date:   Sat May 7 21:45:01 2016 -0400

    Cleaned up
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.coml>

commit ef0e80fbef784789f28cab1590f3b04f0fdcb8f5
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Thu Jan 7 16:18:46 2016 -0500

    Added ability to change Docker data directory
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit b6dcaf361796bc4788549fe91b50af1550027a9b
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Tue Dec 29 19:40:46 2015 -0500

    Fixed formatting issue of when
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 9c74ca42fb98195c2fef4de7f2a5f036ced01591
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Tue Dec 29 19:09:27 2015 -0500

    Updated for Debian
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit e302505ea3717f6689e55a3cfd7d4d448e696266
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Tue Dec 29 18:56:46 2015 -0500

    Removed state for easy_install
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit c285474eea0d755c88b7f9b3e93207c4796954a6
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Tue Dec 29 18:52:32 2015 -0500

    Updated for Debian
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit d06837eb62feb6642d643423ee860c9978347d4d
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Sun Dec 20 11:50:17 2015 -0500

    Added docker-compose
    
    Added docker-compose package to be install via pip install...Compose is a tool for defining and running multi-container Docker applications.
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 8ed468694d57618464955ebe4a93d79bd76c6def
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Fri Dec 18 15:27:30 2015 -0500

    Added task to install additional packages
    
    Added additional task to install additional debian packages. This will be used to add additonal packages to with_items to be installed over time.
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 4bb4d766ab52ae892f3f0adab951938cded1e05c
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Fri Dec 18 09:33:18 2015 -0500

    Added/updated meta data
    
    Added and updated meta data information. Added meta data for Ansible Galaxy.
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 0e406e9c1dbdfd120559f42cb99e694b5944eff4
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Fri Dec 18 07:35:01 2015 -0500

    Commented out fedora image
    
    Fedora Docker image is failing to install so it has been commented out at this time.
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 1d5e9564077cd5964df57dc95356ce1c230efbcd
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Fri Dec 18 07:25:20 2015 -0500

    Added Docker image options
    
    Added additional variables for Docker images..Allows the image state to be defined as part of the image definition. Also added Fedora and commented out example
    elasticsearch image.
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit f2dd55b4cc2095c5a851b020864f26c320314b71
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Fri Dec 18 01:10:03 2015 -0500

    Added python packages and modules
    
    Added tasks to install python pip to install python modules. Also added docker-py module to be installed.
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 204820bdc945f298e67c4b5dbf62b30a89901307
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Fri Dec 18 01:00:23 2015 -0500

    Added Docker images tasks
    
    Added first commit of Docker images tasks. This task will allow Docker images to be managed.
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 9f26f47834f73a0e8a9f52655e90438f671316a7
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Fri Dec 18 00:59:04 2015 -0500

    Added ability to install Docker images
    
    Added options and ability to install Docker images during setup if desired.
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 5446ee5b661413828e03de7190dd74fd65295ac1
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Thu Dec 17 20:46:04 2015 -0500

    added notes to variables
    
    Added notes to each variable that was missing to clarify what each variable is.
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>

commit 017b7984b08310a4cce8c5cdfa377cc30537b5b1
Author: Larry Smith Jr <mrlesmithjr@gmail.com>
Date:   Thu Dec 17 20:39:24 2015 -0500

    First commit
    
    This is the first commit of this Ansible Docker Role.
    
    Signed-off-by: Larry Smith Jr <mrlesmithjr@gmail.com>
