Content-Type: multipart/mixed; boundary="===============7392603994905322374=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] MPTCP implementation feedback for
 RFC6824bis
Date: Fri, 20 Dec 2019 09:42:35 +0100
Message-ID: <79E2BA51-D593-4FEB-9FEC-66FCDD191873@apple.com>
In-Reply-To: fa96b8487de1.5dfa0170@nic.in
X-Status: 
X-Keywords:                  
X-UID: 3211

--===============7392603994905322374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On Dec 18, 2019, at 6:07 AM, V Anil Kumar <anil(a)csir4pi.in> wrote:
> =

> Hi,
> =

> On 12/15/19 10:35 PM, Christoph Paasch <cpaasch(a)apple.com <mailto:cpaas=
ch(a)apple.com>> wrote:
>> =

>> Hello,
>> =

>> =

>>> On Dec 15, 2019, at 12:05 PM, Yoshifumi Nishida <nsd.ietf(a)gmail.com <=
mailto:nsd.ietf(a)gmail.com>> wrote:
>>> =

>>> Hi,
>>> One concern I have here is this may mean we end up want all implementat=
ions to support late mapping feature.
>>> Because if an implementation that supports the feature uses it to send =
data, the receiver who doesn't support it will discard the packets. To avoi=
d it, we need to mandate receivers to support it.
>> =

>> that is indeed the problem. Once we allow the sender to do late/early ma=
ppings, a receiver has to implement it to be interoperable with all impleme=
ntations.
>> =

>> More inline:
>> =

>>> On Sat, Dec 14, 2019 at 5:40 AM V Anil Kumar <anil(a)csir4pi.in <mailto=
:anil(a)csir4pi.in>> wrote:
>>> Hi Christoph,
>>> =

>>> On 12/13/19 11:54 PM, Christoph Paasch <cpaasch(a)apple.com <mailto:cpa=
asch(a)apple.com>> wrote:
>>>> =

>>>> =

>> [...]
>>>> > Well it could just be due to the lack of option space insegment-1. F=
or
>>>> > example, the sender ofsegment-1 at that instant wants to transmit mu=
ltiple
>>>> > TCP options (e.g.timestamp, SACK, DSS and ADD_ADDR). Obviously, they=
 all
>>>> > cannot fit into optionfield of one segment, and eventually the DSS
>>>> > transmission got slightly delayedby a segment or two.
>>>> =

>>>> The implementation needs to enforce a strict priority of DSS over SACK=
 and ADD_ADDR.
>>> TCP options have evolved over a period of time, and I do not think as s=
uch any document/guidelines exist on  enforcing priority for one over the o=
ther, though it turns out be an interesting topic.  Also, more TCP options =
could come up in future for implementing  new features.  So, it is likely t=
hat implementations would follow different strategy when it come to option =
priority. =

>> =

>> This is purely an implementation choice. I don't think it is necessary t=
o document this.
>> For example, when TCP-MD5 is used, Linux disables the TCP Timestamp opti=
on, thus enforcing priority of TCP-MD5 over Timestamps.
>> =

>> =

>> To re-iterate my earlier point: Unless there is real data about the perf=
ormance benefits,... of enabling early/late mapping, my vote is to not allo=
w these kind of mappings as they complexify implementations.
>> =

> =

> When MPTCP is used for data transfer in both directions, the need to carr=
y both timestamp and SACK options in a data segment may not be a rare case,=
 as data loss or out-of-order reception can happen in both directions. On s=
uch a data segment, once timestamp and SACK options are included, packing D=
SS with map is not feasible. Should the data segment in such case include S=
ACK or DSS? How does the Linux implementation of MPTCP deal with such a cas=
e?
> =

It should include a DSS and fill up the remainder of the option-space with =
SACK-blocks. That is also what Linux does.


Christoph


>  =

> =

> Anil
> =

>> =

>> =

>> =

>> =

>> Christoph
>> =

>> =

>>>> =

>>>> =

>>>> If the ADD_ADDR does not fit in the TCP-option space, it can send the
>>>> ADD_ADDR on a pure ACK. The echo-bit in the ADD_ADDR guarantee the rel=
iable
>>>> delivery of it.
>>> I noticed this new feature in RFC 6824-bis to deliver ADD_ADDR in pure =
ACK and still achieve the reliability. The ability to deliver MPTCP options=
 in pure ACK will be useful, especially for options like ADD_ADDR.   =

>>>> =

>>>> =

>>>> Sure, one could argue that favoring SACK over DSS is more important. B=
ut I
>>>> think we would need data to justify that. Only very specific traffic
>>>> patterns will fall in this use-case.
>>> The bottomline is that in the event of a map being slightly delayed, i.=
e., delivered late with respect to the corresponding data, should  it resul=
t in resetting the subflow? =

>>> =

>>> As far as the specification is concerned, it could be liberal on accept=
ing such maps, rather than being restrictive. Even if a current implementat=
ion cannot support this, future implementations may like to, provided the s=
pecification permits this and the implementation is willing to cop up with =
the associated complexity. =

>>> =

>>> Best regards,
>>> =

>>> Anil
>>>> =

>>>> =

>>>> Christoph
>>>> =

>>>> > =

>>>> >  =

>>>> > =

>>>> > With regards,
>>>> > =

>>>> >  =

>>>> > =

>>>> > Anil
>>>> > =

>>>> >  =

>>>> > =

>>>> > > =

>>>> > > =

>>>> > > =

>>>> > > =

>>>> > > =

>>>> > > =

>>>> > > =

>>>> > > Christoph
>>>> > > =

>>>> > > =

>>>> > > > =

>>>> > > > =

>>>> > > > =

>>>> > > > Further, segment-3 cannot combine/cover the data in segment-1 an=
d segment-3 in a "single map", as the data sequence space is not continuous=
, i.e., some in between data (segment-2) is mapped and transmitted through =
subflow-2. Here, the map in segment-3 does not even partially cover the dat=
a it carries. =

