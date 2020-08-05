pipelineJob('grafana pipline') {

    def repo = 'https://github.com/houssem-tebai/grafana'
   
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