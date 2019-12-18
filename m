Content-Type: multipart/mixed; boundary="===============3793973138530705422=="
MIME-Version: 1.0
From: V Anil Kumar <anil at csir4pi.in>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] MPTCP implementation feedback for
 RFC6824bis
Date: Wed, 18 Dec 2019 10:37:36 +0530
Message-ID: <fa96b8487de1.5dfa0170@nic.in>
In-Reply-To: 969B2D5D-83E7-41B8-A8DE-1D2036567401@apple.com
X-Status: 
X-Keywords:                  
X-UID: 3133

--===============3793973138530705422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/15/19 10:35 PM, Christoph Paasch  <cpaasch(a)apple.com> wrote: =

> =

> =

> =

> =

> =

> Hello,
> =

> =

> =

> =

> > =

> > On Dec 15, 2019, at 12:05 PM, Yoshifumi Nishida <nsd.ietf(a)gmail.com> =
wrote:
> > =

> > =

> > =

> > =

> > Hi,
> > =

> > One concern I have here is this may mean we end up want all implementat=
ions to support late mapping feature.
> > =

> > =

> > Because if an implementation that supports the feature uses it to send =
data, the receiver who doesn't support it will discard the packets. To avoi=
d it, we need to mandate receivers to support it.
> > =

> > =

> =

> =

> that is indeed the problem. Once we allow the sender to do late/early map=
pings, a receiver has to implement it to be interoperable with all implemen=
tations.
> =

> More inline:
> =

> =

> > =

> > =

> > =

> > =

> > On Sat, Dec 14, 2019 at 5:40 AM V Anil Kumar <anil(a)csir4pi.in> wrote:
> > =

> > =

> > > Hi Christoph,
> > > =

> > > On 12/13/19 11:54 PM, Christoph Paasch  <cpaasch(a)apple.com> wrote: =

> > > > =

> > > > =

> > > > =

> > > > =

> > > =

> > =

> > =

> > =

> [...]
> =

> > =

> > =

> > =

> > =

> > > =

> > > > =

> > > > > Well it could just be due to the lack of option space insegment-1=
. For
> > > > > example, the sender ofsegment-1 at that instant wants to transmit=
 multiple
> > > > > TCP options (e.g.timestamp, SACK, DSS and ADD_ADDR). Obviously, t=
hey all
> > > > > cannot fit into optionfield of one segment, and eventually the DSS
> > > > > transmission got slightly delayedby a segment or two.
> > > > =

> > > > The implementation needs to enforce a strict priority of DSS over S=
ACK and ADD_ADDR.
> > > > =

> > > =

> > > TCP options have evolved over a period of time, and I do not think as=
 such any document/guidelines exist on enforcing priority for one over the =
other, though it turns out be an interesting topic. Also, more TCP options =
could come up in future for implementing new features. So, it is likely tha=
t implementations would follow different strategy when it come to option pr=
iority. =

> > > =

> > =

> > =

> > =

> =

> =

> This is purely an implementation choice. I don't think it is necessary to=
 document this.
> For example, when TCP-MD5 is used, Linux disables the TCP Timestamp optio=
n, thus enforcing priority of TCP-MD5 over Timestamps.
> =

> =

> =

> To re-iterate my earlier point: Unless there is real data about the perfo=
rmance benefits,... of enabling early/late mapping, my vote is to not allow=
 these kind of mappings as they complexify implementations.
> =

> =

>  =

> =



When MPTCP is used for data transfer in both directions, the need to carry =
both timestamp and SACK options in a data segment may not be a rare case, a=
s data loss or out-of-order reception can happen in both directions. On suc=
h a data segment, once timestamp and SACK options are included, packing DSS=
 with map is not feasible. Should the data segment in such case include SAC=
K or DSS? How does the Linux implementation of MPTCP deal with such a case?

 =


Anil
 =


> =

> =

> =

> =

> =

> =

> =

> =

> =

> Christoph
> =

> =

> =

> > =

> > =

> > =

> > =

> > > =

> > > > =

> > > > =

> > > > =

> > > > If the ADD_ADDR does not fit in the TCP-option space, it can send t=
he
> > > > ADD_ADDR on a pure ACK. The echo-bit in the ADD_ADDR guarantee the =
reliable
> > > > delivery of it.
> > > > =

