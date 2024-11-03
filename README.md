# demo-moodle

demo instance for teacheraide moodle plugins

## Start Locally

```
docker compose up -d --build
```

moodle instance would then be ready on `http://localhost:8080`

## update teacheraide plugins and trigger new build

duplicate the install-teacher-plugins script and bump the version in filename and the variable
