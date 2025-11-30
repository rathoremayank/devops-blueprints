# Jenkins CI/CD & Release Engineering

## Table of Contents
1. Introduction to Jenkins
2. Jenkins Architecture
3. CI/CD Concepts
4. Git Strategy for Jenkins
5. Pipeline Stages in Jenkins
6. Rollback Strategies
7. Artifactory Integration
8. Release Engineering Best Practices
9. Example Jenkins Pipeline
10. Scenario-Based Interview Questions & Answers

---

## 1. Introduction to Jenkins
Jenkins is an open-source automation server widely used for building, testing, and deploying software. It supports continuous integration (CI) and continuous delivery (CD), enabling teams to automate the entire software development lifecycle.

**Key Features:**
- Extensible via plugins
- Supports distributed builds
- Integrates with various tools (Git, Docker, Artifactory, etc.)
- Easy to configure pipelines (declarative & scripted)

## 2. Jenkins Architecture
- **Master-Agent Model:** Jenkins master schedules jobs, manages configuration, and delegates build tasks to agents.
- **Plugins:** Extend Jenkins functionality (e.g., Git, Artifactory, Slack).
- **Jobs & Pipelines:** Define build, test, and deploy steps.

## 3. CI/CD Concepts
- **Continuous Integration (CI):** Automatically build and test code on every commit.
- **Continuous Delivery (CD):** Automate deployment to staging/production after successful CI.
- **Continuous Deployment:** Every change passes through the pipeline and is deployed automatically.

## 4. Git Strategy for Jenkins
- **Branching Models:**
  - Git Flow: `master`, `develop`, `feature`, `release`, `hotfix` branches.
  - Trunk-Based Development: Short-lived feature branches, frequent merges to `main`.
- **Best Practices:**
  - Protect main branches with PR reviews.
  - Use tags for releases.
  - Automate merges and deployments via Jenkins pipelines.

## 5. Pipeline Stages in Jenkins
A typical Jenkins pipeline includes:
- **Checkout:** Retrieve code from Git.
- **Build:** Compile code, run linters.
- **Test:** Unit, integration, and end-to-end tests.
- **Package:** Create deployable artifacts.
- **Publish:** Upload artifacts to Artifactory or other repositories.
- **Deploy:** Deploy to staging/production.
- **Rollback:** Revert to previous stable version if needed.

**Example Declarative Pipeline:**
```groovy
pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Build') {
      steps { sh 'mvn clean package' }
    }
    stage('Test') {
      steps { sh 'mvn test' }
    }
    stage('Publish') {
      steps { sh 'curl -u user:pass -T target/app.jar "http://artifactory.example.com/artifactory/libs-release-local/"' }
    }
    stage('Deploy') {
      steps { sh './deploy.sh' }
    }
    stage('Rollback') {
      steps { sh './rollback.sh' }
    }
  }
}
```

## 6. Rollback Strategies
- **Automated Rollback:** Trigger rollback on failed deployment or health check.
- **Manual Rollback:** Use Jenkins to redeploy previous artifact.
- **Blue-Green Deployment:** Switch traffic between environments for instant rollback.
- **Canary Releases:** Gradually roll out changes and rollback if issues detected.

## 7. Artifactory Integration
- **Purpose:** Store build artifacts, dependencies, and release packages.
- **Jenkins Integration:**
  - Use Artifactory plugin for publishing and resolving artifacts.
  - Configure credentials and repository URLs in Jenkins.
- **Example:**
```groovy
steps {
  rtUpload(
    serverId: 'Artifactory-Server',
    spec: '''{
      "files": [
        {
          "pattern": "target/*.jar",
          "target": "libs-release-local/"
        }
      ]
    }'''
  )
}
```

## 8. Release Engineering Best Practices
- Automate versioning and tagging.
- Maintain changelogs.
- Use semantic versioning.
- Ensure reproducible builds.
- Automate release notes generation.
- Secure credentials and secrets.

