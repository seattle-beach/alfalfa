# Ansible Role: Xcode

[![Build Status](https://travis-ci.org/ivancasco/ansible-role-xcode.svg?branch=master)](https://travis-ci.org/ivancasco/ansible-role-xcode)

## Role Name

Ansible role for installing and configuring Xcode.

## Requirements

This role assumes that password-less sudo access is already set up.

This role also requires homebrew already installed.

## Role Variables

 - macappstore_user: "Your appleid appstore user"
 - macappstore_passowrd: "Your appleid appstore password"

## Dependencies

None.

## Example Playbook

    - hosts: servers
      roles:
         - { role: ivancasco.xcode }

## License

Apache 2.0

## Author Information

This role was created by [Ivan Casco](http://www.ivancasco.com/) (@ivicv)

