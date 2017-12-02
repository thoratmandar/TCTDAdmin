$(document).ready(function() {

   $('#carousel').carousel({
      indicators: true,
      padding: 10
    });
// Iterate over each select element
$('select').each(function () {

    // Cache the number of options
    var $this = $(this),
        numberOfOptions = $(this).children('option').length;

    // Hides the select element
    $this.addClass('s-hidden');

    // Wrap the select element in a div
    $this.wrap('<div class="select"></div>');

    // Insert a styled div to sit over the top of the hidden select element
    $this.after('<div class="styledSelect"></div>');

    // Cache the styled div
    var $styledSelect = $this.next('div.styledSelect');

    // Show the first select option in the styled div
    $styledSelect.text($this.children('option').eq(0).text());

    // Insert an unordered list after the styled div and also cache the list
    var $list = $('<ul />', {
        'class': 'options'
    }).insertAfter($styledSelect);

    // Insert a list item into the unordered list for each select option
    for (var i = 0; i < numberOfOptions; i++) {
        $('<li />', {
            text: $this.children('option').eq(i).text(),
            rel: $this.children('option').eq(i).val()
        }).appendTo($list);
    }

    // Cache the list items
    var $listItems = $list.children('li');

    // Show the unordered list when the styled div is clicked (also hides it if the div is clicked again)
    $styledSelect.click(function (e) {
        e.stopPropagation();
        $('div.styledSelect.active').each(function () {
            $(this).removeClass('active').next('ul.options').hide();
        });
        $(this).toggleClass('active').next('ul.options').toggle();
    });

    // Hides the unordered list when a list item is clicked and updates the styled div to show the selected list item
    // Updates the select element to have the value of the equivalent option
    $listItems.click(function (e) {
        e.stopPropagation();
        $styledSelect.text($(this).text()).removeClass('active');
        $this.val($(this).attr('rel'));
        $list.hide();
        /* alert($this.val()); Uncomment this for demonstration! */
    });

    // Hides the unordered list when clicking outside of it
    $(document).click(function () {
        $styledSelect.removeClass('active');
        $list.hide();
    });

});
  var $btnNext = $('.fa-angle-right');
  var $btnPrev = $('.fa-angle-left');
  var $indexPhoto = $('.gallery').find('li');
  var $indexCircle = $('.controls').find('i.fired');
  var $indexPoint = $('.controls').find('li');
  var $gallery = $('.gallery');
  var counter = 1;
  var myInterval = 300000;

  var time = setInterval(changeSlide, myInterval);
  $indexCircle.eq(0).css('display', 'inline-block');

  console.log(counter);

  function changeSlide() {
    $gallery.animate({
      marginLeft: '-1020px'
    }, 500, moveFirstSlide);
    changeCircle();
  }

  function moveFirstSlide() {
    var firstSlide = $gallery.find('li:first');
    $gallery.append(firstSlide);
    $gallery.css('marginLeft', '0');
    $indexPhoto = $gallery.find('li');
  }

  function moveLastSlide() {
    var lastSlide = $gallery.find('li:last');
    $gallery.prepend(lastSlide);
    $gallery.css('marginLeft', '0');
    indexPhoto = $gallery.find('li');
  }

  $btnNext.click(function() {
    $gallery.animate({
      marginLeft: '-1020px'
    }, 500, moveFirstSlide);
    clearInterval(time);
    time = setInterval(changeSlide, myInterval);
    changeCircle();
  });

  $btnPrev.click(function() {
    $gallery.animate({
      marginLeft: '400px'
    }, 500, moveLastSlide);
    clearInterval(time);
    time = setInterval(changeSlide, myInterval);
    changeCircleBack();
  });

  function changeCircle() {
    counter++;
    if (counter > $indexPhoto.length) counter = 1;
    toEmptyCircle();
    $indexCircle.eq(counter - 1).css('display', 'inline-block');
  }

  function toEmptyCircle() {
    $indexCircle.each(function() {
      $(this).css('display', 'none');
    });
  }

  function changeCircleBack() {
    counter--;
    if (counter == 0) counter = $indexPhoto.length;
    toEmptyCircle();
    $indexCircle.eq(counter - 1).css('display', 'inline-block');
  }

  $indexPoint.each(function() {
    $(this).click(function() {
      
      $indexCircle.each(function() {

        $(this).css('display', 'none');
      });
      $(this).find('i').css('display', 'inline-block');

      $getIdPoint = $(this).attr('id');
      moveSlidePoint();

      /*console.log('counter wynosi: ' + counter + ' a distPoint wynosi: ' + distPoint);*/

      clearInterval(time);
      time = setInterval(changeSlide, myInterval);
      counter = $(this).attr('id');
    });
  });

  function moveSlidePoint() {
    if (counter < $getIdPoint) {
      distPoint = $getIdPoint - counter;
      pickGalleryNext(distPoint);
    } 
    else {
      distPoint = counter - $getIdPoint;
      pickGalleryBack(distPoint);
    }
  }

  function pickGalleryNext(num) {
    for (var i = 0; i < num; i++) {
      $gallery.append($gallery.find('li:first'));
    }
  }

  function pickGalleryBack(num) {
    for (var i = 0; i < num; i++) {
      $gallery.prepend($gallery.find('li:last'));
    }
  }
});