import OpenSeadragon from 'openseadragon';
import { createOSDAnnotator } from '@annotorious/openseadragon';

// Import essential CSS styles
import '@annotorious/openseadragon/annotorious-openseadragon.css';
import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["container", "enableDraw", "disableDraw", "annotatorField"]
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
            showFullPageControl: false
        })

        this.anno = createOSDAnnotator(this.viewer, {
            drawingEnabled: false,
            style: {
                fill: '#ff0000',
                fillOpacity: 0.25
            }
        });

        if (this.annotatorFieldTarget.value) {
            this.allAnnotations = JSON.parse(this.annotatorFieldTarget.value)
            this.allAnnotations.forEach(ann => this.anno.addAnnotation(ann));
        }

        // await this.anno.loadAnnotations('/test.json')


        this.anno.on('createAnnotation',  (annotation) => {
            console.log('created', annotation);
            this.allAnnotations.push(annotation)
            this.annotatorFieldTarget.value = JSON.stringify(this.allAnnotations)
            console.log(this.annotatorFieldTarget.value)
        });

        this.anno.on('clickAnnotation', (annotation, originalEvent) => {
            console.log('Annotation clicked: ' + annotation.id);
        });


     }

    enableDrawing() {
        this.anno.setDrawingEnabled(true);
    }

    updateField() {
        this.annotatorFieldTarget.value = JSON.stringify(this.allAnnotations)
        console.log(this.annotatorFieldTarget.value)
    }

    disableDrawing() {
        this.anno.setDrawingEnabled(false);
        this.anno.on('clickAnnotation', (annotation, originalEvent) => {
            console.log('Annotation clicked: ' + annotation.id);
        });
    }

    disconnect() {
        if (this.viewer) {
            this.viewer.destroy()
            this.anno.destroy()
        }
    }
}