## 9. Example Jenkins Pipeline
```groovy
pipeline {
  agent any
  environment {
    ARTIFACTORY_URL = 'http://artifactory.example.com/artifactory'
    ARTIFACTORY_CRED = credentials('artifactory-cred')
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Build') {
      steps { sh 'mvn clean package' }
    }
    stage('Test') {
      steps { sh 'mvn test' }
    }
    stage('Publish') {
      steps {
        sh "curl -u $ARTIFACTORY_CRED -T target/app.jar $ARTIFACTORY_URL/libs-release-local/"
      }
    }
    stage('Deploy') {
      steps { sh './deploy.sh' }
    }
    stage('Rollback') {
      steps { sh './rollback.sh' }
    }
  }
}
```

---

## 10. Scenario-Based Interview Questions & Answers

### Jenkins CI/CD
1. **Q:** How would you set up a Jenkins pipeline for a microservices project?
   **A:** Use multi-branch pipelines, shared libraries, and parameterized builds for each microservice. Integrate with Docker and Kubernetes for deployment.

2. **Q:** What steps would you take if a build fails in Jenkins?
   **A:** Analyze logs, check code changes, rerun tests, and if needed, revert the commit or trigger a rollback.

3. **Q:** How do you secure Jenkins?
   **A:** Use role-based access, secure credentials, enable HTTPS, and restrict plugin installations.

4. **Q:** How do you handle secrets in Jenkins pipelines?
   **A:** Use Jenkins credentials plugin and environment variables, avoid hardcoding secrets.

5. **Q:** How do you scale Jenkins for large teams?
   **A:** Use distributed agents, containerized builds, and optimize job configurations.

6. **Q:** How do you integrate Jenkins with GitHub?
   **A:** Use GitHub plugin, webhooks for triggers, and configure OAuth for authentication.

7. **Q:** How do you implement parallel stages in Jenkins?
   **A:** Use the `parallel` directive in declarative pipelines.

8. **Q:** How do you monitor Jenkins jobs?
   **A:** Use plugins like Monitoring, Prometheus, and set up alerts for failures.

9. **Q:** How do you automate rollback in Jenkins?
   **A:** Implement health checks post-deployment and trigger rollback stage on failure.

10. **Q:** How do you manage plugin updates in Jenkins?
   **A:** Test updates in staging, review changelogs, and automate updates via scripts.

### Git Strategy
1. **Q:** What is Git Flow and how does it help CI/CD?
   **A:** Git Flow organizes branches for features, releases, and hotfixes, enabling structured CI/CD pipelines.

2. **Q:** How do you enforce branch protection in Git?
   **A:** Use protected branches, require PR reviews, and restrict direct pushes.

3. **Q:** How do you automate merges in Jenkins?
   **A:** Use pipeline scripts to merge feature branches after successful builds.

4. **Q:** How do you handle release tagging?
   **A:** Automate tagging in Jenkins post successful build/deploy.

5. **Q:** How do you resolve merge conflicts in CI/CD?
   **A:** Detect conflicts during build, notify developers, and require manual resolution.

6. **Q:** How do you manage multiple environments in Git?
   **A:** Use environment branches or tags, and automate deployments via Jenkins.

7. **Q:** How do you integrate Git hooks with Jenkins?
   **A:** Use hooks to trigger Jenkins jobs on commit or push events.

8. **Q:** How do you handle large binary files in Git?
   **A:** Use Git LFS and store artifacts in Artifactory.

9. **Q:** How do you automate changelog generation?
   **A:** Use tools like conventional-changelog and integrate with Jenkins.

10. **Q:** How do you manage submodules in Jenkins pipelines?
   **A:** Use `checkout` step with submodule options in pipeline scripts.

### Pipeline Stages
1. **Q:** What are the essential stages in a Jenkins pipeline?
   **A:** Checkout, Build, Test, Package, Publish, Deploy, Rollback.

