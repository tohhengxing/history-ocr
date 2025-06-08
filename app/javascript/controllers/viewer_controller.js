import { Controller } from "@hotwired/stimulus"
import OpenSeadragon from "openseadragon"

export default class extends Controller {
    static targets = ["container"]
    static values = { imageUrl: String }

    connect() {
        console.log(this.imageUrlValue)
        this.viewer = OpenSeadragon({
            id: this.containerTarget.id,
            prefixUrl: "https://cdn.jsdelivr.net/npm/openseadragon@4/build/openseadragon/images/",
            tileSources: {
                type: 'image',
                url: this.imageUrlValue
            }
        })
    }

    disconnect() {
        if (this.viewer) {
            this.viewer.destroy()
        }
    }
}
