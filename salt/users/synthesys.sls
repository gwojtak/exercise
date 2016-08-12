sudoall:
  group.present:
    - gid: 10001
    
synthesys:
  group.present:
    - gid: 10000
  user.present:
    - fullname: synthesys account
    - uid: 10000
    - gid: 10000
    - shell: /bin/bash
    - home: /home/synthesys
    - groups:
      - sudoall

  ssh_auth.present:
    - user: synthesys
    - source: salt://files/ssh-keys/synthesys-authorized_keys
    - config: ".ssh/authorized_keys"