2. **Q:** How do you run tests in parallel?
   **A:** Use the `parallel` directive in pipeline scripts.

3. **Q:** How do you handle failed deployments?
   **A:** Trigger rollback, notify stakeholders, and analyze failure causes.

4. **Q:** How do you deploy to multiple environments?
   **A:** Use parameterized pipelines and environment-specific stages.

5. **Q:** How do you ensure reproducible builds?
   **A:** Use locked dependencies, versioned artifacts, and immutable environments.

6. **Q:** How do you automate notifications?
   **A:** Integrate with Slack, email, or other tools via plugins.

7. **Q:** How do you handle flaky tests?
   **A:** Isolate flaky tests, rerun on failure, and improve test reliability.

8. **Q:** How do you manage pipeline failures?
   **A:** Use post actions, error handling, and automated alerts.

9. **Q:** How do you optimize pipeline performance?
   **A:** Use caching, parallelism, and efficient resource allocation.

10. **Q:** How do you document pipeline processes?
   **A:** Maintain pipeline-as-code, inline comments, and external documentation.

### Rollback
1. **Q:** What triggers a rollback in Jenkins?
   **A:** Failed deployment, failed health checks, or manual intervention.

2. **Q:** How do you implement rollback in pipelines?
   **A:** Add a rollback stage that redeploys the previous stable artifact.

3. **Q:** How do you ensure rollback safety?
   **A:** Test rollback procedures, maintain backups, and automate verification.

4. **Q:** How do you handle database rollbacks?
   **A:** Use migration tools, versioned scripts, and backup/restore strategies.

5. **Q:** How do you notify teams of rollbacks?
   **A:** Automate notifications via Jenkins plugins.

6. **Q:** How do you rollback in blue-green deployments?
   **A:** Switch traffic back to the previous environment.

7. **Q:** How do you rollback in canary releases?
   **A:** Stop rollout and revert to previous version for all users.

8. **Q:** How do you track rollback history?
   **A:** Log rollback events and maintain audit trails.

9. **Q:** How do you automate rollback testing?
   **A:** Include rollback scenarios in pipeline tests.

10. **Q:** How do you handle partial rollbacks?
   **A:** Identify affected components and selectively revert changes.

### Artifactory Use
1. **Q:** What is Artifactory and why use it?
   **A:** Artifactory is a universal artifact repository for storing build outputs, dependencies, and release packages.

2. **Q:** How do you publish artifacts to Artifactory in Jenkins?
   **A:** Use Artifactory plugin or REST API in pipeline scripts.

3. **Q:** How do you manage artifact versions?
   **A:** Use semantic versioning and automate versioning in pipelines.

4. **Q:** How do you secure Artifactory access?
   **A:** Use credentials plugin and restrict repository permissions.

5. **Q:** How do you clean up old artifacts?
   **A:** Automate cleanup policies and use retention rules in Artifactory.

6. **Q:** How do you resolve dependencies from Artifactory?
   **A:** Configure build tools (Maven, Gradle) to use Artifactory as a repository.

7. **Q:** How do you integrate Artifactory with Docker?
   **A:** Use Artifactory as a Docker registry and configure Jenkins pipelines accordingly.

8. **Q:** How do you handle failed artifact uploads?
   **A:** Implement error handling and retry logic in pipeline scripts.

9. **Q:** How do you audit artifact usage?
   **A:** Use Artifactory's audit logs and reporting features.

10. **Q:** How do you automate artifact promotion?
   **A:** Use pipeline scripts to move artifacts between repositories based on quality gates.

---

**References:**
- [Jenkins Official Documentation](https://www.jenkins.io/doc/)
- [Jenkins Pipeline](https://www.jenkins.io/doc/book/pipeline/)
- [Artifactory Documentation](https://jfrog.com/artifactory/)
- [Git Strategies](https://www.atlassian.com/git/tutorials/comparing-workflows)
- [Release Engineering](https://martinfowler.com/articles/continuousIntegration.html)
