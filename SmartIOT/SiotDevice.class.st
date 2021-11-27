Class {
	#name : #SiotDevice,
	#superclass : #Object,
	#instVars : [
		'id',
		'name'
	],
	#category : #'SmartIOT-Entities'
}

{ #category : #examples }
SiotDevice class >> example1 [
	^ self new
		id: 1;
		name: 'Cooker';
		yourself
]

{ #category : #examples }
SiotDevice class >> example2 [
	^ self new
		id: 2;
		name: 'TV';
		yourself
]

{ #category : #examples }
SiotDevice class >> example3 [
	^ self new
		id: 3;
		name: 'Kitchen rack';
		yourself
]
