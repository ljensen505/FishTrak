FISHERMEN = {
    '1': {
        'name': 'Hank'
    },
    '2': {
        'name': 'Dale'
    },
    '3': {
        'name': 'Bobbeh'
    }
}

LURES = {
    '1': {
        'weight': .75,
        'name': 'KVD Red Eye Shad',
        'color': 'chartreuse',
        'type': 'Lipless Crankbait'
    },
    '2': {
        'weight': .25,
        'name': 'Senko',
        'color': 'purple',
        'type': 'Drop Shot'
    },
    '3': {
        'weight': 1.0,
        'name': 'Daredevil',
        'color': 'yellow/red',
        'type': 'Spoon'
    },
}

SPECIES = {
    '1': {
        'name': 'largemouth bass',
        'avg_weight': 5,
        'is_freshwater': True,
        'description': 'A common target for sport fishers'
    },
    '2': {
        'name': 'bluegill',
        'avg_weight': 1,
        'is_freshwater': True,
        'description': 'Delicious fired up!'
    },
    '3': {
        'name': 'channel cat',
        'avg_weight': 17,
        'is_freshwater': True,
        'description': 'A common night time target'
    }
}

BODIES_OF_WATER = {
    '1': {
        'is_freshwater': True,
        'is_stocked': False,
        'latitude': 42.405457,
        'longitude': -85.414040,
        'name': 'gull lake'
    },
    '2': {
        'is_freshwater': True,
        'is_stocked': False,
        'latitude': 42.378229,
        'longitude': -85.181098,
        'name': "st. mary's lake"
    },
    '3': {
        'is_freshwater': True,
        'is_stocked': True,
        'latitude': 42.3949159,
        'longitude': -85.268510,
        'name': 'kazoo river'
    },
}

CAUGHT_FISH = {
    '1': {
        'species_id:': 1,
        'body_of_water_id': 1,
        'lure_id': None,
        'fisherman_id': 1,
        'weight': 5
    },
    '2': {
        'species_id:': 1,
        'body_of_water_id': 1,
        'lure_id': 2,
        'fisherman_id': 1,
        'weight': 4
    },
    '3': {
        'species_id:': 1,
        'body_of_water_id': 1,
        'lure_id': 3,
        'fisherman_id': 1,
        'weight': None
    },
    '4': {
        'species_id:': 2,
        'body_of_water_id': 1,
        'lure_id': None,
        'fisherman_id': 1,
        'weight': 1
    },
    '5': {
        'species_id:': 3,
        'body_of_water_id': 2,
        'lure_id': 1,
        'fisherman_id': 1,
        'weight': 20
    },
    '6': {
        'species_id:': 3,
        'body_of_water_id': 2,
        'lure_id': 2,
        'fisherman_id': 2,
        'weight': 12
    },
    '7': {
        'species_id:': 3,
        'body_of_water_id': 2,
        'lure_id': 1,
        'fisherman_id': 2,
        'weight': None
    },
    '8': {
        'species_id:': 3,
        'body_of_water_id': 3,
        'lure_id': 1,
        'fisherman_id': 3,
        'weight': 16
    },
}
