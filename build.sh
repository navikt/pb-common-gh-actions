#!/usr/bin/env sh

if [[ $INPUT_SKIP_TESTS = "true" ]]; then
  GRADLE_CMD="clean assemble"
  MAVEN_CMD="clean install -DskipTests --batch-mode"
else
  GRADLE_CMD="clean build"
  MAVEN_CMD="clean install --batch-mode"
fi

if [[ $INPUT_QUIET ]]; then
  QUIET="--quiet"
fi

if [[ -f $INPUT_MAVEN_SETTINGS_FILE ]]; then
  MAVEN_SETTINGS="-s $INPUT_MAVEN_SETTINGS_FILE"
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
  echo "This doesn't look like a maven or gradle project."
fi