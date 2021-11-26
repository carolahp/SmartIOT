Class {
	#name : #SiotMeasurementTest,
	#superclass : #TestCase,
	#category : #'SmartIOT-Server'
}

{ #category : #tests }
SiotMeasurementTest >> testSerializeToJson [

	| point ts |
	ts := DateAndTime
		      year: 2012
		      month: 2
		      day: 14
		      hour: 16
		      minute: 40
		      second: 18
		      offset: 1 hour.

	point := SiotMeasurement new
		         timestamp: ts;
		         current: 200.003212;
		         power: 888.000988;
		         voltage: 999.004343;
		         yourself.
	self
		assert: point serializeToJson
		equals:
		'{"timestamp":"2012-02-14T16:40:18+01:00","current":200.003212,"power":888.000988,"voltage":999.004343}'
]
