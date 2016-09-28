Template.join.events
    'click #launch_modal': ->
        $('.ui.modal').modal('show')

Template.join.onRendered ->
    $('#join_slider').layerSlider
        autoStart: true
        firstLayer: 2
        # skin: 'borderlesslight'
        # skinsPath: '/static/layerslider/skins/'

