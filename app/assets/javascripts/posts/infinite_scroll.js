$(document).on('turbolinks:load', function() {
    var isLoading = false;
    if ($('.infinite-scroll', this).size() > 0) {
        $(window).on('scroll', function() {
            var more_posts_url = $('.pagination a.next_page').attr('href');
            var threshold_passed = $(window).scrollTop() > $(document).height() - $(window).height() - 60;
            if (!isLoading && more_posts_url && threshold_passed) {
                isLoading = true;
                $.getScript(more_posts_url).done(function (data,textStatus,jqxhr) {
                    isLoading = false;
                }).fail(function() {
                    isLoading = false;
                });
            }
        });
    }
});

//The isLoading variable makes sure that only one request is sent at a time. If there  is currently a request in progress, other requests won’t be initiated.
// First check if pagination is present, if there are any more posts to render.  Next, get a link to the next page, this is where the data will be  retrieved from.
// Then set a threshold when to call an AJAX request,
// in this case the threshold is 60px from the bottom of the window. Finally, if all conditions successfully pass, load data from the next page using the getScript() function.
// Because the getScript() function loads the JavaScript file, we have to specify which file to render inside the PostsController.
// Inside the posts_for_branchmethod specify respond_to formats and which files to render.