# Moodle CodeRunner Docker Container
A really basic Docker compose with everything out of the box for experimenting with Moodle, CodeRunner and Jobe

# Author
Boris Steiner

Email: Boris.Steiner@fh-hagenberg.at

# How to use
Clone the repository, navigate into `/dockercoderunner` and run 
```
docker-compose up -d
```

The setup should complete without interrupts or errors.

After the installation is complete and the containers are running this site should be available:
<http://localhost:4315/jobe/index.php/restapi/languages>

and look like this:

![Screenshot of the native supported Jobe languages](https://github.com/theOlchi/dockercoderunner/blob/main/screenshots/screenshot2.PNG "doc screenshot 1")
```json
[["c","11.4.0"],["cpp","11.4.0"],["java","11.0.21"],["nodejs","12.22.9"],["octave","6.4.0"],["pascal","3.2.2"],["php","8.1.2"],["python3","3.10.12"]]
```

This means the Jobe Server is up and running.

Then this site should be alailable: <http://localhost:8080/moodle/my/>

The user name is `admin` and the password is `asdf`

![Screenshot of the Moodle login page](https://github.com/theOlchi/dockercoderunner/blob/main/screenshots/screenshot1.PNG "doc screenshot 2")

# Connect Moodle with Jobe
Under `Site administration/HTTP Security`

<http://localhost:8080/moodle/admin/settings.php?section=httpsecurity>

the blocked hosts list should be cleared and `4315` should be added to the allowed ports.
After this is done click the blue button `Save changes`.

![Screenshot of HTTP Security blocked hosts](https://github.com/theOlchi/dockercoderunner/blob/main/screenshots/screenshot3.PNG "doc screenshot 3")
![Screenshot of HTTP Security allowed ports](https://github.com/theOlchi/dockercoderunner/blob/main/screenshots/screenshot4.PNG "doc screenshot 4")

Under `Site administration/Plugins/CodeRunner`

<http://localhost:8080/moodle/admin/settings.php?section=qtypesettingcoderunner>

this link should be added for the Jobe server:

```
host.docker.internal:4315
```

![Screenshot of HTTP Security allowed ports](https://github.com/theOlchi/dockercoderunner/blob/main/screenshots/screenshot5.PNG "doc screenshot 5")

and the `Enable sandbox web service` checkbox should be checked. Again click the blue `Save changes` button on the bottom of the site.

After this you should be able to create and use CodeRunner questions.

![Screenshot of HTTP Security allowed ports](https://github.com/theOlchi/dockercoderunner/blob/main/screenshots/screenshot6.PNG "doc screenshot 6")

# About
This docker compose project is mostly based on this guide: <https://docs.moodle.org/403/en/Step-by-step_Installation_Guide_for_Ubuntu>

The script installs matplotlib additionally on the Jobe server.
