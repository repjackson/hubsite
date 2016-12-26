
Template.slider.onRendered ->
    $('#layerslider').layerSlider
        autoStart: true
        # firstLayer: 1
        # skin: 'borderlesslight'
        # skinsPath: '/static/layerslider/skins/'


Template.slider2.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'slides'



Template.slider2.onRendered ->
    $('#layerslider').layerSlider
        autoStart: true
        # firstLayer: 1
        # skin: 'borderlesslight'
        # skinsPath: '/static/layerslider/skins/'



Template.slider2.helpers
    slides: -> 
        Docs.find
            tags: $in: ['slide']
            type: 'slide'
