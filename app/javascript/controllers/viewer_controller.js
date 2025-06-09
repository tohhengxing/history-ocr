import { Controller } from "@hotwired/stimulus"
import OpenSeadragon from "openseadragon"
import {createOSDAnnotator, UserSelectAction} from "@annotorious/openseadragon";

export default class extends Controller {
    static targets = ["container"]
    static values = { imageUrl: String, annotations: String }

    allAnnotations = []

    connect() {
        console.log(this.annotationsValue)
        this.viewer = OpenSeadragon({
            id: this.containerTarget.id,
            prefixUrl: "https://cdn.jsdelivr.net/npm/openseadragon@4/build/openseadragon/images/",
            tileSources: {
                type: 'image',
                url: this.imageUrlValue
            },
            showFullPageControl: false,
            gestureSettingsMouse: {
                clickToZoom: false
            }
        })

        this.anno = createOSDAnnotator(this.viewer, {
            drawingEnabled: false,
            userSelectAction: UserSelectAction.SELECT,
            style: {
                fill: '#ff0000',
                fillOpacity: 0.25
            }
        });

        this.allAnnotations = JSON.parse(this.annotationsValue)
        this.anno.setAnnotations(this.allAnnotations)

    }

    disconnect() {
        if (this.viewer) {
            this.viewer.destroy()
        }
    }
}