> > > > =

> > > =

> > > I noticed this new feature in RFC 6824-bis to deliver ADD_ADDR in pur=
e ACK and still achieve the reliability. The ability to deliver MPTCP optio=
ns in pure ACK will be useful, especially for options like ADD_ADDR. =

> > > =

> > > > =

> > > > =

> > > > =

> > > > Sure, one could argue that favoring SACK over DSS is more important=
. But I
> > > > think we would need data to justify that. Only very specific traffic
> > > > patterns will fall in this use-case.
> > > > =

> > > > =

> > > =

> > > The bottomline is that in the event of a map being slightly delayed, =
i.e., delivered late with respect to the corresponding data, should it resu=
lt in resetting the subflow? =

> > > =

> > > =

> > > =

> > > =

> > > As far as the specification is concerned, it could be liberal on acce=
pting such maps, rather than being restrictive. Even if a current implement=
ation cannot support this, future implementations may like to, provided the=
 specification permits this and the implementation is willing to cop up wit=
h the associated complexity. =

> > > =

> > > =

> > > =

> > > =

> > > Best regards,
> > > =

> > > =

> > > =

> > > =

> > > Anil
> > > =

> > > > =

> > > > =

> > > > =

> > > > Christoph
> > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > With regards,
> > > > > =

> > > > > =

> > > > > =

> > > > > Anil
> > > > > =

> > > > > =

> > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > Christoph
> > > > > > =

> > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > Further, segment-3 cannot combine/cover the data in segment-1=
 and segment-3 in a "single map", as the data sequence space is not continu=
ous, i.e., some in between data (segment-2) is mapped and transmitted throu=
gh subflow-2. Here, the map in segment-3 does not even partially cover the =
data it carries. =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > Both RFC 6824 and the 6824-bis do not restrict the above scen=
ario, and I guess the change proposed now does not permit this to happen. =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > Best regards, =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > Anil =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > That's the reason why we (the MPTCP-upstreaming community) =
vouch to have this case restricted.
> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > Cheers,
> > > > > > > > Christoph
> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > > =

> > > > > > > > > =

> > > > > > > > > =

> > > > > > > > > =

> > > > > > > > > =

> > > > > > > > > =

> > > > > > > > > Anil =

> > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > Best regards,
> > > > > > > > > > =

> > > > > > > > > > Alan
> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > > =

> > > > > > > > > =

> > > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > >
> > > > =

> > > _______________________________________________
> > > multipathtcp mailing list
> > > multipathtcp(a)ietf.org
> > > https://www.ietf.org/mailman/listinfo/multipathtcp
> > > =

> > =

> > =

> > =

> =

> =

> =

> =

>  =

>=20

