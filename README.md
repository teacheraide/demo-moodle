# demo-moodle

demo moodle docker for teacheraide moodle plugins
- base on [bitnami/moodle:4.5](https://hub.docker.com/r/bitnami/moodle)

## Start Locally

```
docker compose up -d --build
```

moodle instance would then be ready on `http://localhost:8080`

## update teacheraide plugins and trigger new build

change the install-teacher-plugins script and bump the version in filename and the variable inside

new filename must be unique, as the server depends will not run scripts that has run before

- <date><version> prefix is currently used to ensure uniqueness

push to main and make a new release

- this will trigger a new docker image build

new plugin script should now run after the new server image is started
