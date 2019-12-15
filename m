Content-Type: multipart/mixed; boundary="===============7379130102630303668=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] MPTCP implementation feedback for
 RFC6824bis
Date: Sun, 15 Dec 2019 18:05:31 +0100
Message-ID: <969B2D5D-83E7-41B8-A8DE-1D2036567401@apple.com>
In-Reply-To: CAAK044SYBVQjk3ch5B_+oUewHvihTFFcWThr9RLP=Wxz_wjFyw@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 3072

--===============7379130102630303668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

> On Dec 15, 2019, at 12:05 PM, Yoshifumi Nishida <nsd.ietf(a)gmail.com> wr=
ote:
> =

> Hi,
> One concern I have here is this may mean we end up want all implementatio=
ns to support late mapping feature.
> Because if an implementation that supports the feature uses it to send da=
ta, the receiver who doesn't support it will discard the packets. To avoid =
it, we need to mandate receivers to support it.

that is indeed the problem. Once we allow the sender to do late/early mappi=
ngs, a receiver has to implement it to be interoperable with all implementa=
tions.

More inline:

> On Sat, Dec 14, 2019 at 5:40 AM V Anil Kumar <anil(a)csir4pi.in <mailto:a=
nil(a)csir4pi.in>> wrote:
> Hi Christoph,
> =

> On 12/13/19 11:54 PM, Christoph Paasch <cpaasch(a)apple.com <mailto:cpaas=
ch(a)apple.com>> wrote:
>> =

>> =

[...]
>> > Well it could just be due to the lack of option space insegment-1. For
>> > example, the sender ofsegment-1 at that instant wants to transmit mult=
iple
>> > TCP options (e.g.timestamp, SACK, DSS and ADD_ADDR). Obviously, they a=
ll
>> > cannot fit into optionfield of one segment, and eventually the DSS
>> > transmission got slightly delayedby a segment or two.
>> =

>> The implementation needs to enforce a strict priority of DSS over SACK a=
nd ADD_ADDR.
> TCP options have evolved over a period of time, and I do not think as suc=
h any document/guidelines exist on  enforcing priority for one over the oth=
er, though it turns out be an interesting topic.  Also, more TCP options co=
uld come up in future for implementing  new features.  So, it is likely tha=
t implementations would follow different strategy when it come to option pr=
iority. =


This is purely an implementation choice. I don't think it is necessary to d=
ocument this.
For example, when TCP-MD5 is used, Linux disables the TCP Timestamp option,=
 thus enforcing priority of TCP-MD5 over Timestamps.


To re-iterate my earlier point: Unless there is real data about the perform=
ance benefits,... of enabling early/late mapping, my vote is to not allow t=
hese kind of mappings as they complexify implementations.


Christoph


>> =

>> =

>> If the ADD_ADDR does not fit in the TCP-option space, it can send the
>> ADD_ADDR on a pure ACK. The echo-bit in the ADD_ADDR guarantee the relia=
ble
>> delivery of it.
> I noticed this new feature in RFC 6824-bis to deliver ADD_ADDR in pure AC=
K and still achieve the reliability. The ability to deliver MPTCP options i=
n pure ACK will be useful, especially for options like ADD_ADDR.   =

>> =

>> =

>> Sure, one could argue that favoring SACK over DSS is more important. But=
 I
>> think we would need data to justify that. Only very specific traffic
>> patterns will fall in this use-case.
> The bottomline is that in the event of a map being slightly delayed, i.e.=
, delivered late with respect to the corresponding data, should  it result =
in resetting the subflow? =

> =

> As far as the specification is concerned, it could be liberal on acceptin=
g such maps, rather than being restrictive. Even if a current implementatio=
n cannot support this, future implementations may like to, provided the spe=
cification permits this and the implementation is willing to cop up with th=
e associated complexity. =

> =

> Best regards,
> =

> Anil
>> =

>> =

>> Christoph
>> =

>> > =

>> >  =

>> > =

>> > With regards,
>> > =

>> >  =

>> > =

>> > Anil
>> > =

>> >  =

>> > =

>> > > =

>> > > =

>> > > =

>> > > =

>> > > =

>> > > =

>> > > =

>> > > Christoph
>> > > =

>> > > =

>> > > > =

>> > > > =

>> > > > =

