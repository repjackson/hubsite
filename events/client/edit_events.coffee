selected_type_of_event_tags = new ReactiveArray []

Template.edit_event.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'event', FlowRouter.getParam('event_id')
        # self.subscribe 'tags', selected_type_of_event_tags.array(),"event"


# Template.edit_event.onRendered ->

Template.edit_event.helpers
    event: ->
        # docId = FlowRouter.getParam('event_id')
        Docs.findOne FlowRouter.getParam('event_id')
    
    type_button_class: (type)->
        # console.log type.hash.type.toString() 
        if @type is type.hash.type.toString() then 'active' else 'basic'

    settings: ->
        {
            position: 'bottom'
            limit: 10
            rules: [
                {
                    # token: ''
                    collection: Tags
                    field: 'name'
                    matchAll: true
                    template: Template.tag_result
                }
            ]
        }
    type_of_event_cloud: -> 
        Tags.find()
    
    selected_type_of_event_tags: ->
        selected_type_of_event_tags.array()
        
        
Template.edit_event.events
    'click #delete_event': ->
        swal {
            title: 'Delete event?'
            text: 'Confirm delete?'
            type: 'error'
            showCancelButton: true
            closeOnConfirm: true
            cancelButtonText: 'No'
            confirmButtonText: 'Delete'
            confirmButtonColor: '#da5347'
        }, ->
            Meteor.call 'delete_event', FlowRouter.getParam('event_id'), (error, result) ->
                if error
                    console.error error.reason
                else
                    FlowRouter.go '/events'

    'autocompleteselect #add_type_of_event_tag': (event, template, doc) ->
        # console.log 'selected ', doc
       Docs.update FlowRouter.getParam("event_id"), 
            $addToSet: tags: doc.name
        $('#add_type_of_event_tag').val('')
        selected_type_of_event_tags.push doc.name



    'keydown #add_event_tag': (e,t)->
        switch e.which
            when 13
                event_id = FlowRouter.getParam('event_id')
                tag = $('#add_event_tag').val().toLowerCase().trim()
                if tag.length > 0
                    Docs.update event_id,
                        $addToSet: tags: tag
                    $('#add_event_tag').val('')

    'click .event_tag': (e,t)->
        event = Docs.findOne FlowRouter.getParam('event_id')
        tag = @valueOf()
        if tag is event.type
            Docs.update FlowRouter.getParam('event_id'),
                $set: type: ''
        Docs.update FlowRouter.getParam('event_id'),
            $pull: tags: tag
        $('#add_event_tag').val(tag)


    'click .type_button': (e,t)->
        current_type = @type
        machine_type = e.currentTarget.id
        type = e.currentTarget.innerHTML.trim().toLowerCase()
        Docs.update FlowRouter.getParam('event_id'),
            $pull: tags: current_type
        Docs.update FlowRouter.getParam('event_id'),
            $set: type: machine_type
            $addToSet: tags: type

    'click #save_event': ->
        title = $('#title').val()
        description = $('#description').val()
        start_date = $('#start_date').val()
        end_date = $('#end_date').val()
        Docs.update FlowRouter.getParam('event_id'),
            $set:
                description: description
                start_date: start_date
                end_date: end_date
                title: title
                # tagCount: @tags.length
        selected_event_tags.clear()
        for tag in @tags
            selected_event_tags.push tag
        FlowRouter.go '/events'


    'click .select_type_of_event_tag': -> 
        selected_type_of_event_tags.push @name
        Docs.update FlowRouter.getParam("event_id"), 
            $addToSet: tags: @name

    'click .unselect_type_of_event_tag': -> 
        selected_type_of_event_tags.remove @valueOf()

    'click #clear_type_of_event_tags': -> 
        selected_type_of_event_tags.clear()


    # 'blur #title': ->
    #     # title = $('#title').val()
    #     # if title.length is 0
    #     #     swal 'Must include title'
    #     # else
    #     Docs.update FlowRouter.getParam('event_id'),
    #         $set: title: title

Template.edit_event.onRendered ->
    Meteor.setTimeout (->
        $('#description').froalaEditor
            heightMin: 200
            # toolbarInline: true
            # toolbarButtonsMD: ['bold', 'italic', 'fontSize', 'undo', 'redo', '|', 'insertImage', 'insertVideo','insertFile']
            # toolbarButtonsSM: ['bold', 'italic', 'fontSize', 'undo', 'redo', '|', 'insertImage', 'insertVideo','insertFile']
            # toolbarButtonsXS: ['bold', 'italic', 'fontSize', 'undo', 'redo', '|', 'insertImage', 'insertVideo','insertFile']
            toolbarButtons: 
                [
                  'fullscreen'
                  'bold'
                  'italic'
                  'underline'
                  'strikeThrough'
                  'subscript'
                  'superscript'
                #   'fontFamily'
                #   'fontSize'
                  '|'
                  'color'
                  'emoticons'
                #   'inlineStyle'
                #   'paragraphStyle'
                  '|'
                  'paragraphFormat'
                  'align'
                  'formatOL'
                  'formatUL'
                  'outdent'
                  'indent'
                  'quote'
                  'insertHR'
                  '-'
                  'insertLink'
                  'insertImage'
                  'insertVideo'
                  'insertFile'
                  'insertTable'
                  'undo'
                  'redo'
                  'clearFormatting'
                  'selectAll'
                  'html'
                ]
        ), 500

    Meteor.setTimeout (->
        $('#start_date').datetimepicker(
            onChangeDateTime: (dp,$input)->
                val = $input.val()

                # console.log moment(val).format("dddd, MMMM Do YYYY, h:mm:ss a")
                minute = moment(val).minute()
                hour = moment(val).format('h')
                date = moment(val).format('Do')
                ampm = moment(val).format('a')
                weekdaynum = moment(val).isoWeekday()
                weekday = moment().isoWeekday(weekdaynum).format('dddd')

                month = moment(val).format('MMMM')
                year = moment(val).format('YYYY')

                # datearray = [hour, minute, ampm, weekday, month, date, year]
                datearray = [weekday, month, date]
                datearray = _.map(datearray, (el)-> el.toString().toLowerCase())
                # datearray = _.each(datearray, (el)-> console.log(typeof el))

                docid = FlowRouter.getParam 'event_id'

                doc = Docs.findOne docid
                tagsWithoutDate = _.difference(doc.tags, doc.datearray)
                tagsWithNew = _.union(tagsWithoutDate, datearray)

                Docs.update docid,
                    $set:
                        tags: tagsWithNew
                        datearray: datearray
                        start_date: val
            )
            
        $('#end_date').datetimepicker()    
        ), 500
