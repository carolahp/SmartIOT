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
		          GET: '/hi' -> 'Bonjour!';
		          GET: '/hi/<user>' -> [ :req | 'Hello ' , (req at: #user) ];
		          GET: '/hostID/<host>' -> [ :req | | hostId |
						hostId := req at: #host.
						SiotController getHost.
						'HostID ' , hostId ];
					GET: '/stayID/<stay>' -> [ :req | | stayID stay |
						stayID := req at: #stay.
						stay := SiotController getStayById: stayID.
						stay serializeToJson ];
					GET: '/guestID/<guest>' -> [ :req | | guestID guest |
						guestID := req at: #guest.
						guest := SiotController getGuestById: guestID.
						'GuestID ' , guest id asString ];
					GET: '/exampleMeasurement' -> [ :req | | measurement |
						measurement := SiotMeasurement example1.
						measurement serializeToJson ];
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
