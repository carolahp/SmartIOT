Class {
	#name : #SiotGuest,
	#superclass : #SiotPerson,
	#category : #'SmartIOT-Entities'
}

{ #category : #examples }
SiotGuest class >> example1 [
	^ self new
		id: 1;
		name: 'Aless Hosry';
		yourself
]

{ #category : #examples }
SiotGuest class >> example2 [
	^ self new
		id: 2;
		name: 'Carolina Hernandez';
		yourself
]

{ #category : #examples }
SiotGuest class >> example3 [
	^ self new
		id: 3;
		name: 'Oleks Zaitsev';
		yourself
]
