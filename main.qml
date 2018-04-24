import QtQuick 2.10
import QtQuick.Window 2.10
import QtLocation 5.9
import QtPositioning 5.8

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Plugin {
        id: mapPlugin
        name: "mapbox"
        PluginParameter {
            name: "mapbox.access_token"
            value: MAPBOX_ACCESS_TOKEN
        }
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(43.108797, 12.388584) // Perugia
        zoomLevel: 14
        RouteQuery {
            id: routeQuery
            travelModes: RouteQuery.PedestrianTravel
            routeOptimizations: RouteQuery.MostScenicRoute
        }

        RouteModel {
            id: routeModel
            plugin: mapPlugin
            query: routeQuery
            onStatusChanged: {
            }
        }

        Component {
            id: routeDelegate

            MapRoute {
                id: route
                route: routeData
                line.color: "orange"
                line.width: 4
                smooth: true
                opacity: 1
            }
        }

        MapItemView {
            model: routeModel
            delegate: routeDelegate
            autoFitViewport: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                var startCoords = map.toCoordinate(Qt.point(mouse.x, mouse.y), true)
                routeQuery.clearWaypoints();
                routeQuery.addWaypoint(startCoords);
                routeQuery.addWaypoint(
                    QtPositioning.coordinate(43.114634, 12.389725)
                );

                routeModel.update();
            }
        }
    }
}
