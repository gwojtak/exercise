/etc/yum.repos.d/cloudera-cdh5.repo:
  file.managed:
    - source: salt://files/cdh/cloudera-cdh5.repo
    - user: root
    - group: root
    - mode: 0644

java-1.8.0-openjdk:
  pkg.installed: []
  require:
    - pkg: java-1.8.0-openjdk

hadoop-conf-pseudo:
  pkg.installed: []
  require:
    - file: /etc/yum.repos.d/cloudera-cdh5.repo
    - pkg: hadoop-conf-pseudo
    - pkg: java-1.8.0-openjdk

hadoop-post:
  cmd.script:
    - require:
      - pkg: hadoop-conf-pseudo
    - source: salt://files/scripts/hadoop-post.sh
    - shell: /bin/bash
    - user: root