>> > > > Further, segment-3 cannot combine/cover the data in segment-1 and =
segment-3 in a "single map", as the data sequence space is not continuous, =
i.e., some in between data (segment-2) is mapped and transmitted through su=
bflow-2. Here, the map in segment-3 does not even partially cover the data =
it carries. =

>> > > > =

>> > > > =

>> > > >  =

>> > > > =

>> > > > Both RFC 6824 and the 6824-bis do not restrict the above scenario,=
 and I guess the change proposed now does not permit this to happen. =

>> > > > =

>> > > > =

>> > > >  =

>> > > > =

>> > > > Best regards, =

>> > > > =

>> > > > =

>> > > >  =

>> > > > =

>> > > > Anil =

>> > > > =

>> > > > =

>> > > > =

>> > > > > =

>> > > > > =

>> > > > > =

>> > > > > =

>> > > > > =

>> > > > > =

>> > > > > =

>> > > > > =

>> > > > > That's the reason why we (the MPTCP-upstreaming community) vouch=
 to have this case restricted.
>> > > > > =

>> > > > > =

>> > > > > =

>> > > > > Cheers,
>> > > > > Christoph
>> > > > > =

>> > > > > =

>> > > > > =

>> > > > > =

>> > > > > =

>> > > > > > =

>> > > > > > =

>> > > > > > =

>> > > > > > =

>> > > > > > =

>> > > > > > =

>> > > > > > Anil =

>> > > > > > =

>> > > > > > > =

>> > > > > > > =

>> > > > > > > =

>> > > > > > > =

>> > > > > > > =

>> > > > > > > =

>> > > > > > > =

>> > > > > > > =

>> > > > > > > =

>> > > > > > > =

>> > > > > > > =

>> > > > > > > Best regards,
>> > > > > > > =

>> > > > > > > Alan
>> > > > > > > =

>> > > > > > > =

>> > > > > > >  =

>> > > > > > > =

>> > > > > > =

>> > > > > > =

>> > > > > =

>> > > > > =

>> > > > > =

>> > > > > =

>> > > > >  =

>> > > > > =

>> > > > =

>> > > > =

>> > > =

>> > > =

>> > > =

>> > >  =

>> > >
> _______________________________________________
> multipathtcp mailing list
> multipathtcp(a)ietf.org <mailto:multipathtcp(a)ietf.org>
> https://www.ietf.org/mailman/listinfo/multipathtcp <https://www.ietf.org/=
mailman/listinfo/multipathtcp>


