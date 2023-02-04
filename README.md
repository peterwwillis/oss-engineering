# oss-engineering

## Software management

Software is managed in the following ways:

### 1. OS Package Manager
Try to install software via the OS package manager. Note that the same software may have different package and/or file names in different OSes/distributions/package managers.

#### Linux
- **Debian** or **Ubuntu**:
  - If the `apt-get` command exists, use it to install software.
- **Alpine**:
  - If the `apk` command exists, use it to install software.

### 2. Custom Package Manager
Use a custom package manager to install software. This might be a programming language-specific package manager, or a more general one.

#### MacOS
Brew is used to install software on MacOS.

#### Linux

##### Python packages
- **Locations:**
  - **Public packages:** Packages are published to https://pypi.org/
  - **Private packages:** Packages may be published to a private, PyPI-compatible repository.
- **Tools:**
  - **Poetry installer:** If a `config.toml` file exists, try to use the [Poetry](https://python-poetry.org) package manager.
  - **Pipenv:** If a `Pipfile` file exists, try to use the [Pipenv](https://pipenv.pypa.io/en/latest/) package manager.
  - **Pip:** If a `requirements.txt` file exists, try to install those packages with `python -m pip install -r requirements.txt`.

