document.addEventListener('turbolinks:load', function () {
    var control = document.querySelector('.progress_bar');
    if (control) { control.addEventListener('click', addProgress()) }
});

function addProgress() {
    var progress = document.querySelector('.progress_bar').dataset.progress;
    document.querySelector('.progress-bar').style.width = progress + '%'
}
