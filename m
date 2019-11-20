Content-Type: multipart/mixed; boundary="===============5564853840800377382=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Feedback to the IETF
Date: Wed, 20 Nov 2019 15:52:24 +0800
Message-ID: <9DF9C238-3239-496B-A229-423477DD767A@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 2605

--===============5564853840800377382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I have mentioned to the IETF that the upstreaming effort brought forward so=
me feedback,... to the IETF-draft.

Now, the draft is about to become an RFC very soon. Currently it is in the =
"RFC-Editor" stage, which is the last stage before official publication.

Ideally, we should get feedback to the IETF as soon as possible so that the=
 working-group can make adjustements before publication. Otherwise, it woul=
d need to got through an "Errata" process which means to correct the publis=
hed RFC.


So, let me try to compile a list of things that came up. Please correct or =
add anything:

Clarifying that the reception of a DATA_ACK means that the server successfu=
lly received the MP_CAPABLE (Text "If B has data to send first, then the re=
liable delivery of the ACK can be inferred by the receipt of this data with=
 an MPTCP DATA_ACK inside the DSS option (Section 3.3).)

Should we vouch to disallow early or late DSS mappings that are covering a =
TCP-sequence space different than the packet they are being sent on (cfr., =
our discussion on/around September 25th)

ADD_ADDR-option size - last  week we discussed this briefly and I replied b=
y mail that the size-problem is actually for the non-Echo option. In that o=
ne there is no way to get around it and all the bits need to be presented. =
Do you agree on that?

Anything else?


Cheers,
Christoph


