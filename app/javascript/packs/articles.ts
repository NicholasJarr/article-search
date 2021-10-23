import { delay, fromEvent, map, of, race, switchMap } from "rxjs"
import * as $ from "jquery"

const SEARCH_DEBOUNCE_TIME = 500

interface Article {
    id: number;
    title: string;
    body: string;
}

function ready(cb: () => void) {
    if (document.readyState !== 'loading') {
        cb()
    } else {
        document.addEventListener('DOMContentLoaded', cb)
    }
}

function setUrlParameter(key: string, val: string) {
    if (window.history.pushState) {
        const params = new URLSearchParams(window.location.search)
        params.set(key, val)
        
        var newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname + "?" + params.toString()
        window.history.pushState({ path: newUrl }, '', newUrl)
    }
}

async function getArticles(query: string): Promise<Article[]> {
    try {
        const res = await fetch(`/articles?query=${query}`, {
            headers: {
                'Accept': 'application/json'
            }
        })
        return await res.json() as Article[]
    } catch (err) {
        console.error(err)
        return []
    }
}

function startLoading(el: HTMLDivElement) {
    $(el).empty()
    $("<p>Loading...</p>").appendTo(el)
}

function renderArticles(el: HTMLDivElement, articles: Article[]) {
    $(el).empty()

    if (!articles.length) {
        $("<p>No articles available</p>").appendTo(el)
        return
    }

    $("<ul>").append(
        articles.map(a =>
            $("<li>")
                .append($("<span id='title'>").text(a.title))
                .append($("<p id='body'>").text(a.body)))
    ).appendTo(el)
}

ready(() => {
    const searchBox = $<HTMLInputElement>('#search_box input[name="query"]').get(0)
    const searchForm = $<HTMLFormElement>('#search_box form').get(0)
    const searchResults = $<HTMLDivElement>("#search_results").get(0)
    
    $(searchForm).on('submit', e => e.preventDefault())

    fromEvent(searchBox, 'input').pipe(
        switchMap(() => race(
            of(1).pipe(delay(SEARCH_DEBOUNCE_TIME)),
            fromEvent(searchForm, 'submit').pipe(
                map(e => {
                    e.preventDefault()
                    return e
                })),
        )),
        map(() => {
            setUrlParameter('query', searchBox.value)
            return searchBox.value
        }),
        switchMap(query => {
            startLoading(searchResults)
            return getArticles(query)
        })
    ).subscribe({
        next: articles => {
            renderArticles(searchResults, articles)
        }
    })
})