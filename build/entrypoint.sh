#!/bin/sh

if [[ $INPUT_USE_BUILD_SCRIPT == "true" && -f $INPUT_BUILD_SCRIPT_NAME ]]; then
  ./$INPUT_BUILD_SCRIPT_NAME
  exit $?
fi

if [[ $INPUT_SKIP_TESTS = "true" ]]; then
  GRADLE_CMD="clean assemble"
  MAVEN_CMD="clean install -DskipTests --batch-mode"
else
  GRADLE_CMD="clean build"
  MAVEN_CMD="clean install --batch-mode"
fi

if [[ $INPUT_QUIET = "true" ]]; then
  QUIET="--quiet"
fi

if [[ -f $INPUT_MAVEN_SETTINGS_FILE ]]; then
  MAVEN_SETTINGS="-s $INPUT_MAVEN_SETTINGS_FILE"
fi

if [[ ! -z "$INPUT_GITHUB_TOKEN" ]]; then
  export GITHUB_TOKEN="$INPUT_GITHUB_TOKEN"
fi

if [[ -f "gradlew" ]]; then
  ./gradlew $GRADLE_CMD $QUIET
elif [[ -f "build.gradle" || -f "build.gradle.kts" ]]; then
  gradle $GRADLE_CMD $QUIET
elif [[ -f "mavenw" ]]; then
  ./mavenw $MAVEN_CMD $QUIET $MAVEN_SETTINGS
elif [[ -f "pom.xml" ]]; then
  mvn $MAVEN_CMD $QUIET $MAVEN_SETTINGS
else
  echo "This doesn't look like a maven or gradle project. Alternatively provide a 'build.sh' build script."
fi
