public with sharing class  Response {
    public String message;
    public Event eventRec;
    public Response(String message, Event eventRec) {
        this.message = message;
        this.eventRec = eventRec;
    }
}