--===============5564853840800377382==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBi
cmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdo
aXRlLXNwYWNlOyIgY2xhc3M9IiI+PGRpdiBkaXI9ImF1dG8iIHN0eWxlPSJ3b3JkLXdyYXA6IGJy
ZWFrLXdvcmQ7IC13ZWJraXQtbmJzcC1tb2RlOiBzcGFjZTsgbGluZS1icmVhazogYWZ0ZXItd2hp
dGUtc3BhY2U7IiBjbGFzcz0iIj5IZWxsbyw8ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rp
dj48ZGl2IGNsYXNzPSIiPkkgaGF2ZSBtZW50aW9uZWQgdG8gdGhlIElFVEYgdGhhdCB0aGUgdXBz
dHJlYW1pbmcgZWZmb3J0IGJyb3VnaHQgZm9yd2FyZCBzb21lIGZlZWRiYWNrLC4uLiB0byB0aGUg
SUVURi1kcmFmdC48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNs
YXNzPSIiPk5vdywgdGhlIGRyYWZ0IGlzIGFib3V0IHRvIGJlY29tZSBhbiBSRkMgdmVyeSBzb29u
LiBDdXJyZW50bHkgaXQgaXMgaW4gdGhlICJSRkMtRWRpdG9yIiBzdGFnZSwgd2hpY2ggaXMgdGhl
IGxhc3Qgc3RhZ2UgYmVmb3JlIG9mZmljaWFsIHB1YmxpY2F0aW9uLjwvZGl2PjxkaXYgY2xhc3M9
IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+SWRlYWxseSwgd2Ugc2hvdWxkIGdl
dCBmZWVkYmFjayB0byB0aGUgSUVURiBhcyBzb29uIGFzIHBvc3NpYmxlIHNvIHRoYXQgdGhlIHdv
cmtpbmctZ3JvdXAgY2FuIG1ha2UgYWRqdXN0ZW1lbnRzIGJlZm9yZSBwdWJsaWNhdGlvbi4gT3Ro
ZXJ3aXNlLCBpdCB3b3VsZCBuZWVkIHRvIGdvdCB0aHJvdWdoIGFuICJFcnJhdGEiIHByb2Nlc3Mg
d2hpY2ggbWVhbnMgdG8gY29ycmVjdCB0aGUgcHVibGlzaGVkIFJGQy48L2Rpdj48ZGl2IGNsYXNz
PSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48
ZGl2IGNsYXNzPSIiPlNvLCBsZXQgbWUgdHJ5IHRvIGNvbXBpbGUgYSBsaXN0IG9mIHRoaW5ncyB0
aGF0IGNhbWUgdXAuIFBsZWFzZSBjb3JyZWN0IG9yIGFkZCBhbnl0aGluZzo8L2Rpdj48ZGl2IGNs
YXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPjx1bCBjbGFzcz0iTWFpbE91
dGxpbmUiPjxsaSBjbGFzcz0iIj5DbGFyaWZ5aW5nIHRoYXQgdGhlIHJlY2VwdGlvbiBvZiBhIERB
VEFfQUNLIG1lYW5zIHRoYXQgdGhlIHNlcnZlciBzdWNjZXNzZnVsbHkgcmVjZWl2ZWQgdGhlIE1Q
X0NBUEFCTEUgKFRleHQgIklmIEIgaGFzIGRhdGEgdG8gc2VuZCBmaXJzdCwgdGhlbiB0aGUgcmVs
aWFibGUgZGVsaXZlcnkgb2YgdGhlIEFDSyBjYW4gYmUgaW5mZXJyZWQgYnkgdGhlIHJlY2VpcHQg
b2YgdGhpcyBkYXRhIHdpdGggYW4gTVBUQ1AgREFUQV9BQ0sgaW5zaWRlIHRoZSBEU1Mgb3B0aW9u
IChTZWN0aW9uIDMuMykuKTwvbGk+PC91bD48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rp
dj48L2Rpdj48ZGl2IGNsYXNzPSIiPjx1bCBjbGFzcz0iTWFpbE91dGxpbmUiPjxsaSBjbGFzcz0i
Ij5TaG91bGQgd2Ugdm91Y2ggdG8gZGlzYWxsb3cgZWFybHkgb3IgbGF0ZSBEU1MgbWFwcGluZ3Mg
dGhhdCBhcmUgY292ZXJpbmcgYSBUQ1Atc2VxdWVuY2Ugc3BhY2UgZGlmZmVyZW50IHRoYW4gdGhl
IHBhY2tldCB0aGV5IGFyZSBiZWluZyBzZW50IG9uIChjZnIuLCBvdXIgZGlzY3Vzc2lvbiBvbi9h
cm91bmQgU2VwdGVtYmVyIDI1dGgpPC9saT48L3VsPjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIi
PjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9IiI+PHVsIGNsYXNzPSJNYWlsT3V0bGluZSI+PGxpIGNs
YXNzPSIiPkFERF9BRERSLW9wdGlvbiBzaXplIC0gbGFzdCAmbmJzcDt3ZWVrIHdlIGRpc2N1c3Nl
ZCB0aGlzIGJyaWVmbHkgYW5kIEkgcmVwbGllZCBieSBtYWlsIHRoYXQgdGhlIHNpemUtcHJvYmxl
bSBpcyBhY3R1YWxseSBmb3IgdGhlIG5vbi1FY2hvIG9wdGlvbi4gSW4gdGhhdCBvbmUgdGhlcmUg
aXMgbm8gd2F5IHRvIGdldCBhcm91bmQgaXQgYW5kIGFsbCB0aGUgYml0cyBuZWVkIHRvIGJlIHBy
ZXNlbnRlZC4gRG8geW91IGFncmVlIG9uIHRoYXQ/PC9saT48L3VsPjxkaXYgY2xhc3M9IiI+PGJy
IGNsYXNzPSIiPjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9IiI+QW55dGhpbmcgZWxzZT88L2Rpdj48
ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0i
Ij48L2Rpdj48ZGl2IGNsYXNzPSIiPkNoZWVycyw8L2Rpdj48ZGl2IGNsYXNzPSIiPkNocmlzdG9w
aDwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjwvZGl2Pgo8L2JvZHk+PC9o
dG1sPg==
--===============5564853840800377382==--
