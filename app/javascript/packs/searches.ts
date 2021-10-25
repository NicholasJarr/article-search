import * as $ from "jquery"

$(() => {
    const filterForm = $('#table_filter form').get(0)
    const filterSelect = $('#table_filter form select').get(0)

    $(filterSelect).on('change', () => $(filterForm).trigger('submit'))
})