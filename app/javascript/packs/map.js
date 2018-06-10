// app/javascript/packs/map.js
import GMaps from 'gmaps/gmaps.js';
import { autocomplete } from '../components/autocomplete';
import { batesGreen } from '../components/map_styles/bates_green';
import { neonWorld } from '../components/map_styles/neon_world';
import { holiday } from '../components/map_styles/holiday';
import { colorBlindFriendly } from '../components/map_styles/colorblind_friendly';
import { brightDessert } from '../components/map_styles/bright_dessert';
import { flatColors } from '../components/map_styles/flat_colors';
import { pokemon } from '../components/map_styles/pokemon';
import { appleLike } from '../components/map_styles/apple_like';
import { bikes } from '../components/map_styles/bikes';
import { blueMap } from '../components/map_styles/blue_map';

const styles = blueMap;


const mapElement = document.getElementById('map');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
    const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    const markers = JSON.parse(mapElement.dataset.markers);
    map.addMarkers(markers);
    if (markers.length === 0) {
        map.setZoom(2);
    } else if (markers.length === 1) {
        map.setCenter(markers[0].lat, markers[0].lng);
        map.setZoom(14);
    } else {
        map.fitLatLngBounds(markers);
    }
    map.addStyle({
        styles: styles,
        mapTypeId: 'map_style'
    });
    map.setStyle('map_style');

}


// [...]
autocomplete();

// app/javascript/packs/map.js
// [...]