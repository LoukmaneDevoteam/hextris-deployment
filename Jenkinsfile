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
  ],
  imagePullSecrets: ['dockercred'],
  namespace: 'jenkins',
  serviceAccount: 'jenkins'
) {
  node(POD_LABEL) {

    stage('Checkout Source') {
      container('kaniko') {
        checkout scm
      }
    }

    stage('Build and Push to DockerHub') {
      container('kaniko') {
        sh '''
          echo "=== Starting Kaniko Docker build and push ==="
          /kaniko/executor \
            --context `pwd` \
            --dockerfile `pwd`/Dockerfile \
            --destination loukman50/hextris:latest \
            --verbosity=info
          echo "=== Docker build and push completed ==="
        '''
      }
    }

  }
}
