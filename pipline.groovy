pipelineJob('grafana pipline') {

    def repo = 'https://github.com/Jouda-Hidri/demo.git'
   
    triggers {
        scm('*/5 * * * *')
    }
    
    definition {
        cpsScm {
          scm {
            git(repo, 'master', { node -> node / 'extensions' << '' } )
            }
        }
    }
}