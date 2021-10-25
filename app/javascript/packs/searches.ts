import * as $ from "jquery"

function ready(cb: () => void) {
    if (document.readyState !== 'loading') {
        cb()
    } else {
        document.addEventListener('DOMContentLoaded', cb)
    }
}

ready(() => {
    const filterForm = $('#table_filter form').get(0)
    const filterSelect = $('#table_filter form select').get(0)

    $(filterSelect).on('change', () => $(filterForm).trigger('submit'))
})