>>>> > > > =

>>>> > > > =

>>>> > > >  =

>>>> > > > =

>>>> > > > Both RFC 6824 and the 6824-bis do not restrict the above scenari=
o, and I guess the change proposed now does not permit this to happen. =

>>>> > > > =

>>>> > > > =

>>>> > > >  =

>>>> > > > =

>>>> > > > Best regards, =

>>>> > > > =

>>>> > > > =

>>>> > > >  =

>>>> > > > =

>>>> > > > Anil =

>>>> > > > =

>>>> > > > =

>>>> > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > That's the reason why we (the MPTCP-upstreaming community) vou=
ch to have this case restricted.
>>>> > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > Cheers,
>>>> > > > > Christoph
>>>> > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > > =

>>>> > > > > > =

>>>> > > > > > =

>>>> > > > > > =

>>>> > > > > > =

>>>> > > > > > =

>>>> > > > > > Anil =

>>>> > > > > > =

>>>> > > > > > > =

>>>> > > > > > > =

>>>> > > > > > > =

>>>> > > > > > > =

>>>> > > > > > > =

>>>> > > > > > > =

>>>> > > > > > > =

>>>> > > > > > > =

>>>> > > > > > > =

>>>> > > > > > > =

>>>> > > > > > > =

>>>> > > > > > > Best regards,
>>>> > > > > > > =

>>>> > > > > > > Alan
>>>> > > > > > > =

>>>> > > > > > > =

>>>> > > > > > >  =

>>>> > > > > > > =

>>>> > > > > > =

>>>> > > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > > =

>>>> > > > >  =

>>>> > > > > =

>>>> > > > =

>>>> > > > =

>>>> > > =

>>>> > > =

>>>> > > =

>>>> > >  =

>>>> > >
>>> _______________________________________________
>>> multipathtcp mailing list
>>> multipathtcp(a)ietf.org <mailto:multipathtcp(a)ietf.org>
>>> https://www.ietf.org/mailman/listinfo/multipathtcp <https://www.ietf.or=
g/mailman/listinfo/multipathtcp>

