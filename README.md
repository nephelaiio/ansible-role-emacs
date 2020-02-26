# nephelaiio.emacs

[![Build Status](https://travis-ci.org/nephelaiio/ansible-role-emacs.svg?branch=master)](https://travis-ci.org/nephelaiio/ansible-role-emacs)
[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-systemd--service-blue.svg)](https://galaxy.ansible.com/nephelaiio/emacs/)

An [ansible role](https://galaxy.ansible.com/nephelaiio/emacs) to install and configure vim

## Role Variables

Please refer to the [defaults file](/defaults/main.yml) for an up to date list of input parameters.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```
    - hosts: servers
      roles:
         - role: nephelaiio.emacs
```

## Testing

Please make sure your environment has [docker](https://www.docker.com) installed in order to run role validation tests. Additional python dependencies are listed in the [requirements file](https://github.com/nephelaiio/ansible-role-requirements/blob/master/requirements.txt)

This role is tested against the following distributions (docker images):

  * Ubuntu Bionic
  * Debian Buster
  * Arch Linux

You can test the role directly from sources using command ` molecule test `

## License

This project is licensed under the terms of the [MIT License](/LICENSE)
