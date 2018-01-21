# ansible-deploy

[![Docker Pulls](https://img.shields.io/docker/pulls/terzom/ansible-deploy.svg?style=flat-square)]()
[![Docker Stars](https://img.shields.io/docker/stars/terzom/ansible-deploy.svg?style=flat-square)]()
[![Docker Build Status](https://img.shields.io/docker/build/terzom/ansible-deploy.svg?style=flat-square)]()

A smallish container based on alpine providing ansible support to drive infrastructure from inside a container.

## Why?
Deploying from CI/CD through gitlab you need lightweight tools to push code around or drive various processes, Using this
container allows for easy orchestration of complex systems driven through code.

## Usage
```
docker run -it -v ${PWD}:/deployment -w /deployment terzom/ansible-deploy sh
```
### Inside gitlab-ci.yml

```
variables:
  keyfile: /tmp/ssh_private.key
  ANSIBLE_HOST_KEY_CHECKING: "False"

stages:
  - sanity
  - deploy

deploy_syntax:
  stage: sanity
  image: terzom/ansible-deploy
  script:
  - cd deploy
  - ansible-lint *.yml

deploy:
  environment: production
  stage: deploy
  image: terzom/ansible-deploy

  before_script:
  # PRIVATE_KEY is a Secret variable inside gitlab
  # https://gitlab.com/help/ci/variables/README.md#secret-variables
  - echo "${PRIVATE_KEY}" | tr -d '\r' > ${keyfile}
  - chmod 600 ${keyfile}

  script:
  - cd deploy
  # ansbile.cfg and invntory are in the deploy directory
  # of project.
  - ansible-playbook -l production deploy.yml
```

## License

The code in this repository, unless otherwise noted, is GNU licensed. See the [LICENSE](LICENSE) file in this repository.

[ansible]: http://www.ansible.com/
[issues]: https://github.com/mterzo/ansible-deploy/issues