--===============7392603994905322374==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBi
cmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdo
aXRlLXNwYWNlOyIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxkaXY+PGJyIGNsYXNzPSIiPjxibG9j
a3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+T24gRGVjIDE4LCAyMDE5
LCBhdCA2OjA3IEFNLCBWIEFuaWwgS3VtYXIgJmx0OzxhIGhyZWY9Im1haWx0bzphbmlsQGNzaXI0
cGkuaW4iIGNsYXNzPSIiPmFuaWxAY3NpcjRwaS5pbjwvYT4mZ3Q7IHdyb3RlOjwvZGl2PjxiciBj
bGFzcz0iQXBwbGUtaW50ZXJjaGFuZ2UtbmV3bGluZSI+PGRpdiBjbGFzcz0iIj48c3BhbiBzdHls
ZT0iY2FyZXQtY29sb3I6IHJnYigwLCAwLCAwKTsgZm9udC1mYW1pbHk6IEhlbHZldGljYTsgZm9u
dC1zaXplOiAxM3B4OyBmb250LXN0eWxlOiBub3JtYWw7IGZvbnQtdmFyaWFudC1jYXBzOiBub3Jt
YWw7IGZvbnQtd2VpZ2h0OiBub3JtYWw7IGxldHRlci1zcGFjaW5nOiBub3JtYWw7IHRleHQtYWxp
Z246IHN0YXJ0OyB0ZXh0LWluZGVudDogMHB4OyB0ZXh0LXRyYW5zZm9ybTogbm9uZTsgd2hpdGUt
c3BhY2U6IG5vcm1hbDsgd29yZC1zcGFjaW5nOiAwcHg7IC13ZWJraXQtdGV4dC1zdHJva2Utd2lk
dGg6IDBweDsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyBmbG9hdDogbm9uZTsgZGlzcGxheTogaW5s
aW5lICFpbXBvcnRhbnQ7IiBjbGFzcz0iIj5IaSw8L3NwYW4+PGJyIHN0eWxlPSJjYXJldC1jb2xv
cjogcmdiKDAsIDAsIDApOyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBmb250LXNpemU6IDEzcHg7
IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWln
aHQ6IG5vcm1hbDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4dC1hbGlnbjogc3RhcnQ7IHRl
eHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFs
OyB3b3JkLXNwYWNpbmc6IDBweDsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0
LWRlY29yYXRpb246IG5vbmU7IiBjbGFzcz0iIj48YnIgc3R5bGU9ImNhcmV0LWNvbG9yOiByZ2Io
MCwgMCwgMCk7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGZvbnQtc2l6ZTogMTNweDsgZm9udC1z
dHlsZTogbm9ybWFsOyBmb250LXZhcmlhbnQtY2Fwczogbm9ybWFsOyBmb250LXdlaWdodDogbm9y
bWFsOyBsZXR0ZXItc3BhY2luZzogbm9ybWFsOyB0ZXh0LWFsaWduOiBzdGFydDsgdGV4dC1pbmRl
bnQ6IDBweDsgdGV4dC10cmFuc2Zvcm06IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdvcmQt
c3BhY2luZzogMHB4OyAtd2Via2l0LXRleHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3Jh
dGlvbjogbm9uZTsiIGNsYXNzPSIiPjxzcGFuIHN0eWxlPSJjYXJldC1jb2xvcjogcmdiKDAsIDAs
IDApOyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBmb250LXNpemU6IDEzcHg7IGZvbnQtc3R5bGU6
IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWlnaHQ6IG5vcm1hbDsg
bGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4dC1hbGlnbjogc3RhcnQ7IHRleHQtaW5kZW50OiAw
cHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3JkLXNwYWNp
bmc6IDBweDsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0LWRlY29yYXRpb246
IG5vbmU7IiBjbGFzcz0iIj5PbiAxMi8xNS8xOSAxMDozNSBQTSw8c3BhbiBjbGFzcz0iQXBwbGUt
Y29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGIgY2xhc3M9Im5hbWUiPkNocmlzdG9waCBQ
YWFzY2g8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PC9i
PiZsdDs8YSBocmVmPSJtYWlsdG86Y3BhYXNjaEBhcHBsZS5jb20iIGNsYXNzPSIiPmNwYWFzY2hA
YXBwbGUuY29tPC9hPiZndDsgd3JvdGU6PC9zcGFuPjxibG9ja3F1b3RlIGNpdGU9Im1pZDo5NjlC
MkQ1RC04M0U3LTQxQjgtQThERS0xRDIwMzY1Njc0MDFAYXBwbGUuY29tIiBjbGFzcz0iaXdjUXVv
dGUiIHR5cGU9ImNpdGUiIHN0eWxlPSJmb250LWZhbWlseTogSGVsdmV0aWNhOyBmb250LXNpemU6
IDEzcHg7IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9u
dC13ZWlnaHQ6IG5vcm1hbDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgb3JwaGFuczogYXV0bzsg
dGV4dC1hbGlnbjogc3RhcnQ7IHRleHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25l
OyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3aWRvd3M6IGF1dG87IHdvcmQtc3BhY2luZzogMHB4OyAt
d2Via2l0LXRleHQtc2l6ZS1hZGp1c3Q6IGF1dG87IC13ZWJraXQtdGV4dC1zdHJva2Utd2lkdGg6
IDBweDsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyBib3JkZXItbGVmdC13aWR0aDogMXB4OyBib3Jk
ZXItbGVmdC1zdHlsZTogc29saWQ7IGJvcmRlci1sZWZ0LWNvbG9yOiByZ2IoMCwgMCwgMjU1KTsg
cGFkZGluZy1sZWZ0OiAxM3B4OyBtYXJnaW4tbGVmdDogMHB4OyI+PGRpdiBjbGFzcz0ibWltZXR5
cGUtdGV4dC1odG1sIj48c3BhbiBjbGFzcz0iIj48cCBjbGFzcz0iIj48dGFibGUgY2xhc3M9IiI+
PHRib2R5IGNsYXNzPSIiPjx0ciBjbGFzcz0iIj48dGQgY2xhc3M9IiIgc3R5bGU9IndvcmQtd3Jh
cDogYnJlYWstd29yZDsgLXdlYmtpdC1uYnNwLW1vZGU6IHNwYWNlOyBsaW5lLWJyZWFrOiBhZnRl
ci13aGl0ZS1zcGFjZTsiPjxwIGNsYXNzPSIiPkhlbGxvLDxiciBjbGFzcz0iIj48L3A+PGRpdiBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgY2xhc3M9IiIgdHlwZT0iY2l0ZSI+PGRp
diBjbGFzcz0iIj5PbiBEZWMgMTUsIDIwMTksIGF0IDEyOjA1IFBNLCBZb3NoaWZ1bWkgTmlzaGlk
YSAmbHQ7PGEgY2xhc3M9IiIgaHJlZj0ibWFpbHRvOm5zZC5pZXRmQGdtYWlsLmNvbSI+bnNkLmll
dGZAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PC9kaXY+PGJyIGNsYXNzPSJBcHBsZS1pbnRlcmNo
YW5nZS1uZXdsaW5lIj48ZGl2IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiIgZGlyPSJsdHIiPjxkaXYg
Y2xhc3M9IiI+SGksPC9kaXY+PGRpdiBjbGFzcz0iIj5PbmUgY29uY2VybiBJIGhhdmUgaGVyZSBp
cyB0aGlzIG1heSBtZWFuIHdlIGVuZCB1cCB3YW50IGFsbCBpbXBsZW1lbnRhdGlvbnMgdG8gc3Vw
cG9ydCBsYXRlIG1hcHBpbmcgZmVhdHVyZS48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0i
Ij5CZWNhdXNlIGlmIGFuIGltcGxlbWVudGF0aW9uIHRoYXQgc3VwcG9ydHMgdGhlIGZlYXR1cmUg
dXNlcyBpdCB0byBzZW5kIGRhdGEsIHRoZSByZWNlaXZlciB3aG8gZG9lc24ndCBzdXBwb3J0IGl0
IHdpbGwgZGlzY2FyZCB0aGUgcGFja2V0cy4gVG8gYXZvaWQgaXQsIHdlIG5lZWQgdG8gbWFuZGF0
ZSByZWNlaXZlcnMgdG8gc3VwcG9ydCBpdC48L2Rpdj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+
PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj50aGF0IGlzIGlu
ZGVlZCB0aGUgcHJvYmxlbS4gT25jZSB3ZSBhbGxvdyB0aGUgc2VuZGVyIHRvIGRvIGxhdGUvZWFy
bHkgbWFwcGluZ3MsIGEgcmVjZWl2ZXIgaGFzIHRvIGltcGxlbWVudCBpdCB0byBiZSBpbnRlcm9w
ZXJhYmxlIHdpdGggYWxsIGltcGxlbWVudGF0aW9ucy48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBj
bGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPk1vcmUgaW5saW5lOjwvZGl2PjxiciBjbGFzcz0i
Ij48YmxvY2txdW90ZSBjbGFzcz0iIiB0eXBlPSJjaXRlIj48ZGl2IGNsYXNzPSIiPjxkaXYgY2xh
c3M9IiIgZGlyPSJsdHIiPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGNsYXNzPSJnbWFp
bF9hdHRyIiBkaXI9Imx0ciI+T24gU2F0LCBEZWMgMTQsIDIwMTkgYXQgNTo0MCBBTSBWIEFuaWwg
S3VtYXIgJmx0OzxhIGNsYXNzPSIiIGhyZWY9Im1haWx0bzphbmlsQGNzaXI0cGkuaW4iPmFuaWxA
Y3NpcjRwaS5pbjwvYT4mZ3Q7IHdyb3RlOjxiciBjbGFzcz0iIj48L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBweCAwcHggMHB4IDAuOGV4OyBib3Jk
ZXItbGVmdC13aWR0aDogMXB4OyBib3JkZXItbGVmdC1zdHlsZTogc29saWQ7IGJvcmRlci1sZWZ0
LWNvbG9yOiByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+SGkgQ2hyaXN0
b3BoLDxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PHNwYW4gY2xhc3M9IiI+T24gMTIvMTMvMTkg
MTE6NTQgUE0sPHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFu
PjxiIGNsYXNzPSIiPkNocmlzdG9waCBQYWFzY2g8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVk
LXNwYWNlIj4mbmJzcDs8L3NwYW4+PC9iPiZsdDs8YSBjbGFzcz0iIiBocmVmPSJtYWlsdG86Y3Bh
YXNjaEBhcHBsZS5jb20iPmNwYWFzY2hAYXBwbGUuY29tPC9hPiZndDsgd3JvdGU6PC9zcGFuPjxi
bG9ja3F1b3RlIGNsYXNzPSIiIHR5cGU9ImNpdGUiIHN0eWxlPSJib3JkZXItbGVmdC13aWR0aDog
MXB4OyBib3JkZXItbGVmdC1zdHlsZTogc29saWQ7IGJvcmRlci1sZWZ0LWNvbG9yOiByZ2IoMCwg
MCwgMjU1KTsgcGFkZGluZy1sZWZ0OiAxM3B4OyBtYXJnaW4tbGVmdDogMHB4OyI+PGRpdiBjbGFz
cz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PC9ibG9ja3F1b3RlPjwvYmxvY2txdW90ZT48L2Rpdj48
L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+Wy4uLl08YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgY2xh
c3M9IiIgdHlwZT0iY2l0ZSI+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiIGRpcj0ibHRyIj48
ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOiAwcHggMHB4IDBweCAwLjhleDsgYm9yZGVyLWxlZnQtd2lkdGg6IDFweDsg
Ym9yZGVyLWxlZnQtc3R5bGU6IHNvbGlkOyBib3JkZXItbGVmdC1jb2xvcjogcmdiKDIwNCwgMjA0
LCAyMDQpOyBwYWRkaW5nLWxlZnQ6IDFleDsiPjxibG9ja3F1b3RlIGNsYXNzPSIiIHR5cGU9ImNp
dGUiIHN0eWxlPSJib3JkZXItbGVmdC13aWR0aDogMXB4OyBib3JkZXItbGVmdC1zdHlsZTogc29s
aWQ7IGJvcmRlci1sZWZ0LWNvbG9yOiByZ2IoMCwgMCwgMjU1KTsgcGFkZGluZy1sZWZ0OiAxM3B4
OyBtYXJnaW4tbGVmdDogMHB4OyI+PGRpdiBjbGFzcz0iIj4mZ3Q7IFdlbGwgaXQgY291bGQganVz
dCBiZSBkdWUgdG8gdGhlIGxhY2sgb2Ygb3B0aW9uIHNwYWNlIGluc2VnbWVudC0xLiBGb3I8YnIg
Y2xhc3M9IiI+Jmd0OyBleGFtcGxlLCB0aGUgc2VuZGVyIG9mc2VnbWVudC0xIGF0IHRoYXQgaW5z
dGFudCB3YW50cyB0byB0cmFuc21pdCBtdWx0aXBsZTxiciBjbGFzcz0iIj4mZ3Q7IFRDUCBvcHRp
b25zIChlLmcudGltZXN0YW1wLCBTQUNLLCBEU1MgYW5kIEFERF9BRERSKS4gT2J2aW91c2x5LCB0
aGV5IGFsbDxiciBjbGFzcz0iIj4mZ3Q7IGNhbm5vdCBmaXQgaW50byBvcHRpb25maWVsZCBvZiBv
bmUgc2VnbWVudCwgYW5kIGV2ZW50dWFsbHkgdGhlIERTUzxiciBjbGFzcz0iIj4mZ3Q7IHRyYW5z
bWlzc2lvbiBnb3Qgc2xpZ2h0bHkgZGVsYXllZGJ5IGEgc2VnbWVudCBvciB0d28uPGJyIGNsYXNz
PSIiPjxiciBjbGFzcz0iIj5UaGUgaW1wbGVtZW50YXRpb24gbmVlZHMgdG8gZW5mb3JjZSBhIHN0
cmljdCBwcmlvcml0eSBvZiBEU1Mgb3ZlciBTQUNLIGFuZCBBRERfQUREUi48L2Rpdj48L2Jsb2Nr
cXVvdGU+PGRpdiBjbGFzcz0iIj5UQ1Agb3B0aW9ucyBoYXZlIGV2b2x2ZWQgb3ZlciBhIHBlcmlv
ZCBvZiB0aW1lLCBhbmQgSSBkbyBub3QgdGhpbmsgYXMgc3VjaCBhbnkgZG9jdW1lbnQvZ3VpZGVs
aW5lcyBleGlzdCBvbiAmbmJzcDtlbmZvcmNpbmcgcHJpb3JpdHkgZm9yIG9uZSBvdmVyIHRoZSBv
dGhlciwgdGhvdWdoIGl0IHR1cm5zIG91dCBiZSBhbiBpbnRlcmVzdGluZyB0b3BpYy4mbmJzcDsg
QWxzbywgbW9yZSBUQ1Agb3B0aW9ucyBjb3VsZCBjb21lIHVwIGluIGZ1dHVyZSBmb3IgaW1wbGVt
ZW50aW5nICZuYnNwO25ldyBmZWF0dXJlcy4mbmJzcDsgU28sIGl0IGlzIGxpa2VseSB0aGF0IGlt
cGxlbWVudGF0aW9ucyB3b3VsZCBmb2xsb3cgZGlmZmVyZW50IHN0cmF0ZWd5IHdoZW4gaXQgY29t
ZSB0byBvcHRpb24gcHJpb3JpdHkuJm5ic3A7PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2
PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2
IGNsYXNzPSIiPlRoaXMgaXMgcHVyZWx5IGFuIGltcGxlbWVudGF0aW9uIGNob2ljZS4gSSBkb24n
dCB0aGluayBpdCBpcyBuZWNlc3NhcnkgdG8gZG9jdW1lbnQgdGhpcy48L2Rpdj48ZGl2IGNsYXNz
PSIiPkZvciBleGFtcGxlLCB3aGVuIFRDUC1NRDUgaXMgdXNlZCwgTGludXggZGlzYWJsZXMgdGhl
IFRDUCBUaW1lc3RhbXAgb3B0aW9uLCB0aHVzIGVuZm9yY2luZyBwcmlvcml0eSBvZiBUQ1AtTUQ1
IG92ZXIgVGltZXN0YW1wcy48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48
ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPlRvIHJlLWl0ZXJh
dGUgbXkgZWFybGllciBwb2ludDogVW5sZXNzIHRoZXJlIGlzIHJlYWwgZGF0YSBhYm91dCB0aGUg
cGVyZm9ybWFuY2UgYmVuZWZpdHMsLi4uIG9mIGVuYWJsaW5nIGVhcmx5L2xhdGUgbWFwcGluZywg
bXkgdm90ZSBpcyB0byBub3QgYWxsb3cgdGhlc2Uga2luZCBvZiBtYXBwaW5ncyBhcyB0aGV5IGNv
bXBsZXhpZnkgaW1wbGVtZW50YXRpb25zLjwvZGl2PjwvZGl2PjwvdGQ+PC90cj48L3Rib2R5Pjwv
dGFibGU+PC9wPjwvc3Bhbj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdiBzdHlsZT0iY2FyZXQtY29s
b3I6IHJnYigwLCAwLCAwKTsgZm9udC1mYW1pbHk6IEhlbHZldGljYTsgZm9udC1zaXplOiAxM3B4
OyBmb250LXN0eWxlOiBub3JtYWw7IGZvbnQtdmFyaWFudC1jYXBzOiBub3JtYWw7IGZvbnQtd2Vp
Z2h0OiBub3JtYWw7IGxldHRlci1zcGFjaW5nOiBub3JtYWw7IHRleHQtYWxpZ246IHN0YXJ0OyB0
ZXh0LWluZGVudDogMHB4OyB0ZXh0LXRyYW5zZm9ybTogbm9uZTsgd2hpdGUtc3BhY2U6IG5vcm1h
bDsgd29yZC1zcGFjaW5nOiAwcHg7IC13ZWJraXQtdGV4dC1zdHJva2Utd2lkdGg6IDBweDsgdGV4
dC1kZWNvcmF0aW9uOiBub25lOyIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxwIGNsYXNz
PSJNc29Ob3JtYWwiIHN0eWxlPSJjYXJldC1jb2xvcjogcmdiKDAsIDAsIDApOyBmb250LWZhbWls
eTogSGVsdmV0aWNhOyBmb250LXNpemU6IDEzcHg7IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12
YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWlnaHQ6IG5vcm1hbDsgbGV0dGVyLXNwYWNpbmc6
IG5vcm1hbDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4dC10cmFuc2Zvcm06IG5vbmU7IHdoaXRlLXNw
YWNlOiBub3JtYWw7IHdvcmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRleHQtc3Ryb2tlLXdpZHRo
OiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsgdGV4dC1hbGlnbjoganVzdGlmeTsiPldoZW4g
TVBUQ1AgaXMgdXNlZCBmb3IgZGF0YSB0cmFuc2ZlciBpbiBib3RoIGRpcmVjdGlvbnMsIHRoZSBu
ZWVkIHRvIGNhcnJ5IGJvdGggdGltZXN0YW1wIGFuZCBTQUNLIG9wdGlvbnMgaW4gYSBkYXRhIHNl
Z21lbnQgbWF5IG5vdCBiZSBhIHJhcmUgY2FzZSwgYXMgZGF0YSBsb3NzIG9yIG91dC1vZi1vcmRl
ciByZWNlcHRpb24gY2FuIGhhcHBlbiBpbiBib3RoIGRpcmVjdGlvbnMuIE9uIHN1Y2ggYSBkYXRh
IHNlZ21lbnQsIG9uY2UgdGltZXN0YW1wIGFuZCBTQUNLIG9wdGlvbnMgYXJlIGluY2x1ZGVkLCBw
YWNraW5nIERTUyB3aXRoIG1hcCBpcyBub3QgZmVhc2libGUuIFNob3VsZCB0aGUgZGF0YSBzZWdt
ZW50IGluIHN1Y2ggY2FzZSBpbmNsdWRlIFNBQ0sgb3IgRFNTPyBIb3cgZG9lcyB0aGUgTGludXgg
aW1wbGVtZW50YXRpb24gb2YgTVBUQ1AgZGVhbCB3aXRoIHN1Y2ggYSBjYXNlPzwvcD48L2Rpdj48
L2Jsb2NrcXVvdGU+PGRpdj5JdCBzaG91bGQgaW5jbHVkZSBhIERTUyBhbmQgZmlsbCB1cCB0aGUg
cmVtYWluZGVyIG9mIHRoZSBvcHRpb24tc3BhY2Ugd2l0aCBTQUNLLWJsb2Nrcy4gVGhhdCBpcyBh
bHNvIHdoYXQgTGludXggZG9lcy48L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2Pjxi
ciBjbGFzcz0iIj48L2Rpdj48ZGl2PkNocmlzdG9waDwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjwv
ZGl2PjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj48ZGl2IGNs
YXNzPSIiPjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJjYXJldC1jb2xvcjogcmdiKDAsIDAs
IDApOyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBmb250LXNpemU6IDEzcHg7IGZvbnQtc3R5bGU6
IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWlnaHQ6IG5vcm1hbDsg
bGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4dC10cmFuc2Zvcm06
IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdvcmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRl
eHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsgdGV4dC1hbGlnbjog
anVzdGlmeTsiPjxvOnAgY2xhc3M9IiI+PC9vOnA+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0
eWxlPSJjYXJldC1jb2xvcjogcmdiKDAsIDAsIDApOyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBm
b250LXNpemU6IDEzcHg7IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5v
cm1hbDsgZm9udC13ZWlnaHQ6IG5vcm1hbDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4dC1p
bmRlbnQ6IDBweDsgdGV4dC10cmFuc2Zvcm06IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdv
cmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRleHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVj
b3JhdGlvbjogbm9uZTsgdGV4dC1hbGlnbjoganVzdGlmeTsiPjxvOnAgY2xhc3M9IiI+Jm5ic3A7
PC9vOnA+PC9wPjxkaXYgc3R5bGU9ImNhcmV0LWNvbG9yOiByZ2IoMCwgMCwgMCk7IGZvbnQtZmFt
aWx5OiBIZWx2ZXRpY2E7IGZvbnQtc2l6ZTogMTNweDsgZm9udC1zdHlsZTogbm9ybWFsOyBmb250
LXZhcmlhbnQtY2Fwczogbm9ybWFsOyBmb250LXdlaWdodDogbm9ybWFsOyBsZXR0ZXItc3BhY2lu
Zzogbm9ybWFsOyB0ZXh0LWFsaWduOiBzdGFydDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4dC10cmFu
c2Zvcm06IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdvcmQtc3BhY2luZzogMHB4OyAtd2Vi
a2l0LXRleHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsiIGNsYXNz
PSIiPkFuaWw8L2Rpdj48ZGl2IHN0eWxlPSJjYXJldC1jb2xvcjogcmdiKDAsIDAsIDApOyBmb250
LWZhbWlseTogSGVsdmV0aWNhOyBmb250LXNpemU6IDEzcHg7IGZvbnQtc3R5bGU6IG5vcm1hbDsg
Zm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWlnaHQ6IG5vcm1hbDsgbGV0dGVyLXNw
YWNpbmc6IG5vcm1hbDsgdGV4dC1hbGlnbjogc3RhcnQ7IHRleHQtaW5kZW50OiAwcHg7IHRleHQt
dHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3JkLXNwYWNpbmc6IDBweDsg
LXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7IiBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGJsb2NrcXVvdGUgY2l0ZT0ibWlkOjk2OUIyRDVE
LTgzRTctNDFCOC1BOERFLTFEMjAzNjU2NzQwMUBhcHBsZS5jb20iIGNsYXNzPSJpd2NRdW90ZSIg
dHlwZT0iY2l0ZSIgc3R5bGU9ImZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGZvbnQtc2l6ZTogMTNw
eDsgZm9udC1zdHlsZTogbm9ybWFsOyBmb250LXZhcmlhbnQtY2Fwczogbm9ybWFsOyBmb250LXdl
aWdodDogbm9ybWFsOyBsZXR0ZXItc3BhY2luZzogbm9ybWFsOyBvcnBoYW5zOiBhdXRvOyB0ZXh0
LWFsaWduOiBzdGFydDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4dC10cmFuc2Zvcm06IG5vbmU7IHdo
aXRlLXNwYWNlOiBub3JtYWw7IHdpZG93czogYXV0bzsgd29yZC1zcGFjaW5nOiAwcHg7IC13ZWJr
aXQtdGV4dC1zaXplLWFkanVzdDogYXV0bzsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4
OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7IGJvcmRlci1sZWZ0LXdpZHRoOiAxcHg7IGJvcmRlci1s
ZWZ0LXN0eWxlOiBzb2xpZDsgYm9yZGVyLWxlZnQtY29sb3I6IHJnYigwLCAwLCAyNTUpOyBwYWRk
aW5nLWxlZnQ6IDEzcHg7IG1hcmdpbi1sZWZ0OiAwcHg7Ij48ZGl2IGNsYXNzPSJtaW1ldHlwZS10
ZXh0LWh0bWwiPjxzcGFuIGNsYXNzPSIiPjxwIGNsYXNzPSIiPjx0YWJsZSBjbGFzcz0iIj48dGJv
ZHkgY2xhc3M9IiI+PHRyIGNsYXNzPSIiPjx0ZCBjbGFzcz0iIiBzdHlsZT0id29yZC13cmFwOiBi
cmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdo
aXRlLXNwYWNlOyI+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rp
dj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFz
cz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkNocmlzdG9waDwvZGl2PjxkaXYgY2xhc3M9IiI+PGJy
IGNsYXNzPSIiPjwvZGl2PjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSBjbGFzcz0iIiB0eXBlPSJj
aXRlIj48ZGl2IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiIgZGlyPSJsdHIiPjxkaXYgY2xhc3M9Imdt
YWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
IDBweCAwcHggMHB4IDAuOGV4OyBib3JkZXItbGVmdC13aWR0aDogMXB4OyBib3JkZXItbGVmdC1z
dHlsZTogc29saWQ7IGJvcmRlci1sZWZ0LWNvbG9yOiByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRp
bmctbGVmdDogMWV4OyI+PGJsb2NrcXVvdGUgY2xhc3M9IiIgdHlwZT0iY2l0ZSIgc3R5bGU9ImJv
cmRlci1sZWZ0LXdpZHRoOiAxcHg7IGJvcmRlci1sZWZ0LXN0eWxlOiBzb2xpZDsgYm9yZGVyLWxl
ZnQtY29sb3I6IHJnYigwLCAwLCAyNTUpOyBwYWRkaW5nLWxlZnQ6IDEzcHg7IG1hcmdpbi1sZWZ0
OiAwcHg7Ij48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+SWYgdGhlIEFE
RF9BRERSIGRvZXMgbm90IGZpdCBpbiB0aGUgVENQLW9wdGlvbiBzcGFjZSwgaXQgY2FuIHNlbmQg
dGhlPGJyIGNsYXNzPSIiPkFERF9BRERSIG9uIGEgcHVyZSBBQ0suIFRoZSBlY2hvLWJpdCBpbiB0
aGUgQUREX0FERFIgZ3VhcmFudGVlIHRoZSByZWxpYWJsZTxiciBjbGFzcz0iIj5kZWxpdmVyeSBv
ZiBpdC48YnIgY2xhc3M9IiI+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXYgY2xhc3M9IiI+SSBub3Rp
Y2VkIHRoaXMgbmV3IGZlYXR1cmUgaW4gUkZDIDY4MjQtYmlzIHRvIGRlbGl2ZXIgQUREX0FERFIg
aW4gcHVyZSBBQ0sgYW5kIHN0aWxsIGFjaGlldmUgdGhlIHJlbGlhYmlsaXR5LiBUaGUgYWJpbGl0
eSB0byBkZWxpdmVyIE1QVENQIG9wdGlvbnMgaW4gcHVyZSBBQ0sgd2lsbCBiZSB1c2VmdWwsIGVz
cGVjaWFsbHkgZm9yIG9wdGlvbnMgbGlrZSBBRERfQUREUi4gJm5ic3A7Jm5ic3A7PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9IiIgdHlwZT0iY2l0ZSIgc3R5bGU9ImJvcmRlci1sZWZ0LXdpZHRoOiAx
cHg7IGJvcmRlci1sZWZ0LXN0eWxlOiBzb2xpZDsgYm9yZGVyLWxlZnQtY29sb3I6IHJnYigwLCAw
LCAyNTUpOyBwYWRkaW5nLWxlZnQ6IDEzcHg7IG1hcmdpbi1sZWZ0OiAwcHg7Ij48ZGl2IGNsYXNz
PSIiPjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+U3VyZSwgb25lIGNvdWxkIGFyZ3VlIHRoYXQg
ZmF2b3JpbmcgU0FDSyBvdmVyIERTUyBpcyBtb3JlIGltcG9ydGFudC4gQnV0IEk8YnIgY2xhc3M9
IiI+dGhpbmsgd2Ugd291bGQgbmVlZCBkYXRhIHRvIGp1c3RpZnkgdGhhdC4gT25seSB2ZXJ5IHNw
ZWNpZmljIHRyYWZmaWM8YnIgY2xhc3M9IiI+cGF0dGVybnMgd2lsbCBmYWxsIGluIHRoaXMgdXNl
LWNhc2UuPGJyIGNsYXNzPSIiPjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2IGNsYXNzPSIiPlRoZSBi
b3R0b21saW5lIGlzIHRoYXQgaW4gdGhlIGV2ZW50IG9mIGEgbWFwIGJlaW5nIHNsaWdodGx5IGRl
bGF5ZWQsIGkuZS4sIGRlbGl2ZXJlZCBsYXRlIHdpdGggcmVzcGVjdCB0byB0aGUgY29ycmVzcG9u
ZGluZyBkYXRhLCBzaG91bGQgJm5ic3A7aXQgcmVzdWx0IGluIHJlc2V0dGluZyB0aGUgc3ViZmxv
dz8mbmJzcDs8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNz
PSIiPkFzIGZhciBhcyB0aGUgc3BlY2lmaWNhdGlvbiBpcyBjb25jZXJuZWQsIGl0IGNvdWxkIGJl
IGxpYmVyYWwgb24gYWNjZXB0aW5nIHN1Y2ggbWFwcywgcmF0aGVyIHRoYW4gYmVpbmcgcmVzdHJp
Y3RpdmUuIEV2ZW4gaWYgYSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGNhbm5vdCBzdXBwb3J0IHRo
aXMsIGZ1dHVyZSBpbXBsZW1lbnRhdGlvbnMgbWF5IGxpa2UgdG8sIHByb3ZpZGVkIHRoZSBzcGVj
aWZpY2F0aW9uIHBlcm1pdHMgdGhpcyBhbmQgdGhlIGltcGxlbWVudGF0aW9uIGlzIHdpbGxpbmcg
dG8gY29wIHVwIHdpdGggdGhlIGFzc29jaWF0ZWQgY29tcGxleGl0eS4mbmJzcDs8L2Rpdj48ZGl2
IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkJlc3QgcmVnYXJkcyw8
L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkFuaWw8
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iIiB0eXBlPSJjaXRlIiBzdHlsZT0iYm9yZGVyLWxlZnQt
d2lkdGg6IDFweDsgYm9yZGVyLWxlZnQtc3R5bGU6IHNvbGlkOyBib3JkZXItbGVmdC1jb2xvcjog
cmdiKDAsIDAsIDI1NSk7IHBhZGRpbmctbGVmdDogMTNweDsgbWFyZ2luLWxlZnQ6IDBweDsiPjxk
aXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5DaHJpc3RvcGg8YnIgY2xhc3M9
IiI+PGJyIGNsYXNzPSIiPiZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4m
bmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsmbmJzcDs8c3BhbiBjbGFzcz0iQXBwbGUtY29u
dmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDs8c3BhbiBjbGFzcz0i
QXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgV2l0
aCByZWdhcmRzLDxiciBjbGFzcz0iIj4mZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1z
cGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7Jm5ic3A7PHNwYW4gY2xhc3M9IkFw
cGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7PHNwYW4g
Y2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4m
Z3Q7IEFuaWw8YnIgY2xhc3M9IiI+Jmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3Bh
Y2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyZuYnNwOzxzcGFuIGNsYXNzPSJBcHBs
ZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OzxzcGFuIGNs
YXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0
OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxi
ciBjbGFzcz0iIj4mZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4m
bmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252
ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7PHNwYW4gY2xh
c3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7
ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJy
IGNsYXNzPSIiPiZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZu
YnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZl
cnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgQ2hyaXN0b3Bo
PGJyIGNsYXNzPSIiPiZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2Ui
PiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNv
bnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0Ozxz
cGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9
IiI+Jmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJz
cDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNv
bnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyBG
dXJ0aGVyLCBzZWdtZW50LTMgY2Fubm90IGNvbWJpbmUvY292ZXIgdGhlIGRhdGEgaW4gc2VnbWVu
dC0xIGFuZCBzZWdtZW50LTMgaW4gYSAic2luZ2xlIG1hcCIsIGFzIHRoZSBkYXRhIHNlcXVlbmNl
IHNwYWNlIGlzIG5vdCBjb250aW51b3VzLCBpLmUuLCBzb21lIGluIGJldHdlZW4gZGF0YSAoc2Vn
bWVudC0yKSBpcyBtYXBwZWQgYW5kIHRyYW5zbWl0dGVkIHRocm91Z2ggc3ViZmxvdy0yLiBIZXJl
LCB0aGUgbWFwIGluIHNlZ21lbnQtMyBkb2VzIG5vdCBldmVuIHBhcnRpYWxseSBjb3ZlciB0aGUg
ZGF0YSBpdCBjYXJyaWVzLjxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNw
Ozwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29u
dmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7PHNw
YW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0i
Ij4mZ3Q7ICZndDsgJmd0OyZuYnNwOzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2Ui
PiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBw
bGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAm
Z3Q7IEJvdGggUkZDIDY4MjQgYW5kIHRoZSA2ODI0LWJpcyBkbyBub3QgcmVzdHJpY3QgdGhlIGFi
b3ZlIHNjZW5hcmlvLCBhbmQgSSBndWVzcyB0aGUgY2hhbmdlIHByb3Bvc2VkIG5vdyBkb2VzIG5v
dCBwZXJtaXQgdGhpcyB0byBoYXBwZW4uPHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFj
ZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJB
cHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7
ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJy
IGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7Jm5ic3A7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRl
ZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OzxzcGFuIGNs
YXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0
OyAmZ3Q7ICZndDsgQmVzdCByZWdhcmRzLDxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3Bh
Y2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0i
QXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0
OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxi
ciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyZuYnNwOzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0
ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDs8c3BhbiBj
bGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZn
dDsgJmd0OyAmZ3Q7IEFuaWw8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJz
cDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNv
bnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0Ozxz
cGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9
IiI+Jmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJz
cDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBw
bGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAm
Z3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+
PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVy
dGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDs8
c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNz
PSIiPiZndDsgJmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNl
Ij4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFz
cz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsg
Jmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8
L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUt
Y29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7
ICZndDsgVGhhdCdzIHRoZSByZWFzb24gd2h5IHdlICh0aGUgTVBUQ1AtdXBzdHJlYW1pbmcgY29t
bXVuaXR5KSB2b3VjaCB0byBoYXZlIHRoaXMgY2FzZSByZXN0cmljdGVkLjxiciBjbGFzcz0iIj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5i
c3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFw
cGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFu
PjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IENoZWVycyw8YnIgY2xhc3M9IiI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyBDaHJpc3RvcGg8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xh
c3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3Bh
Y2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OzxzcGFuIGNs
YXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNw
Ozwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBs
ZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9z
cGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBw
bGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwv
c3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFw
cGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8
L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJB
cHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IEFuaWw8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4m
bmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OzxzcGFuIGNs
YXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNw
YWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBj
bGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1j
b252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8
L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PHNwYW4gY2xh
c3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3Bh
Y2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNs
YXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNv
bnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwv
c3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFz
cz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFj
ZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyBCZXN0IHJlZ2FyZHMsPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFz
cz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBBbGFuPGJyIGNsYXNzPSIiPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFj
ZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xh
c3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmbmJzcDs8c3BhbiBjbGFzcz0iQXBw
bGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5i
c3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFz
cz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZu
YnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJB
cHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bh
bj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252
ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xh
c3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyZuYnNwOzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0
ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0Ozxz
cGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9
IiI+Jmd0OyAmZ3Q7ICZndDs8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJz
cDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNv
bnZlcnRlZC1zcGFjZSI+Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDs8c3BhbiBj
bGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZn
dDsgJmd0OzxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwvc3Bhbj48
YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+
Jm5ic3A7PC9zcGFuPjxiciBjbGFzcz0iIj4mZ3Q7ICZndDsmbmJzcDs8c3BhbiBjbGFzcz0iQXBw
bGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGJyIGNsYXNzPSIiPiZndDsgJmd0Ozwv
ZGl2PjwvYmxvY2txdW90ZT5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXzxiciBjbGFzcz0iIj5tdWx0aXBhdGh0Y3AgbWFpbGluZyBsaXN0PGJyIGNsYXNzPSIi
PjxhIGNsYXNzPSIiIGhyZWY9Im1haWx0bzptdWx0aXBhdGh0Y3BAaWV0Zi5vcmciPm11bHRpcGF0
aHRjcEBpZXRmLm9yZzwvYT48YnIgY2xhc3M9IiI+PGEgY2xhc3M9IiIgaHJlZj0iaHR0cHM6Ly93
d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9tdWx0aXBhdGh0Y3AiIHJlbD0ibm9yZWZlcnJl
ciIgdGFyZ2V0PSIxIj5odHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL211bHRp
cGF0aHRjcDwvYT48L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwv
ZGl2PjwvdGQ+PC90cj48L3Rib2R5PjwvdGFibGU+PC9wPjwvc3Bhbj48L2Rpdj48L2Jsb2NrcXVv
dGU+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjxiciBjbGFzcz0iIj48L2JvZHk+PC9odG1sPg==
--===============7392603994905322374==--