--===============3793973138530705422==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyIC8+PGJyIC8+PHNwYW4+T24gMTIvMTUvMTkgMTA6MzUgUE0sIDxiIGNsYXNzPSJuYW1l
Ij5DaHJpc3RvcGggUGFhc2NoIDwvYj4gJmx0O2NwYWFzY2hAYXBwbGUuY29tJmd0OyB3cm90ZTo8
L3NwYW4+PGJsb2NrcXVvdGUgY2l0ZT0ibWlkOjk2OUIyRDVELTgzRTctNDFCOC1BOERFLTFEMjAz
NjU2NzQwMUBhcHBsZS5jb20iIGNsYXNzPSJpd2NRdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAx
cHggc29saWQgIzAwRjsgcGFkZGluZy1sZWZ0OiAxM3B4OyBtYXJnaW4tbGVmdDogMDsiIHR5cGU9
ImNpdGUiPjxkaXYgY2xhc3M9Im1pbWV0eXBlLXRleHQtaHRtbCI+PHNwYW4+PHA+PG1ldGEgY29u
dGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXVzLWFzY2lpIiBodHRwLWVxdWl2PSJDb250ZW50LVR5
cGUiIC8+PHRhYmxlPjx0Ym9keT48dHI+PHRkIGNsYXNzPSIiIHN0eWxlPSJ3b3JkLXdyYXA6IGJy
ZWFrLXdvcmQ7IC13ZWJraXQtbmJzcC1tb2RlOiBzcGFjZTsgbGluZS1icmVhazogYWZ0ZXItd2hp
dGUtc3BhY2U7Ij48cD5IZWxsbyw8YnIgY2xhc3M9IiIgLz48L3A+PGRpdj48YnIgY2xhc3M9IiIg
Lz48YmxvY2txdW90ZSBjbGFzcz0iIiB0eXBlPSJjaXRlIj48ZGl2IGNsYXNzPSIiPk9uIERlYyAx
NSwgMjAxOSwgYXQgMTI6MDUgUE0sIFlvc2hpZnVtaSBOaXNoaWRhICZsdDs8YSBjbGFzcz0iIiBo
cmVmPSJtYWlsdG86bnNkLmlldGZAZ21haWwuY29tIj5uc2QuaWV0ZkBnbWFpbC5jb208L2E+Jmd0
OyB3cm90ZTo8L2Rpdj48YnIgY2xhc3M9IkFwcGxlLWludGVyY2hhbmdlLW5ld2xpbmUiIC8+PGRp
diBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiIGRpcj0ibHRyIj48ZGl2IGNsYXNzPSIiPkhpLDwvZGl2
PjxkaXYgY2xhc3M9IiI+T25lIGNvbmNlcm4gSSBoYXZlIGhlcmUgaXMgdGhpcyBtYXkgbWVhbiB3
ZSBlbmQgdXAgd2FudCBhbGwgaW1wbGVtZW50YXRpb25zIHRvIHN1cHBvcnQgbGF0ZSBtYXBwaW5n
IGZlYXR1cmUuPGJyIGNsYXNzPSIiIC8+PC9kaXY+PGRpdiBjbGFzcz0iIj5CZWNhdXNlIGlmIGFu
IGltcGxlbWVudGF0aW9uIHRoYXQgc3VwcG9ydHMgdGhlIGZlYXR1cmUgdXNlcyBpdCB0byBzZW5k
IGRhdGEsIHRoZSByZWNlaXZlciB3aG8gZG9lc24ndCBzdXBwb3J0IGl0IHdpbGwgZGlzY2FyZCB0
aGUgcGFja2V0cy4gVG8gYXZvaWQgaXQsIHdlIG5lZWQgdG8gbWFuZGF0ZSByZWNlaXZlcnMgdG8g
c3VwcG9ydCBpdC48L2Rpdj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48YnIgY2xhc3M9
IiIgLz48L2Rpdj48ZGl2PnRoYXQgaXMgaW5kZWVkIHRoZSBwcm9ibGVtLiBPbmNlIHdlIGFsbG93
IHRoZSBzZW5kZXIgdG8gZG8gbGF0ZS9lYXJseSBtYXBwaW5ncywgYSByZWNlaXZlciBoYXMgdG8g
aW1wbGVtZW50IGl0IHRvIGJlIGludGVyb3BlcmFibGUgd2l0aCBhbGwgaW1wbGVtZW50YXRpb25z
LjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiIC8+PC9kaXY+PGRpdj5Nb3JlIGlubGluZTo8L2Rpdj48
YnIgY2xhc3M9IiIgLz48YmxvY2txdW90ZSBjbGFzcz0iIiB0eXBlPSJjaXRlIj48ZGl2IGNsYXNz
PSIiPjxkaXYgY2xhc3M9IiIgZGlyPSJsdHIiPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2
IGNsYXNzPSJnbWFpbF9hdHRyIiBkaXI9Imx0ciI+T24gU2F0LCBEZWMgMTQsIDIwMTkgYXQgNTo0
MCBBTSBWIEFuaWwgS3VtYXIgJmx0OzxhIGNsYXNzPSIiIGhyZWY9Im1haWx0bzphbmlsQGNzaXI0
cGkuaW4iPmFuaWxAY3NpcjRwaS5pbjwvYT4mZ3Q7IHdyb3RlOjxiciBjbGFzcz0iIiAvPjwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBw
eCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxl
ZnQ6MWV4Ij5IaSBDaHJpc3RvcGgsPGJyIGNsYXNzPSIiIC8+PGJyIGNsYXNzPSIiIC8+PHNwYW4g
Y2xhc3M9IiI+T24gMTIvMTMvMTkgMTE6NTQgUE0sIDxiIGNsYXNzPSIiPkNocmlzdG9waCBQYWFz
Y2ggPC9iPiAmbHQ7PGEgY2xhc3M9IiIgaHJlZj0ibWFpbHRvOmNwYWFzY2hAYXBwbGUuY29tIj5j
cGFhc2NoQGFwcGxlLmNvbTwvYT4mZ3Q7IHdyb3RlOjwvc3Bhbj48YmxvY2txdW90ZSBjbGFzcz0i
IiBzdHlsZT0iYm9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigwLDAsMjU1KTtwYWRkaW5nLWxlZnQ6
MTNweDttYXJnaW4tbGVmdDowcHgiIHR5cGU9ImNpdGUiPjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNz
PSIiIC8+PC9kaXY+PC9ibG9ja3F1b3RlPjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48L2Rpdj48
L2Jsb2NrcXVvdGU+Wy4uLl08YnIgY2xhc3M9IiIgLz48YmxvY2txdW90ZSBjbGFzcz0iIiB0eXBl
PSJjaXRlIj48ZGl2IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiIgZGlyPSJsdHIiPjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIw
NCk7cGFkZGluZy1sZWZ0OjFleCI+PGJsb2NrcXVvdGUgY2xhc3M9IiIgc3R5bGU9ImJvcmRlci1s
ZWZ0OjFweCBzb2xpZCByZ2IoMCwwLDI1NSk7cGFkZGluZy1sZWZ0OjEzcHg7bWFyZ2luLWxlZnQ6
MHB4IiB0eXBlPSJjaXRlIj48ZGl2IGNsYXNzPSIiPiZndDsgV2VsbCBpdCBjb3VsZCBqdXN0IGJl
IGR1ZSB0byB0aGUgbGFjayBvZiBvcHRpb24gc3BhY2UgaW5zZWdtZW50LTEuIEZvcjxiciBjbGFz
cz0iIiAvPiZndDsgZXhhbXBsZSwgdGhlIHNlbmRlciBvZnNlZ21lbnQtMSBhdCB0aGF0IGluc3Rh
bnQgd2FudHMgdG8gdHJhbnNtaXQgbXVsdGlwbGU8YnIgY2xhc3M9IiIgLz4mZ3Q7IFRDUCBvcHRp
b25zIChlLmcudGltZXN0YW1wLCBTQUNLLCBEU1MgYW5kIEFERF9BRERSKS4gT2J2aW91c2x5LCB0
aGV5IGFsbDxiciBjbGFzcz0iIiAvPiZndDsgY2Fubm90IGZpdCBpbnRvIG9wdGlvbmZpZWxkIG9m
IG9uZSBzZWdtZW50LCBhbmQgZXZlbnR1YWxseSB0aGUgRFNTPGJyIGNsYXNzPSIiIC8+Jmd0OyB0
cmFuc21pc3Npb24gZ290IHNsaWdodGx5IGRlbGF5ZWRieSBhIHNlZ21lbnQgb3IgdHdvLjxiciBj
bGFzcz0iIiAvPjxiciBjbGFzcz0iIiAvPlRoZSBpbXBsZW1lbnRhdGlvbiBuZWVkcyB0byBlbmZv
cmNlIGEgc3RyaWN0IHByaW9yaXR5IG9mIERTUyBvdmVyIFNBQ0sgYW5kIEFERF9BRERSLjwvZGl2
PjwvYmxvY2txdW90ZT48ZGl2IGNsYXNzPSIiPlRDUCBvcHRpb25zIGhhdmUgZXZvbHZlZCBvdmVy
IGEgcGVyaW9kIG9mIHRpbWUsIGFuZCBJIGRvIG5vdCB0aGluayBhcyBzdWNoIGFueSBkb2N1bWVu
dC9ndWlkZWxpbmVzIGV4aXN0IG9uIKBlbmZvcmNpbmcgcHJpb3JpdHkgZm9yIG9uZSBvdmVyIHRo
ZSBvdGhlciwgdGhvdWdoIGl0IHR1cm5zIG91dCBiZSBhbiBpbnRlcmVzdGluZyB0b3BpYy6gIEFs
c28sIG1vcmUgVENQIG9wdGlvbnMgY291bGQgY29tZSB1cCBpbiBmdXR1cmUgZm9yIGltcGxlbWVu
dGluZyCgbmV3IGZlYXR1cmVzLqAgU28sIGl0IGlzIGxpa2VseSB0aGF0IGltcGxlbWVudGF0aW9u
cyB3b3VsZCBmb2xsb3cgZGlmZmVyZW50IHN0cmF0ZWd5IHdoZW4gaXQgY29tZSB0byBvcHRpb24g
cHJpb3JpdHkuoDwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVv
dGU+PGRpdj48YnIgY2xhc3M9IiIgLz48L2Rpdj48ZGl2PlRoaXMgaXMgcHVyZWx5IGFuIGltcGxl
bWVudGF0aW9uIGNob2ljZS4gSSBkb24ndCB0aGluayBpdCBpcyBuZWNlc3NhcnkgdG8gZG9jdW1l
bnQgdGhpcy48L2Rpdj48ZGl2PkZvciBleGFtcGxlLCB3aGVuIFRDUC1NRDUgaXMgdXNlZCwgTGlu
dXggZGlzYWJsZXMgdGhlIFRDUCBUaW1lc3RhbXAgb3B0aW9uLCB0aHVzIGVuZm9yY2luZyBwcmlv
cml0eSBvZiBUQ1AtTUQ1IG92ZXIgVGltZXN0YW1wcy48L2Rpdj48ZGl2PjxiciBjbGFzcz0iIiAv
PjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiIC8+PC9kaXY+PGRpdj5UbyByZS1pdGVyYXRlIG15IGVh
cmxpZXIgcG9pbnQ6IFVubGVzcyB0aGVyZSBpcyByZWFsIGRhdGEgYWJvdXQgdGhlIHBlcmZvcm1h
bmNlIGJlbmVmaXRzLC4uLiBvZiBlbmFibGluZyBlYXJseS9sYXRlIG1hcHBpbmcsIG15IHZvdGUg
aXMgdG8gbm90IGFsbG93IHRoZXNlIGtpbmQgb2YgbWFwcGluZ3MgYXMgdGhleSBjb21wbGV4aWZ5
IGltcGxlbWVudGF0aW9ucy48L2Rpdj48L2Rpdj48L3RkPjwvdHI+PC90Ym9keT48L3RhYmxlPjwv
cD48L3NwYW4+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyIC8+PC9kaXY+PHAgY2xhc3M9Ik1z
b05vcm1hbCIgc3R5bGU9InRleHQtYWxpZ246IGp1c3RpZnk7Ij5XaGVuIE1QVENQIGlzIHVzZWQg
Zm9yIGRhdGEgdHJhbnNmZXIgaW4gYm90aCBkaXJlY3Rpb25zLCB0aGUgbmVlZCB0byBjYXJyeSBi
b3RoIHRpbWVzdGFtcCBhbmQgU0FDSyBvcHRpb25zIGluIGEgZGF0YSBzZWdtZW50IG1heSBub3Qg
YmUgYSByYXJlIGNhc2UsIGFzIGRhdGEgbG9zcyBvciBvdXQtb2Ytb3JkZXIgcmVjZXB0aW9uIGNh
biBoYXBwZW4gaW4gYm90aCBkaXJlY3Rpb25zLiBPbiBzdWNoIGEgZGF0YSBzZWdtZW50LCBvbmNl
IHRpbWVzdGFtcCBhbmQgU0FDSyBvcHRpb25zIGFyZSBpbmNsdWRlZCwgcGFja2luZyBEU1Mgd2l0
aCBtYXAgaXMgbm90IGZlYXNpYmxlLiBTaG91bGQgdGhlIGRhdGEgc2VnbWVudCBpbiBzdWNoIGNh
c2UgaW5jbHVkZSBTQUNLIG9yIERTUz8gSG93IGRvZXMgdGhlIExpbnV4IGltcGxlbWVudGF0aW9u
IG9mIE1QVENQIGRlYWwgd2l0aCBzdWNoIGEgY2FzZT88bzpwPjwvbzpwPjwvcD48cCBjbGFzcz0i
TXNvTm9ybWFsIiBzdHlsZT0idGV4dC1hbGlnbjoganVzdGlmeTsiPjxvOnA+oDwvbzpwPjwvcD48
ZGl2PkFuaWw8L2Rpdj48ZGl2ID48YnIgLz48L2Rpdj48YmxvY2txdW90ZSBjaXRlPSJtaWQ6OTY5
QjJENUQtODNFNy00MUI4LUE4REUtMUQyMDM2NTY3NDAxQGFwcGxlLmNvbSIgY2xhc3M9Iml3Y1F1
b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCAjMDBGOyBwYWRkaW5nLWxlZnQ6IDEz
cHg7IG1hcmdpbi1sZWZ0OiAwOyIgdHlwZT0iY2l0ZSI+PGRpdiBjbGFzcz0ibWltZXR5cGUtdGV4
dC1odG1sIj48c3Bhbj48cD48dGFibGU+PHRib2R5Pjx0cj48dGQgY2xhc3M9IiIgc3R5bGU9Indv
cmQtd3JhcDogYnJlYWstd29yZDsgLXdlYmtpdC1uYnNwLW1vZGU6IHNwYWNlOyBsaW5lLWJyZWFr
OiBhZnRlci13aGl0ZS1zcGFjZTsiPjxkaXY+PGRpdiA+PGJyIC8+PC9kaXY+PGRpdj48YnIgY2xh
c3M9IiIgLz48L2Rpdj48ZGl2PjxiciBjbGFzcz0iIiAvPjwvZGl2PjxkaXY+Q2hyaXN0b3BoPC9k
aXY+PGRpdj48YnIgY2xhc3M9IiIgLz48L2Rpdj48YnIgY2xhc3M9IiIgLz48YmxvY2txdW90ZSBj
bGFzcz0iIiB0eXBlPSJjaXRlIj48ZGl2IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiIgZGlyPSJsdHIi
PjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJn
YigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGJsb2NrcXVvdGUgY2xhc3M9IiIgc3R5
bGU9ImJvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMCwwLDI1NSk7cGFkZGluZy1sZWZ0OjEzcHg7
bWFyZ2luLWxlZnQ6MHB4IiB0eXBlPSJjaXRlIj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIiAv
PjxiciBjbGFzcz0iIiAvPklmIHRoZSBBRERfQUREUiBkb2VzIG5vdCBmaXQgaW4gdGhlIFRDUC1v
cHRpb24gc3BhY2UsIGl0IGNhbiBzZW5kIHRoZTxiciBjbGFzcz0iIiAvPkFERF9BRERSIG9uIGEg
cHVyZSBBQ0suIFRoZSBlY2hvLWJpdCBpbiB0aGUgQUREX0FERFIgZ3VhcmFudGVlIHRoZSByZWxp
YWJsZTxiciBjbGFzcz0iIiAvPmRlbGl2ZXJ5IG9mIGl0LjxiciBjbGFzcz0iIiAvPjwvZGl2Pjwv
YmxvY2txdW90ZT48ZGl2IGNsYXNzPSIiPkkgbm90aWNlZCB0aGlzIG5ldyBmZWF0dXJlIGluIFJG
QyA2ODI0LWJpcyB0byBkZWxpdmVyIEFERF9BRERSIGluIHB1cmUgQUNLIGFuZCBzdGlsbCBhY2hp
ZXZlIHRoZSByZWxpYWJpbGl0eS4gVGhlIGFiaWxpdHkgdG8gZGVsaXZlciBNUFRDUCBvcHRpb25z
IGluIHB1cmUgQUNLIHdpbGwgYmUgdXNlZnVsLCBlc3BlY2lhbGx5IGZvciBvcHRpb25zIGxpa2Ug
QUREX0FERFIuIKCgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9IiIgc3R5bGU9ImJvcmRlci1sZWZ0
OjFweCBzb2xpZCByZ2IoMCwwLDI1NSk7cGFkZGluZy1sZWZ0OjEzcHg7bWFyZ2luLWxlZnQ6MHB4
IiB0eXBlPSJjaXRlIj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIiAvPjxiciBjbGFzcz0iIiAv
PlN1cmUsIG9uZSBjb3VsZCBhcmd1ZSB0aGF0IGZhdm9yaW5nIFNBQ0sgb3ZlciBEU1MgaXMgbW9y
ZSBpbXBvcnRhbnQuIEJ1dCBJPGJyIGNsYXNzPSIiIC8+dGhpbmsgd2Ugd291bGQgbmVlZCBkYXRh
IHRvIGp1c3RpZnkgdGhhdC4gT25seSB2ZXJ5IHNwZWNpZmljIHRyYWZmaWM8YnIgY2xhc3M9IiIg
Lz5wYXR0ZXJucyB3aWxsIGZhbGwgaW4gdGhpcyB1c2UtY2FzZS48YnIgY2xhc3M9IiIgLz48L2Rp
dj48L2Jsb2NrcXVvdGU+PGRpdiBjbGFzcz0iIj5UaGUgYm90dG9tbGluZSBpcyB0aGF0IGluIHRo
ZSBldmVudCBvZiBhIG1hcCBiZWluZyBzbGlnaHRseSBkZWxheWVkLCBpLmUuLCBkZWxpdmVyZWQg
bGF0ZSB3aXRoIHJlc3BlY3QgdG8gdGhlIGNvcnJlc3BvbmRpbmcgZGF0YSwgc2hvdWxkIKBpdCBy
ZXN1bHQgaW4gcmVzZXR0aW5nIHRoZSBzdWJmbG93P6A8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBj
bGFzcz0iIiAvPjwvZGl2PjxkaXYgY2xhc3M9IiI+QXMgZmFyIGFzIHRoZSBzcGVjaWZpY2F0aW9u
IGlzIGNvbmNlcm5lZCwgaXQgY291bGQgYmUgbGliZXJhbCBvbiBhY2NlcHRpbmcgc3VjaCBtYXBz
LCByYXRoZXIgdGhhbiBiZWluZyByZXN0cmljdGl2ZS4gRXZlbiBpZiBhIGN1cnJlbnQgaW1wbGVt
ZW50YXRpb24gY2Fubm90IHN1cHBvcnQgdGhpcywgZnV0dXJlIGltcGxlbWVudGF0aW9ucyBtYXkg
bGlrZSB0bywgcHJvdmlkZWQgdGhlIHNwZWNpZmljYXRpb24gcGVybWl0cyB0aGlzIGFuZCB0aGUg
aW1wbGVtZW50YXRpb24gaXMgd2lsbGluZyB0byBjb3AgdXAgd2l0aCB0aGUgYXNzb2NpYXRlZCBj
b21wbGV4aXR5LqA8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIiAvPjwvZGl2PjxkaXYg
Y2xhc3M9IiI+QmVzdCByZWdhcmRzLDwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiIC8+
PC9kaXY+PGRpdiBjbGFzcz0iIj5BbmlsPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9IiIgc3R5bGU9
ImJvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMCwwLDI1NSk7cGFkZGluZy1sZWZ0OjEzcHg7bWFy
Z2luLWxlZnQ6MHB4IiB0eXBlPSJjaXRlIj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIiAvPjxi
ciBjbGFzcz0iIiAvPkNocmlzdG9waDxiciBjbGFzcz0iIiAvPjxiciBjbGFzcz0iIiAvPiZndDsg
PGJyIGNsYXNzPSIiIC8+Jmd0O6AgPGJyIGNsYXNzPSIiIC8+Jmd0OyA8YnIgY2xhc3M9IiIgLz4m
Z3Q7IFdpdGggcmVnYXJkcyw8YnIgY2xhc3M9IiIgLz4mZ3Q7IDxiciBjbGFzcz0iIiAvPiZndDug
IDxiciBjbGFzcz0iIiAvPiZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyBBbmlsPGJyIGNsYXNzPSIi
IC8+Jmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7oCA8YnIgY2xhc3M9IiIgLz4mZ3Q7IDxiciBjbGFz
cz0iIiAvPiZndDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+
Jmd0OyAmZ3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZn
dDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyA8YnIg
Y2xhc3M9IiIgLz4mZ3Q7ICZndDsgQ2hyaXN0b3BoPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7IDxi
ciBjbGFzcz0iIiAvPiZndDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyA8YnIg
Y2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyA8
YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyBGdXJ0aGVyLCBzZWdtZW50LTMgY2Fubm90IGNv
bWJpbmUvY292ZXIgdGhlIGRhdGEgaW4gc2VnbWVudC0xIGFuZCBzZWdtZW50LTMgaW4gYSAmcXVv
dDtzaW5nbGUgbWFwJnF1b3Q7LCBhcyB0aGUgZGF0YSBzZXF1ZW5jZSBzcGFjZSBpcyBub3QgY29u
dGludW91cywgaS5lLiwgc29tZSBpbiBiZXR3ZWVuIGRhdGEgKHNlZ21lbnQtMikgaXMgbWFwcGVk
IGFuZCB0cmFuc21pdHRlZCB0aHJvdWdoIHN1YmZsb3ctMi4gSGVyZSwgdGhlIG1hcCBpbiBzZWdt
ZW50LTMgZG9lcyBub3QgZXZlbiBwYXJ0aWFsbHkgY292ZXIgdGhlIGRhdGEgaXQgY2Fycmllcy4g
PGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZn
dDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDugIDxiciBjbGFzcz0iIiAvPiZndDsgJmd0
OyAmZ3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7IEJvdGggUkZDIDY4MjQgYW5kIHRo
ZSA2ODI0LWJpcyBkbyBub3QgcmVzdHJpY3QgdGhlIGFib3ZlIHNjZW5hcmlvLCBhbmQgSSBndWVz
cyB0aGUgY2hhbmdlIHByb3Bvc2VkIG5vdyBkb2VzIG5vdCBwZXJtaXQgdGhpcyB0byBoYXBwZW4u
IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAm
Z3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7oCA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZn
dDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyBCZXN0IHJlZ2FyZHMsIDxiciBj
bGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7IDxi
ciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7oCA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0
OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyBBbmlsIDxiciBjbGFzcz0iIiAvPiZndDsg
Jmd0OyAmZ3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIiAvPiZn
dDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNz
PSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBj
bGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IFRoYXQncyB0aGUgcmVh
c29uIHdoeSB3ZSAodGhlIE1QVENQLXVwc3RyZWFtaW5nIGNvbW11bml0eSkgdm91Y2ggdG8gaGF2
ZSB0aGlzIGNhc2UgcmVzdHJpY3RlZC48YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IENoZWVycyw8
YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IENocmlzdG9waDxiciBjbGFzcz0iIiAv
PiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8
YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0
OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9
IiIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIg
Y2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgQW5pbCA8YnIgY2xhc3M9
IiIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNs
YXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNz
PSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
QmVzdCByZWdhcmRzLDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEFsYW48YnIgY2xh
c3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0O6AgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBjbGFzcz0iIiAv
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7IDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciBj
bGFzcz0iIiAvPiZndDsgJmd0OyAmZ3Q7ICZndDugIDxiciBjbGFzcz0iIiAvPiZndDsgJmd0OyAm
Z3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0
OyAmZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7IDxiciBjbGFzcz0iIiAvPiZndDsg
Jmd0OyA8YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDsgPGJyIGNsYXNzPSIiIC8+Jmd0OyAmZ3Q7oCA8
YnIgY2xhc3M9IiIgLz4mZ3Q7ICZndDs8L2Rpdj48L2Jsb2NrcXVvdGU+CgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnIgY2xhc3M9IiIgLz4KbXVsdGlw
YXRodGNwIG1haWxpbmcgbGlzdDxiciBjbGFzcz0iIiAvPgo8YSBjbGFzcz0iIiBocmVmPSJtYWls
dG86bXVsdGlwYXRodGNwQGlldGYub3JnIj5tdWx0aXBhdGh0Y3BAaWV0Zi5vcmc8L2E+PGJyIGNs
YXNzPSIiIC8+CjxhIGNsYXNzPSIiIGhyZWY9Imh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4v
bGlzdGluZm8vbXVsdGlwYXRodGNwIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iMSI+aHR0cHM6
Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9tdWx0aXBhdGh0Y3A8L2E+PGJyIGNsYXNz
PSIiIC8+CjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj4KPC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2
PjxiciBjbGFzcz0iIiAvPjwvdGQ+PC90cj48L3Rib2R5PjwvdGFibGU+PC9wPjwvc3Bhbj48L2Rp
dj48L2Jsb2NrcXVvdGU+Cg==

--===============3793973138530705422==--
