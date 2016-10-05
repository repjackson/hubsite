Template.academy.onRendered ->
    $('#academy_slider').layerSlider
        autoStart: true
        # firstLayer: 2
        # skin: 'borderlesslight'
        # skinsPath: '/static/layerslider/skins/'
    

Template.academy.helpers
    academy_page: ->
        Docs.findOne FlowRouter.getParam('doc_id')