--===============7379130102630303668==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBi
cmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdo
aXRlLXNwYWNlOyIgY2xhc3M9IiI+SGVsbG8sPGJyIGNsYXNzPSIiPjxkaXY+PGJyIGNsYXNzPSIi
PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+T24gRGVjIDE1
LCAyMDE5LCBhdCAxMjowNSBQTSwgWW9zaGlmdW1pIE5pc2hpZGEgJmx0OzxhIGhyZWY9Im1haWx0
bzpuc2QuaWV0ZkBnbWFpbC5jb20iIGNsYXNzPSIiPm5zZC5pZXRmQGdtYWlsLmNvbTwvYT4mZ3Q7
IHdyb3RlOjwvZGl2PjxiciBjbGFzcz0iQXBwbGUtaW50ZXJjaGFuZ2UtbmV3bGluZSI+PGRpdiBj
bGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPkhpLDwvZGl2Pjxk
aXYgY2xhc3M9IiI+T25lIGNvbmNlcm4gSSBoYXZlIGhlcmUgaXMgdGhpcyBtYXkgbWVhbiB3ZSBl
bmQgdXAgd2FudCBhbGwgaW1wbGVtZW50YXRpb25zIHRvIHN1cHBvcnQgbGF0ZSBtYXBwaW5nIGZl
YXR1cmUuPGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+QmVjYXVzZSBpZiBhbiBpbXBs
ZW1lbnRhdGlvbiB0aGF0IHN1cHBvcnRzIHRoZSBmZWF0dXJlIHVzZXMgaXQgdG8gc2VuZCBkYXRh
LCB0aGUgcmVjZWl2ZXIgd2hvIGRvZXNuJ3Qgc3VwcG9ydCBpdCB3aWxsIGRpc2NhcmQgdGhlIHBh
Y2tldHMuIFRvIGF2b2lkIGl0LCB3ZSBuZWVkIHRvIG1hbmRhdGUgcmVjZWl2ZXJzIHRvIHN1cHBv
cnQgaXQuPC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyIGNsYXNzPSIiPjwv
ZGl2PjxkaXY+dGhhdCBpcyBpbmRlZWQgdGhlIHByb2JsZW0uIE9uY2Ugd2UgYWxsb3cgdGhlIHNl
bmRlciB0byBkbyBsYXRlL2Vhcmx5IG1hcHBpbmdzLCBhIHJlY2VpdmVyIGhhcyB0byBpbXBsZW1l
bnQgaXQgdG8gYmUgaW50ZXJvcGVyYWJsZSB3aXRoIGFsbCBpbXBsZW1lbnRhdGlvbnMuPC9kaXY+
PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdj5Nb3JlIGlubGluZTo8L2Rpdj48YnIgY2xhc3M9
IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IGRp
cj0ibHRyIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIg
Y2xhc3M9ImdtYWlsX2F0dHIiPk9uIFNhdCwgRGVjIDE0LCAyMDE5IGF0IDU6NDAgQU0gViBBbmls
IEt1bWFyICZsdDs8YSBocmVmPSJtYWlsdG86YW5pbEBjc2lyNHBpLmluIiBjbGFzcz0iIj5hbmls
QGNzaXI0cGkuaW48L2E+Jmd0OyB3cm90ZTo8YnIgY2xhc3M9IiI+PC9kaXY+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRl
ci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPkhpIENo
cmlzdG9waCw8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxzcGFuIGNsYXNzPSIiPk9uIDEyLzEz
LzE5IDExOjU0IFBNLCA8YiBjbGFzcz0iIj5DaHJpc3RvcGggUGFhc2NoIDwvYj4gJmx0OzxhIGhy
ZWY9Im1haWx0bzpjcGFhc2NoQGFwcGxlLmNvbSIgdGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSIiPmNw
YWFzY2hAYXBwbGUuY29tPC9hPiZndDsgd3JvdGU6PC9zcGFuPjxibG9ja3F1b3RlIHN0eWxlPSJi
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDAsMCwyNTUpO3BhZGRpbmctbGVmdDoxM3B4O21hcmdp
bi1sZWZ0OjBweCIgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9
IiI+PC9kaXY+PC9ibG9ja3F1b3RlPjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48L2Rpdj48L2Js
b2NrcXVvdGU+Wy4uLl08YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9
IiI+PGRpdiBjbGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSJnbWFp
bF9xdW90ZSI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBw
eCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3Bh
ZGRpbmctbGVmdDoxZXgiPjxibG9ja3F1b3RlIHN0eWxlPSJib3JkZXItbGVmdDoxcHggc29saWQg
cmdiKDAsMCwyNTUpO3BhZGRpbmctbGVmdDoxM3B4O21hcmdpbi1sZWZ0OjBweCIgdHlwZT0iY2l0
ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj4mZ3Q7IFdlbGwgaXQgY291bGQganVzdCBiZSBkdWUg
dG8gdGhlIGxhY2sgb2Ygb3B0aW9uIHNwYWNlIGluc2VnbWVudC0xLiBGb3I8YnIgY2xhc3M9IiI+
Jmd0OyBleGFtcGxlLCB0aGUgc2VuZGVyIG9mc2VnbWVudC0xIGF0IHRoYXQgaW5zdGFudCB3YW50
cyB0byB0cmFuc21pdCBtdWx0aXBsZTxiciBjbGFzcz0iIj4mZ3Q7IFRDUCBvcHRpb25zIChlLmcu
dGltZXN0YW1wLCBTQUNLLCBEU1MgYW5kIEFERF9BRERSKS4gT2J2aW91c2x5LCB0aGV5IGFsbDxi
ciBjbGFzcz0iIj4mZ3Q7IGNhbm5vdCBmaXQgaW50byBvcHRpb25maWVsZCBvZiBvbmUgc2VnbWVu
dCwgYW5kIGV2ZW50dWFsbHkgdGhlIERTUzxiciBjbGFzcz0iIj4mZ3Q7IHRyYW5zbWlzc2lvbiBn
b3Qgc2xpZ2h0bHkgZGVsYXllZGJ5IGEgc2VnbWVudCBvciB0d28uPGJyIGNsYXNzPSIiPjxiciBj
bGFzcz0iIj5UaGUgaW1wbGVtZW50YXRpb24gbmVlZHMgdG8gZW5mb3JjZSBhIHN0cmljdCBwcmlv
cml0eSBvZiBEU1Mgb3ZlciBTQUNLIGFuZCBBRERfQUREUi48L2Rpdj48L2Jsb2NrcXVvdGU+PGRp
diBjbGFzcz0iIj5UQ1Agb3B0aW9ucyBoYXZlIGV2b2x2ZWQgb3ZlciBhIHBlcmlvZCBvZiB0aW1l
LCBhbmQgSSBkbyBub3QgdGhpbmsgYXMgc3VjaCBhbnkgZG9jdW1lbnQvZ3VpZGVsaW5lcyBleGlz
dCBvbiAmbmJzcDtlbmZvcmNpbmcgcHJpb3JpdHkgZm9yIG9uZSBvdmVyIHRoZSBvdGhlciwgdGhv
dWdoIGl0IHR1cm5zIG91dCBiZSBhbiBpbnRlcmVzdGluZyB0b3BpYy4mbmJzcDsgQWxzbywgbW9y
ZSBUQ1Agb3B0aW9ucyBjb3VsZCBjb21lIHVwIGluIGZ1dHVyZSBmb3IgaW1wbGVtZW50aW5nICZu
YnNwO25ldyBmZWF0dXJlcy4mbmJzcDsgU28sIGl0IGlzIGxpa2VseSB0aGF0IGltcGxlbWVudGF0
aW9ucyB3b3VsZCBmb2xsb3cgZGlmZmVyZW50IHN0cmF0ZWd5IHdoZW4gaXQgY29tZSB0byBvcHRp
b24gcHJpb3JpdHkuJm5ic3A7PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjwvZGl2Pjwv
YmxvY2txdW90ZT48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2PlRoaXMgaXMgcHVyZWx5IGFu
IGltcGxlbWVudGF0aW9uIGNob2ljZS4gSSBkb24ndCB0aGluayBpdCBpcyBuZWNlc3NhcnkgdG8g
ZG9jdW1lbnQgdGhpcy48L2Rpdj48ZGl2PkZvciBleGFtcGxlLCB3aGVuIFRDUC1NRDUgaXMgdXNl
ZCwgTGludXggZGlzYWJsZXMgdGhlIFRDUCBUaW1lc3RhbXAgb3B0aW9uLCB0aHVzIGVuZm9yY2lu
ZyBwcmlvcml0eSBvZiBUQ1AtTUQ1IG92ZXIgVGltZXN0YW1wcy48L2Rpdj48ZGl2PjxiciBjbGFz
cz0iIj48L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2PlRvIHJlLWl0ZXJhdGUgbXkg
ZWFybGllciBwb2ludDogVW5sZXNzIHRoZXJlIGlzIHJlYWwgZGF0YSBhYm91dCB0aGUgcGVyZm9y
bWFuY2UgYmVuZWZpdHMsLi4uIG9mIGVuYWJsaW5nIGVhcmx5L2xhdGUgbWFwcGluZywgbXkgdm90
ZSBpcyB0byBub3QgYWxsb3cgdGhlc2Uga2luZCBvZiBtYXBwaW5ncyBhcyB0aGV5IGNvbXBsZXhp
ZnkgaW1wbGVtZW50YXRpb25zLjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+PGJy
IGNsYXNzPSIiPjwvZGl2PjxkaXY+Q2hyaXN0b3BoPC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9k
aXY+PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xh
c3M9IiI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAw
LjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6
MWV4Ij48YmxvY2txdW90ZSBzdHlsZT0iYm9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigwLDAsMjU1
KTtwYWRkaW5nLWxlZnQ6MTNweDttYXJnaW4tbGVmdDowcHgiIHR5cGU9ImNpdGUiIGNsYXNzPSIi
PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5JZiB0aGUgQUREX0FERFIg
ZG9lcyBub3QgZml0IGluIHRoZSBUQ1Atb3B0aW9uIHNwYWNlLCBpdCBjYW4gc2VuZCB0aGU8YnIg
Y2xhc3M9IiI+QUREX0FERFIgb24gYSBwdXJlIEFDSy4gVGhlIGVjaG8tYml0IGluIHRoZSBBRERf
QUREUiBndWFyYW50ZWUgdGhlIHJlbGlhYmxlPGJyIGNsYXNzPSIiPmRlbGl2ZXJ5IG9mIGl0Ljxi
ciBjbGFzcz0iIj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdiBjbGFzcz0iIj5JIG5vdGljZWQgdGhp
cyBuZXcgZmVhdHVyZSBpbiBSRkMgNjgyNC1iaXMgdG8gZGVsaXZlciBBRERfQUREUiBpbiBwdXJl
IEFDSyBhbmQgc3RpbGwgYWNoaWV2ZSB0aGUgcmVsaWFiaWxpdHkuIFRoZSBhYmlsaXR5IHRvIGRl
bGl2ZXIgTVBUQ1Agb3B0aW9ucyBpbiBwdXJlIEFDSyB3aWxsIGJlIHVzZWZ1bCwgZXNwZWNpYWxs
eSBmb3Igb3B0aW9ucyBsaWtlIEFERF9BRERSLiAmbmJzcDsmbmJzcDs8L2Rpdj48YmxvY2txdW90
ZSBzdHlsZT0iYm9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigwLDAsMjU1KTtwYWRkaW5nLWxlZnQ6
MTNweDttYXJnaW4tbGVmdDowcHgiIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+
PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5TdXJlLCBvbmUgY291bGQgYXJndWUgdGhhdCBmYXZv
cmluZyBTQUNLIG92ZXIgRFNTIGlzIG1vcmUgaW1wb3J0YW50LiBCdXQgSTxiciBjbGFzcz0iIj50
aGluayB3ZSB3b3VsZCBuZWVkIGRhdGEgdG8ganVzdGlmeSB0aGF0LiBPbmx5IHZlcnkgc3BlY2lm
aWMgdHJhZmZpYzxiciBjbGFzcz0iIj5wYXR0ZXJucyB3aWxsIGZhbGwgaW4gdGhpcyB1c2UtY2Fz
ZS48YnIgY2xhc3M9IiI+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXYgY2xhc3M9IiI+VGhlIGJvdHRv
bWxpbmUgaXMgdGhhdCBpbiB0aGUgZXZlbnQgb2YgYSBtYXAgYmVpbmcgc2xpZ2h0bHkgZGVsYXll
ZCwgaS5lLiwgZGVsaXZlcmVkIGxhdGUgd2l0aCByZXNwZWN0IHRvIHRoZSBjb3JyZXNwb25kaW5n
IGRhdGEsIHNob3VsZCAmbmJzcDtpdCByZXN1bHQgaW4gcmVzZXR0aW5nIHRoZSBzdWJmbG93PyZu
YnNwOzwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+
QXMgZmFyIGFzIHRoZSBzcGVjaWZpY2F0aW9uIGlzIGNvbmNlcm5lZCwgaXQgY291bGQgYmUgbGli
ZXJhbCBvbiBhY2NlcHRpbmcgc3VjaCBtYXBzLCByYXRoZXIgdGhhbiBiZWluZyByZXN0cmljdGl2
ZS4gRXZlbiBpZiBhIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gY2Fubm90IHN1cHBvcnQgdGhpcywg
ZnV0dXJlIGltcGxlbWVudGF0aW9ucyBtYXkgbGlrZSB0bywgcHJvdmlkZWQgdGhlIHNwZWNpZmlj
YXRpb24gcGVybWl0cyB0aGlzIGFuZCB0aGUgaW1wbGVtZW50YXRpb24gaXMgd2lsbGluZyB0byBj
b3AgdXAgd2l0aCB0aGUgYXNzb2NpYXRlZCBjb21wbGV4aXR5LiZuYnNwOzwvZGl2PjxkaXYgY2xh
c3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+QmVzdCByZWdhcmRzLDwvZGl2
PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+QW5pbDwvZGl2
PjxibG9ja3F1b3RlIHN0eWxlPSJib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDAsMCwyNTUpO3Bh
ZGRpbmctbGVmdDoxM3B4O21hcmdpbi1sZWZ0OjBweCIgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRp
diBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPkNocmlzdG9waDxiciBjbGFzcz0i
Ij48YnIgY2xhc3M9IiI+Jmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyZuYnNwOyA8YnIgY2xhc3M9IiI+
Jmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyBXaXRoIHJlZ2FyZHMsPGJyIGNsYXNzPSIiPiZndDsgPGJy
IGNsYXNzPSIiPiZndDsmbmJzcDsgPGJyIGNsYXNzPSIiPiZndDsgPGJyIGNsYXNzPSIiPiZndDsg
QW5pbDxiciBjbGFzcz0iIj4mZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7Jm5ic3A7IDxiciBjbGFzcz0i
Ij4mZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyA8YnIg
Y2xhc3M9IiI+Jmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgPGJyIGNsYXNzPSIiPiZn
dDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgPGJy
IGNsYXNzPSIiPiZndDsgJmd0OyBDaHJpc3RvcGg8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7IDxiciBj
bGFzcz0iIj4mZ3Q7ICZndDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0i
Ij4mZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIi
PiZndDsgJmd0OyAmZ3Q7IEZ1cnRoZXIsIHNlZ21lbnQtMyBjYW5ub3QgY29tYmluZS9jb3ZlciB0
aGUgZGF0YSBpbiBzZWdtZW50LTEgYW5kIHNlZ21lbnQtMyBpbiBhICJzaW5nbGUgbWFwIiwgYXMg
dGhlIGRhdGEgc2VxdWVuY2Ugc3BhY2UgaXMgbm90IGNvbnRpbnVvdXMsIGkuZS4sIHNvbWUgaW4g
YmV0d2VlbiBkYXRhIChzZWdtZW50LTIpIGlzIG1hcHBlZCBhbmQgdHJhbnNtaXR0ZWQgdGhyb3Vn
aCBzdWJmbG93LTIuIEhlcmUsIHRoZSBtYXAgaW4gc2VnbWVudC0zIGRvZXMgbm90IGV2ZW4gcGFy
dGlhbGx5IGNvdmVyIHRoZSBkYXRhIGl0IGNhcnJpZXMuIDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsg
Jmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAm
Z3Q7Jm5ic3A7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAm
Z3Q7ICZndDsgQm90aCBSRkMgNjgyNCBhbmQgdGhlIDY4MjQtYmlzIGRvIG5vdCByZXN0cmljdCB0
aGUgYWJvdmUgc2NlbmFyaW8sIGFuZCBJIGd1ZXNzIHRoZSBjaGFuZ2UgcHJvcG9zZWQgbm93IGRv
ZXMgbm90IHBlcm1pdCB0aGlzIHRvIGhhcHBlbi4gPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7
IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsm
bmJzcDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsg
Jmd0OyBCZXN0IHJlZ2FyZHMsIDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9
IiI+Jmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7Jm5ic3A7IDxiciBj
bGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgQW5pbCA8
YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7IDxi
ciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIg
Y2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyBUaGF0J3MgdGhlIHJlYXNvbiB3
aHkgd2UgKHRoZSBNUFRDUC11cHN0cmVhbWluZyBjb21tdW5pdHkpIHZvdWNoIHRvIGhhdmUgdGhp
cyBjYXNlIHJlc3RyaWN0ZWQuPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNs
YXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgQ2hlZXJzLDxiciBjbGFzcz0iIj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7IENocmlzdG9waDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0i
Ij4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgQW5pbCA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0i
Ij4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9
IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNz
PSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEJlc3QgcmVn
YXJkcyw8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNz
PSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEFsYW48YnIgY2xhc3M9IiI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZuYnNw
OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIi
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFz
cz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
Jm5ic3A7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7
ICZndDsgJmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiPiZndDsg
Jmd0OyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7IDxiciBjbGFzcz0iIj4mZ3Q7ICZndDsgPGJyIGNs
YXNzPSIiPiZndDsgJmd0OyZuYnNwOyA8YnIgY2xhc3M9IiI+Jmd0OyAmZ3Q7PC9kaXY+PC9ibG9j
a3F1b3RlPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
PGJyIGNsYXNzPSIiPgptdWx0aXBhdGh0Y3AgbWFpbGluZyBsaXN0PGJyIGNsYXNzPSIiPgo8YSBo
cmVmPSJtYWlsdG86bXVsdGlwYXRodGNwQGlldGYub3JnIiB0YXJnZXQ9Il9ibGFuayIgY2xhc3M9
IiI+bXVsdGlwYXRodGNwQGlldGYub3JnPC9hPjxiciBjbGFzcz0iIj4KPGEgaHJlZj0iaHR0cHM6
Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9tdWx0aXBhdGh0Y3AiIHJlbD0ibm9yZWZl
cnJlciIgdGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSIiPmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxt
YW4vbGlzdGluZm8vbXVsdGlwYXRodGNwPC9hPjxiciBjbGFzcz0iIj4KPC9ibG9ja3F1b3RlPjwv
ZGl2PjwvZGl2Pgo8L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyIGNsYXNzPSIiPjwvYm9keT48
L2h0bWw+
--===============7379130102630303668==--
