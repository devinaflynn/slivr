# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#pins').imagesLoaded ->
		$('#pins').masonry
			itemSelector: '.box'
			isFitWidth: true

			$ ->
  
  # BOOTSNIPP FULLSCREEN FIX 
  $("#back-to-bootsnipp").removeClass "hide"  if window.location is window.parent.location
  $("[data-toggle=\"tooltip\"]").tooltip()
  $("#fullscreen").on "click", (event) ->
    event.preventDefault()
    window.parent.location = "http://bootsnipp.com/iframe/4l0k2"
    return

  $("a[href=\"#cant-do-all-the-work-for-you\"]").on "click", (event) ->
    event.preventDefault()
    $("#cant-do-all-the-work-for-you").modal "show"
    return

  $("[data-command=\"toggle-search\"]").on "click", (event) ->
    event.preventDefault()
    $(this).toggleClass "hide-search"
    if $(this).hasClass("hide-search")
      $(".c-search").closest(".row").slideUp 100
    else
      $(".c-search").closest(".row").slideDown 100
    return

  $("#contact-list").searchable
    searchField: "#contact-list-search"
    selector: "li"
    childSelector: ".col-xs-12"
    show: (elem) ->
      elem.slideDown 100
      return

    hide: (elem) ->
      elem.slideUp 100
      return

  return
