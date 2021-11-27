Class {
	#name : #SiotServer,
	#superclass : #Object,
	#instVars : [
		'teapot'
	],
	#category : #'SmartIOT-Server'
}

{ #category : #accessing }
SiotServer >> initialize [

	teapot := Teapot on
		          after: '/*' -> [ :req :resp | 
				          resp headers at: 'Access-Control-Allow-Origin' put: '*' ];
		          GET: '/hi' -> 'Bonjour!';
		          GET: '/hi/<user>' -> [ :req | 'Hello ' , (req at: #user) ];
		          GET: '/hostID/<host>' -> [ :req | 
				          | hostId |
				          hostId := req at: #host.
				          SiotController getHost.
				          'HostID ' , hostId ];
		          GET: '/stayID/<stay>' -> [ :req | 
				          | stayID stay |
				          stayID := req at: #stay.
				          stay := SiotController getStayById: stayID.
				          stay serializeToJson ];
		          GET: '/guestID/<guest>' -> [ :req | 
				          | guestID guest |
				          guestID := req at: #guest.
				          guest := SiotController getGuestById: guestID.
				          'GuestID ' , guest id asString ];
		          GET: '/aggregatedRealPerDay/<stay>' -> [ :req | 
				          | measurements stayID stay |
				          stayID := req at: #stay.
				          stay := SiotController getStayById: stayID.
				          measurements := SiotMeasurementCollection
					                          examplePeriod1DayFrom: stay from
					                          to: stay to.
				          measurements serializeToJson ];
		          GET:
			          '/dissagregatedRealPerDay/stayID/<stay>/deviceID/<device>/useAI/<ai>'
			          -> [ :req | 
				          | measurements |
				          measurements := SiotController
					                          getMeasurementsForStay: (req at: #stay)
					                          device: (req at: #device)
					                          aiDissaggregation: (req at: #ai)
					                          period: 3600 * 24.
				          measurements serializeToJson ];
		          yourself
]

{ #category : #accessing }
SiotServer >> start [
	teapot start
]

{ #category : #accessing }
SiotServer >> stop [
	teapot stop
]
