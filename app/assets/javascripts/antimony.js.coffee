$ ->
  $('div#flash').click ->
    $(this).fadeOut()
  $('a.close').click ->
    $(this).parent().fadeOut()
  $('.state-button').button()
  $('.state-button').click ->
    $(this).button('loading')
  $('a.fbGallery').fancybox(
      prevEffect: 'none'
      nextEffect: 'none'
      closeBtn: false

      maxHeight: 600
      maxWidth: 800

    )
  selectedPhotos = []
  $('div.selectable_photo').click ->
    $(this).toggleClass('selected')
    selectedPhotos.push($(this).attr("id"))
    checkbox = '#cb' + $(this).attr('id')
    $(checkbox).prop('checked', true)

  selectedGallery = null
  $('div.selectable_gallery').click ->
    clickedId = $(this).attr('id')
    $('div.selectable_gallery').removeClass('selected')
    $('div.selectable_gallery :checkbox').prop('checked', false)

    if selectedGallery isnt clickedId
      $(this).toggleClass('selected')
      checkbox = '#cb' + clickedId
      $(checkbox).prop('checked', true)
      selectedGallery = clickedId


  $('li.delete_image_thumbnail').click ->
    modalId = "#deleteModal" + $(this).attr('id')
    $(modalId).modal()