# Moodle CodeRunner Docker Container
A really basic Docker compose with everything out of the box for experimenting with Moodle, CodeRunner and Jobe

# Author
Boris Steiner

Email: Boris.Steiner@fh-hagenberg.at

# How to use
Navigate to the root folder and run `docker-compose up -d`
The setup should complete without interrupts or errors.

After the installation is complete and the containers are running this site should be available:
<http://localhost:4315/jobe/index.php/restapi/languages>
and look like this:
```json
[["c","11.4.0"],["cpp","11.4.0"],["java","11.0.21"],["nodejs","12.22.9"],["octave","6.4.0"],["pascal","3.2.2"],["php","8.1.2"],["python3","3.10.12"]]
```
![Screenshot of the native supported Jobe languages](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "doc screenshot 1")

This means the Jobe Server is up and running.

Then this site should be alailable: <http://localhost:8080/moodle/my/>

The user name is `admin` and the password is `asdf`
![Screenshot of the Moodle login page](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "doc screenshot 2")

Under `Site administration/HTTP Security`

<http://localhost:8080/moodle/admin/settings.php?section=httpsecurity>

the blocked hosts list should be cleared and `4315` should be added to the allowed ports.
![Screenshot of HTTP Security settings](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "doc screenshot 3")

Under `Site administration/Plugins/CodeRunner`

<http://localhost:8080/moodle/admin/settings.php?section=qtypesettingcoderunner>

this link should be added for the Jobe server:

<host.docker.internal:4315>

and the `Enable sandbox web service` checkbox should be checked.

After this you should be able to create and use CodeRunner questions.

# About
This docker compose project is mostly based on this guide: <https://docs.moodle.org/403/en/Step-by-step_Installation_Guide_for_Ubuntu>

The script installs matplotlib additionally on the Jobe server.
