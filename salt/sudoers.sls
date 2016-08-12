/etc/sudoers.d/synthesys:
  file.managed:
    - source: salt://files/sudoers/synthesys-sudoers
    - user: root
    - group: root
    - mode: 0400

