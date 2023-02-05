# docker/deployment/

A (big) Docker container for general deployment tasks. Pre-installs common programs used during deployment.

It is faster to use smaller containers for individual deployment tasks, such as a 'terraform' container to run Terraform.
However, sometimes you might need multiple deployment tools to interact, and in that case it's easier (though slower)
to just put all the tools in one container and call a script that does whatever it needs.

This container also packages the 'asdf' script. This lets you add a 'plugin' and then install any version of some tool
that you might need. A default set of plugins are installed from [tool-versions.txt](./tool-versions.txt).

