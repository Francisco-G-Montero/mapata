enum MarkerType { LOST, TRANSITO, REFUGIO }

const String lostImageUrl = "assets/markers/icon_perdido.png";
const String transitoImageUrl = "assets/markers/icon_transito.png";
const String refugioImageUrl = "assets/markers/icon_refugio.png";

class MarkerUtil {
  static String getMarkerImageByType(MarkerType markerType) {
    switch (markerType) {
      case MarkerType.LOST:
        return lostImageUrl;
      case MarkerType.TRANSITO:
        return transitoImageUrl;
      case MarkerType.REFUGIO:
        return refugioImageUrl;
    }
  }
}
