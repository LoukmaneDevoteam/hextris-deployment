podTemplate(
  containers: [
    containerTemplate(
      name: 'kaniko',
      image: 'gcr.io/kaniko-project/executor:debug',
      command: 'sleep',
      args: '99d'
    )
  ],
  volumes: [
    emptyDirVolume(mountPath: '/workspace', memory: false)
  ]
) {
  node(POD_LABEL) {

    stage('Checkout Source') {
      container('kaniko') {
        checkout scm
      }
    }

    stage('Build Docker Image (no push)') {
      container('kaniko') {
        sh '''
          echo "=== Starting Kaniko Docker build ==="
          /kaniko/executor \
            --context `pwd` \
            --dockerfile `pwd`/Dockerfile \
            --destination dummy/hextris:latest \
            --no-push \
            --verbosity=info
          echo "=== Docker build completed ==="
        '''
      }
    }

  }
}
