Class {
	#name : #SiotServer,
	#superclass : #Object,
	#instVars : [
		'teapot'
	],
	#category : #SmartIOT
}

{ #category : #accessing }
SiotServer >> initialize [
	teapot := Teapot on
		          GET: '/hi' -> 'Bonjour!';
		          GET: '/hi/<user>' -> [ :req | 'Hello ' , (req at: #user) ];
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
