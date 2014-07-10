#ui-scroll-fixed
Allows an element to scroll naturally to a certain position on the screen and then
remain fixed there for any scroll position below that.  Useful for sidebars etc
where initially scrolling but then locking into place is sometimes desirable.

    Polymer 'ui-scroll-fixed',

##Attributes and Change Handlers
####offset
The height from the top of the viewport that the element will fix to.

##Event Handlers
####onScroll

      onScroll: (evt) ->
        offset = parseInt(@offset || 0)

        console.log "offset", offset, @offset
        scrollTop = window.scrollY
        top = @.getBoundingClientRect().top

        # Fix the element in place if it's scrolled past the fixed offset
        if !@.fixed && top < offset
            @.fixed = true
            @.fixedFrom = @.offsetTop

            # before we fix the element we capture it's rendered width and apply
            # it (since it may have been block rendered and taking up more than
            # it would as a fixed position element)
            width = @.offsetWidth
            @.style.position = 'fixed'
            @.style.top = "#{offset}px"
            @.style.width = "#{width}px"

        #  Or unfix the element if it's original scroll position would be higher
        else if @.fixed and scrollTop + offset < @.fixedFrom
          @.style.position = 'static'
          @.fixed = false
          @.style.width = 'auto'

##Polymer Lifecycle

      attached: ->
        window.addEventListener 'scroll', (evt) => @onScroll(evt)

      detached: ->
        window.removeEventListener 'scroll', (evt) => @onScroll(evt)
