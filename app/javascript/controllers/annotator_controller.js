import OpenSeadragon from 'openseadragon';
import { createOSDAnnotator, UserSelectAction } from '@annotorious/openseadragon';

// Import essential CSS styles
import '@annotorious/openseadragon/annotorious-openseadragon.css';
import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["container", "enableDraw", "disableDraw", "annotatorField", "enableEdit", "disableEdit"]
    static values = { imageUrl: String }

    allAnnotations = []

    async  connect() {
        console.log(this.imageUrlValue)
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

        if (this.annotatorFieldTarget.value) {
            this.allAnnotations = JSON.parse(this.annotatorFieldTarget.value)
            this.anno.setAnnotations(this.allAnnotations)
        }

        this.anno.on('createAnnotation',  (annotation) => {
            this.allAnnotations.push(annotation)
            this.annotatorFieldTarget.value = JSON.stringify(this.allAnnotations)
            console.log(this.annotatorFieldTarget.value)
        });

        this.anno.on('clickAnnotation', (annotation, originalEvent) => {
            console.log('Annotation clicked: ' + JSON.stringify(annotation));
        });

        this.anno.on('updateAnnotation', (updated,previous) => {
            console.log('annotation updated')
            console.log('annotation previous', previous)
            console.log('annotation updated', updated)
        })


     }

    enableDrawing() {
        this.anno.setDrawingEnabled(true);
    }

    enableEdit() {
        this.anno.setUserSelectAction(ann => {
            return UserSelectAction.EDIT
        })
    }

    disableEdit() {
        this.anno.setUserSelectAction(ann => {
            return UserSelectAction.SELECT
        })
    }

    updateField() {
        // this.annotatorFieldTarget.value = JSON.stringify(this.allAnnotations)
        console.log(this.annotatorFieldTarget.value)
    }

    disableDrawing() {
        this.anno.setDrawingEnabled(false);
    }

    disconnect() {
        if (this.viewer) {
            this.viewer.destroy()
            this.anno.destroy()
        }
    }
}