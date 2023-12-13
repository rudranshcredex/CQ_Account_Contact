public class ParkLocator {
    public static String[] country(String country){
        ParksService.ParksImplPort parks = new ParksService.ParksImplPort();
        String[] parksname = parks.byCountry(country);
        return parksname;
    }
}