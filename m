Content-Type: multipart/mixed; boundary="===============4382413381361788998=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: MPTCP implementation feedback for RFC6824bis
Date: Fri, 13 Dec 2019 01:10:22 +0100
Message-ID: <CAKuKrBmpqv026QaKnYirTgpXmmjoyorbLAUOkF7KJbpofHEgQA@mail.gmail.com>
In-Reply-To: 34FA5631-3ED2-4C12-A928-5BA8728CAC7E@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 2908

--===============4382413381361788998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alan,


On Thu, Dec 12, 2019 at 10:19 PM Alan Ford <alan.ford(a)gmail.com> wrote:

> Hi Christoph (and Matthieu & Pablo),
>
> WRT checksums, we do say:
>
>    For example,
>    if the initiator sets A=3D0 in the SYN but the responder sets A=3D1 in
>    the SYN/ACK, checksums MUST be used in both directions, and the
>    initiator will set A=3D1 in the ACK.
>
>    If A=3D1 is received by a host that does not
>    want to use checksums, it MUST fall back to regular TCP by ignoring
>    the MP_CAPABLE option as if it was invalid.
>
> Which would seem to cover all these eventualities. The =E2=80=9CC=E2=80=
=9D bit is purely
> an indicator, and the crypto negotiation is clearly specified too.
>

Thank you for your answer, that's clearer for the A bit.
Our concern was mainly about the version. How should we react if, as a
server supporting only v1, we have this sequence:

SYN (MP_CAPABLE: v2)  =E2=86=92
=E2=86=90  SYN+ACK (MP_CAPABLE: v1)
ACK (MP_CAPABLE v2) =E2=86=92

In other words, the server told the client that the maximum version it
supports is v1. But in the ACK+MP_CAPABLE, the client sends v2 again.

According to the RFC, the negotiation is done in the SYN and SYN+ACK. How
do we react if the following ACK is sending a version (e.g. v2) which is
not the expected one (e.g. v1)?

For the moment in our implementation, we fallback to regular TCP.
It means that future versions of MPTCP have to set the proper version in
the 3rd ACK -- the negotiated one -- and not a copy of what has been sent
in the SYN.

Should we add a clarification for that?

Best regards,
Matthieu


>
> Best regards,
> Alan
>
> On 11 Dec 2019, at 19:28, Christoph Paasch <cpaasch(a)apple.com> wrote:
>
> Hello Alan,
>
> there is one more thing that came up from the implementation experience
> (thanks to Matthieu & Paolo in CC).
>
> It is unclear in the draft (or at least, I didn't find the text ;-) ),
> what to do when the flags & version in the third ACK + MP_CAPABLE are
> inconsistent with what was negotiated in the SYN-SYN/ACK exchange.
>
> It would be good to spell this out and say that if there are any
> inconsistencies, a host should simply fallback to regular TCP.
>
>
> Christoph
>
> On Dec 10, 2019, at 8:09 AM, Alan Ford <alan.ford(a)gmail.com> wrote:
>
> Hi Yoshifumi,
>
> On 10 Dec 2019, at 05:30, Yoshifumi Nishida <nsd.ietf(a)gmail.com> wrote:
>
> Hi Alan,
>
> The texts look fine to me, but I have a few questions on them.
>
> On Fri, Dec 6, 2019 at 7:58 AM Alan Ford <alan.ford(a)gmail.com> wrote:
>
>> Hi all,
>>
>> Following on from the discussion of implementation feedback with
>> Christoph, I propose the following edits to RFC6824bis - which is curren=
tly
>> in AUTH48 - as clarifications.
>>
>> ADs, please can you confirm you consider these edits sufficiently
>> editorial to fit into AUTH48.
>>
>> WG participants, please speak up if you have any concerns.
>>
>>
>> *Edit 1, clarifying reliability of MP_CAPABLE*
>>
>> Change the sentence reading:
>>
>>    The SYN with MP_CAPABLE occupies the first octet of data sequence
>> space, although this does not need to be acknowledged at the connection
>> level until the first data is sent (see Section 3.3).
>>
>> To:
>>
>>    The SYN with MP_CAPABLE occupies the first octet of data sequence
>> space, and this MUST be acknowledged at the connection level at or before
>> the time the first data is sent or received (see Section 3.3).
>>
>
> What implementations should do when they receive the first data before
> MP_CAPABLE is acked?
> They should terminate the connection or discard the data?
>
>
> By asking this question you have made me realise that this text is in fact
> incompatible with the case when A (the initiator) is also the first sender
> of data.
>
> Given the problem is only with B sending data first, let us forget this
> change, and revert to Christoph=E2=80=99s original problem text, and use =
only the
> below change:
>
> Change the sentence reading:
>>
>>    If B has data to send first, then the reliable delivery of the ACK +
>> MP_CAPABLE can be inferred by the receipt of this data with an MPTCP Data
>> Sequence Signal (DSS) option (Section 3.3).
>>
>> To:
>>
>>    If B has data to send first, then the reliable delivery of the ACK +
>> MP_CAPABLE is ensured by the receipt of this data with an MPTCP Data
>> Sequence Signal (DSS) option (Section 3.3) containing a DATA_ACK for the
>> MP_CAPABLE (which is the first octet of the data sequence space).
>>
>
> This will resolve the ambiguity in the case of B sending first.
>
> In my personal opinion either one of these edits would be sufficient for
>> making the point, however clearly this has caused some confusion amongst
>> the implementor community so making both these changes should make it
>> absolutely clear as to the expected behaviour here.
>>
>>
>> *Edit 2, mapping constraint*
>>
>> Change the sentence reading:
>>
>>    A Data Sequence Mapping does not need to be included in every
>> MPTCP packet, as long as the subflow sequence space in that packet
>> is covered by a mapping known at the receiver.
>>
>> To:
>>
>>    A Data Sequence Mapping MUST appear on a TCP segment which is covered
>> by the mapping. It does not need to be included in every MPTCP packet, as
>> long as the subflow sequence space in that packet is covered by a mapping
>> known at the receiver.
>>
>>
> What implementations should do when a Data Sequence Mapping doesn't cover
> the TCP segment that carries this option?
>
>
> There are a number of cases where the MUST does not have a consequence; it
> should be obvious from the text for similar failures that it can close it
> with a RST.
>
> BTW, This is not a strong opinion, but I may prefer a text like: "A Data
> Sequence Mapping MUST provide the mapping for the segment that carries th=
is
> option.=E2=80=9D
>
>
> OK how about: "A Data Sequence Mapping MUST provide the mapping which
> includes the segment that carries this option.=E2=80=9D
>
> Regards,
> Alan
>
>
>
>
>

-- =

[image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

Disclaimer: https://www.tessares.net/mail-disclaimer/

--===============4382413381361788998==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBBbGFuLDwvZGl2PjxkaXY+PGJy
PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIg
Y2xhc3M9ImdtYWlsX2F0dHIiPk9uIFRodSwgRGVjIDEyLCAyMDE5IGF0IDEwOjE5IFBNIEFsYW4g
Rm9yZCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsYW4uZm9yZEBnbWFpbC5jb20iPmFsYW4uZm9yZEBn
bWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBz
b2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgc3R5bGU9Im92ZXJm
bG93LXdyYXA6IGJyZWFrLXdvcmQ7Ij5IaSBDaHJpc3RvcGggKGFuZCBNYXR0aGlldSAmYW1wOyBQ
YWJsbyksPGRpdj48YnI+PC9kaXY+PGRpdj5XUlQgY2hlY2tzdW1zLCB3ZSBkbyBzYXk6PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PsKgIMKgRm9yIGV4YW1wbGUsPC9kaXY+PGRpdj7CoCDC
oGlmIHRoZSBpbml0aWF0b3Igc2V0cyBBPTAgaW4gdGhlIFNZTiBidXQgdGhlIHJlc3BvbmRlciBz
ZXRzIEE9MSBpbjwvZGl2PjxkaXY+wqAgwqB0aGUgU1lOL0FDSywgY2hlY2tzdW1zIE1VU1QgYmUg
dXNlZCBpbiBib3RoIGRpcmVjdGlvbnMsIGFuZCB0aGU8L2Rpdj48ZGl2PsKgIMKgaW5pdGlhdG9y
IHdpbGwgc2V0IEE9MSBpbiB0aGUgQUNLLiDCoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+wqAg
wqBJZiBBPTEgaXMgcmVjZWl2ZWQgYnkgYSBob3N0IHRoYXQgZG9lcyBub3Q8L2Rpdj48ZGl2PsKg
IMKgd2FudCB0byB1c2UgY2hlY2tzdW1zLCBpdCBNVVNUIGZhbGwgYmFjayB0byByZWd1bGFyIFRD
UCBieSBpZ25vcmluZzwvZGl2PjxkaXY+wqAgwqB0aGUgTVBfQ0FQQUJMRSBvcHRpb24gYXMgaWYg
aXQgd2FzIGludmFsaWQuPC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5XaGljaCB3b3Vs
ZCBzZWVtIHRvIGNvdmVyIGFsbCB0aGVzZSBldmVudHVhbGl0aWVzLiBUaGUg4oCcQ+KAnSBiaXQg
aXMgcHVyZWx5IGFuIGluZGljYXRvciwgYW5kIHRoZSBjcnlwdG8gbmVnb3RpYXRpb24gaXMgY2xl
YXJseSBzcGVjaWZpZWQgdG9vLjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rp
dj48ZGl2PjxkaXY+VGhhbmsgeW91IGZvciB5b3VyIGFuc3dlciwgdGhhdCYjMzk7cyBjbGVhcmVy
IGZvciB0aGUgQSBiaXQuPC9kaXY+PGRpdj5PdXIgY29uY2VybiB3YXMgbWFpbmx5IGFib3V0IHRo
ZSB2ZXJzaW9uLiBIb3cgc2hvdWxkIHdlIHJlYWN0IGlmLCBhcyBhIHNlcnZlciBzdXBwb3J0aW5n
IG9ubHkgdjEsIHdlIGhhdmUgdGhpcyBzZXF1ZW5jZTo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2PlNZTiAoTVBfQ0FQQUJMRTogdjIpwqAg4oaS
PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luLWxlZnQ6NDBweCI+4oaQwqAgU1lOK0FDSyAoTVBfQ0FQ
QUJMRTogdjEpPC9kaXY+QUNLIChNUF9DQVBBQkxFIHYyKSDihpI8YnI+PC9kaXY+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPjxkaXY+PGJyPjwvZGl2PjxkaXY+SW4gb3RoZXIgd29yZHMsIHRoZSBz
ZXJ2ZXIgdG9sZCB0aGUgY2xpZW50IHRoYXQgdGhlIG1heGltdW0gdmVyc2lvbiBpdCBzdXBwb3J0
cyBpcyB2MS4gQnV0IGluIHRoZSBBQ0srTVBfQ0FQQUJMRSwgdGhlIGNsaWVudCBzZW5kcyB2MiBh
Z2Fpbi48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFjY29yZGluZyB0byB0aGUgUkZDLCB0aGUg
bmVnb3RpYXRpb24gaXMgZG9uZSBpbiB0aGUgU1lOIGFuZCBTWU4rQUNLLiBIb3cgZG8gd2UgcmVh
Y3QgaWYgdGhlIGZvbGxvd2luZyBBQ0sgaXMgc2VuZGluZyBhIHZlcnNpb24gKGUuZy4gdjIpIHdo
aWNoIGlzIG5vdCB0aGUgZXhwZWN0ZWQgb25lIChlLmcuIHYxKT88L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PkZvciB0aGUgbW9tZW50IGluIG91ciBpbXBsZW1lbnRhdGlvbiwgd2UgZmFsbGJhY2sg
dG8gcmVndWxhciBUQ1AuPC9kaXY+PGRpdj5JdCBtZWFucyB0aGF0IGZ1dHVyZSB2ZXJzaW9ucyBv
ZiBNUFRDUCBoYXZlIHRvIHNldCB0aGUgcHJvcGVyIHZlcnNpb24gaW4gdGhlIDNyZCBBQ0sgLS0g
dGhlIG5lZ290aWF0ZWQgb25lIC0tIGFuZCBub3QgYSBjb3B5IG9mIHdoYXQgaGFzIGJlZW4gc2Vu
dCBpbiB0aGUgU1lOLjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlNob3VsZCB3ZSBhZGQg
YSBjbGFyaWZpY2F0aW9uIGZvciB0aGF0PzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QmVzdCBy
ZWdhcmRzLDwvZGl2PjxkaXY+TWF0dGhpZXU8YnI+PC9kaXY+PC9kaXY+PC9kaXY+wqA8L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHgg
MC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0
OjFleCI+PGRpdiBzdHlsZT0ib3ZlcmZsb3ctd3JhcDogYnJlYWstd29yZDsiPjxkaXY+PGJyPjwv
ZGl2PjxkaXY+QmVzdCByZWdhcmRzLDwvZGl2PjxkaXY+QWxhbjxicj48ZGl2Pjxicj48YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIj48ZGl2Pk9uIDExIERlYyAyMDE5LCBhdCAxOToyOCwgQ2hyaXN0b3Bo
IFBhYXNjaCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmNwYWFzY2hAYXBwbGUuY29tIiB0YXJnZXQ9Il9i
bGFuayI+Y3BhYXNjaEBhcHBsZS5jb208L2E+Jmd0OyB3cm90ZTo8L2Rpdj48YnI+PGRpdj48ZGl2
IHN0eWxlPSJvdmVyZmxvdy13cmFwOiBicmVhay13b3JkOyI+SGVsbG8gQWxhbiw8ZGl2Pjxicj48
L2Rpdj48ZGl2PnRoZXJlIGlzIG9uZSBtb3JlIHRoaW5nIHRoYXQgY2FtZSB1cCBmcm9tIHRoZSBp
bXBsZW1lbnRhdGlvbiBleHBlcmllbmNlICh0aGFua3MgdG8gTWF0dGhpZXUgJmFtcDsgUGFvbG8g
aW4gQ0MpLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXQgaXMgdW5jbGVhciBpbiB0aGUgZHJh
ZnQgKG9yIGF0IGxlYXN0LCBJIGRpZG4mIzM5O3QgZmluZCB0aGUgdGV4dCA7LSkgKSwgd2hhdCB0
byBkbyB3aGVuIHRoZSBmbGFncyAmYW1wOyB2ZXJzaW9uIGluIHRoZSB0aGlyZCBBQ0sgKyBNUF9D
QVBBQkxFIGFyZSBpbmNvbnNpc3RlbnQgd2l0aCB3aGF0IHdhcyBuZWdvdGlhdGVkIGluIHRoZSBT
WU4tU1lOL0FDSyBleGNoYW5nZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkl0IHdvdWxkIGJl
IGdvb2QgdG8gc3BlbGwgdGhpcyBvdXQgYW5kIHNheSB0aGF0IGlmIHRoZXJlIGFyZSBhbnkgaW5j
b25zaXN0ZW5jaWVzLCBhIGhvc3Qgc2hvdWxkIHNpbXBseSBmYWxsYmFjayB0byByZWd1bGFyIFRD
UC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkNocmlzdG9waDwvZGl2
PjxkaXY+PGRpdj48YnI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+PGRpdj5PbiBEZWMgMTAsIDIw
MTksIGF0IDg6MDkgQU0sIEFsYW4gRm9yZCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsYW4uZm9yZEBn
bWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5hbGFuLmZvcmRAZ21haWwuY29tPC9hPiZndDsgd3Jv
dGU6PC9kaXY+PGJyPjxkaXY+PGRpdiBzdHlsZT0ib3ZlcmZsb3ctd3JhcDogYnJlYWstd29yZDsi
PkhpIFlvc2hpZnVtaSw8YnI+PGRpdj48YnI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+PGRpdj5P
biAxMCBEZWMgMjAxOSwgYXQgMDU6MzAsIFlvc2hpZnVtaSBOaXNoaWRhICZsdDs8YSBocmVmPSJt
YWlsdG86bnNkLmlldGZAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bnNkLmlldGZAZ21haWwu
Y29tPC9hPiZndDsgd3JvdGU6PC9kaXY+PGJyPjxkaXY+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9
Imx0ciI+PGRpdj5IaSBBbGFuLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhlIHRleHRzIGxv
b2sgZmluZSB0byBtZSwgYnV0IEkgaGF2ZSBhIGZldyBxdWVzdGlvbnMgb24gdGhlbS48L2Rpdj48
YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9h
dHRyIj5PbiBGcmksIERlYyA2LCAyMDE5IGF0IDc6NTggQU0gQWxhbiBGb3JkICZsdDs8YSBocmVm
PSJtYWlsdG86YWxhbi5mb3JkQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmFsYW4uZm9yZEBn
bWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBz
b2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgc3R5bGU9Im92ZXJm
bG93LXdyYXA6IGJyZWFrLXdvcmQ7Ij5IaSBhbGwsPGRpdj48YnI+PC9kaXY+PGRpdj5Gb2xsb3dp
bmcgb24gZnJvbSB0aGUgZGlzY3Vzc2lvbiBvZiBpbXBsZW1lbnRhdGlvbiBmZWVkYmFjayB3aXRo
IENocmlzdG9waCwgSSBwcm9wb3NlIHRoZSBmb2xsb3dpbmcgZWRpdHMgdG8gUkZDNjgyNGJpcyAt
IHdoaWNoIGlzIGN1cnJlbnRseSBpbiBBVVRINDggLSBhcyBjbGFyaWZpY2F0aW9ucy48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PkFEcywgcGxlYXNlIGNhbiB5b3UgY29uZmlybSB5b3UgY29uc2lk
ZXIgdGhlc2UgZWRpdHMgc3VmZmljaWVudGx5IGVkaXRvcmlhbCB0byBmaXQgaW50byBBVVRINDgu
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5XRyBwYXJ0aWNpcGFudHMsIHBsZWFzZSBzcGVhayB1
cCBpZiB5b3UgaGF2ZSBhbnkgY29uY2VybnMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj48Yj5FZGl0IDEsIGNsYXJpZnlpbmcgcmVsaWFiaWxpdHkgb2YgTVBfQ0FQQUJM
RTwvYj48L2Rpdj48ZGl2PjxiPjxicj48L2I+PC9kaXY+PGRpdj5DaGFuZ2UgdGhlIHNlbnRlbmNl
IHJlYWRpbmc6PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoCDCoFRoZSBTWU4gd2l0aCBNUF9D
QVBBQkxFIG9jY3VwaWVzIHRoZSBmaXJzdCBvY3RldCBvZiBkYXRhIHNlcXVlbmNlIHNwYWNlLCBh
bHRob3VnaCB0aGlzIGRvZXMgbm90IG5lZWQgdG8gYmUgYWNrbm93bGVkZ2VkIGF0IHRoZSBjb25u
ZWN0aW9uIGxldmVsIHVudGlsIHRoZSBmaXJzdCBkYXRhIGlzIHNlbnQgKHNlZSBTZWN0aW9uIDMu
MykuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Ubzo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PsKgIMKgVGhlIFNZTiB3aXRoIE1QX0NBUEFCTEUgb2NjdXBpZXMgdGhlIGZpcnN0IG9jdGV0IG9m
IGRhdGEgc2VxdWVuY2Ugc3BhY2UsIGFuZCB0aGlzIE1VU1QgYmUgYWNrbm93bGVkZ2VkIGF0IHRo
ZSBjb25uZWN0aW9uIGxldmVsIGF0IG9yIGJlZm9yZSB0aGUgdGltZSB0aGUgZmlyc3QgZGF0YSBp
cyBzZW50IG9yIHJlY2VpdmVkIChzZWUgU2VjdGlvbiAzLjMpLjwvZGl2PjwvZGl2PjwvYmxvY2tx
dW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PldoYXQgaW1wbGVtZW50YXRpb25zIHNob3VsZCBkbyB3
aGVuIHRoZXkgcmVjZWl2ZSB0aGUgZmlyc3QgZGF0YSBiZWZvcmUgTVBfQ0FQQUJMRSBpcyBhY2tl
ZD88L2Rpdj48ZGl2PlRoZXkgc2hvdWxkIHRlcm1pbmF0ZSB0aGUgY29ubmVjdGlvbiBvciBkaXNj
YXJkIHRoZSBkYXRhPzwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48
ZGl2Pjxicj48L2Rpdj5CeSBhc2tpbmcgdGhpcyBxdWVzdGlvbiB5b3UgaGF2ZSBtYWRlIG1lIHJl
YWxpc2UgdGhhdCB0aGlzIHRleHQgaXMgaW4gZmFjdCBpbmNvbXBhdGlibGUgd2l0aCB0aGUgY2Fz
ZSB3aGVuIEEgKHRoZSBpbml0aWF0b3IpIGlzIGFsc28gdGhlIGZpcnN0IHNlbmRlciBvZiBkYXRh
LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+R2l2ZW4gdGhlIHByb2JsZW0gaXMgb25seSB3aXRo
IEIgc2VuZGluZyBkYXRhIGZpcnN0LCBsZXQgdXMgZm9yZ2V0IHRoaXMgY2hhbmdlLCBhbmQgcmV2
ZXJ0IHRvIENocmlzdG9waOKAmXMgb3JpZ2luYWwgcHJvYmxlbSB0ZXh0LCBhbmQgdXNlIG9ubHkg
dGhlIGJlbG93IGNoYW5nZTo8YnI+PGJyPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPjxkaXY+PGRp
diBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij48ZGl2IHN0eWxlPSJvdmVyZmxvdy13cmFwOiBicmVhay13b3JkOyI+PGRpdj5DaGFuZ2UgdGhl
IHNlbnRlbmNlIHJlYWRpbmc6PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoCDCoElmIEIgaGFz
IGRhdGEgdG8gc2VuZCBmaXJzdCwgdGhlbiB0aGUgcmVsaWFibGUgZGVsaXZlcnkgb2YgdGhlIEFD
SyArIE1QX0NBUEFCTEUgY2FuIGJlIGluZmVycmVkIGJ5IHRoZSByZWNlaXB0IG9mIHRoaXMgZGF0
YSB3aXRoIGFuIE1QVENQIERhdGEgU2VxdWVuY2UgU2lnbmFsIChEU1MpIG9wdGlvbiAoU2VjdGlv
biAzLjMpLsKgPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Ubzo8L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PsKgIMKgSWYgQiBoYXMgZGF0YSB0byBzZW5kIGZpcnN0LCB0aGVuIHRoZSByZWxpYWJs
ZSBkZWxpdmVyeSBvZiB0aGUgQUNLICsgTVBfQ0FQQUJMRSBpcyBlbnN1cmVkIGJ5IHRoZSByZWNl
aXB0IG9mIHRoaXMgZGF0YSB3aXRoIGFuIE1QVENQIERhdGEgU2VxdWVuY2UgU2lnbmFsIChEU1Mp
IG9wdGlvbiAoU2VjdGlvbiAzLjMpIGNvbnRhaW5pbmcgYSBEQVRBX0FDSyBmb3IgdGhlIE1QX0NB
UEFCTEXCoCh3aGljaCBpcyB0aGUgZmlyc3Qgb2N0ZXQgb2YgdGhlIGRhdGEgc2VxdWVuY2Ugc3Bh
Y2UpLjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Js
b2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+VGhpcyB3aWxsIHJlc29sdmUgdGhlIGFtYmlndWl0eSBp
biB0aGUgY2FzZSBvZiBCIHNlbmRpbmcgZmlyc3QuPGJyPjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1
b3RlIHR5cGU9ImNpdGUiPjxkaXY+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwy
MDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IHN0eWxlPSJvdmVyZmxvdy13cmFwOiBicmVh
ay13b3JkOyI+PGRpdj5JbiBteSBwZXJzb25hbCBvcGluaW9uIGVpdGhlciBvbmUgb2YgdGhlc2Ug
ZWRpdHMgd291bGQgYmUgc3VmZmljaWVudCBmb3IgbWFraW5nIHRoZSBwb2ludCwgaG93ZXZlciBj
bGVhcmx5IHRoaXMgaGFzIGNhdXNlZCBzb21lIGNvbmZ1c2lvbiBhbW9uZ3N0IHRoZSBpbXBsZW1l
bnRvciBjb21tdW5pdHkgc28gbWFraW5nIGJvdGggdGhlc2UgY2hhbmdlcyBzaG91bGQgbWFrZSBp
dCBhYnNvbHV0ZWx5IGNsZWFyIGFzIHRvIHRoZSBleHBlY3RlZCBiZWhhdmlvdXIgaGVyZS48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxiPkVkaXQgMiwgbWFwcGluZyBj
b25zdHJhaW50PC9iPjwvZGl2PjxkaXY+PGI+PGJyPjwvYj48L2Rpdj48ZGl2PkNoYW5nZSB0aGUg
c2VudGVuY2UgcmVhZGluZzo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PsKgIMKgQSBEYXRhIFNl
cXVlbmNlIE1hcHBpbmcgZG9lcyBub3QgbmVlZCB0byBiZSBpbmNsdWRlZCBpbiBldmVyeSBNUFRD
UMKgcGFja2V0LCBhcyBsb25nIGFzIHRoZSBzdWJmbG93IHNlcXVlbmNlIHNwYWNlIGluIHRoYXQg
cGFja2V0IGlzwqBjb3ZlcmVkIGJ5IGEgbWFwcGluZyBrbm93biBhdCB0aGUgcmVjZWl2ZXIuPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Ubzo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PsKgIMKg
QSBEYXRhIFNlcXVlbmNlIE1hcHBpbmcgTVVTVCBhcHBlYXIgb24gYSBUQ1Agc2VnbWVudCB3aGlj
aCBpcyBjb3ZlcmVkIGJ5IHRoZSBtYXBwaW5nLiBJdCBkb2VzIG5vdCBuZWVkIHRvIGJlIGluY2x1
ZGVkIGluIGV2ZXJ5IE1QVENQwqBwYWNrZXQsIGFzIGxvbmcgYXMgdGhlIHN1YmZsb3cgc2VxdWVu
Y2Ugc3BhY2UgaW4gdGhhdCBwYWNrZXQgaXPCoGNvdmVyZWQgYnkgYSBtYXBwaW5nIGtub3duIGF0
IHRoZSByZWNlaXZlci48L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRp
dj48YnI+PC9kaXY+PGRpdj5XaGF0IGltcGxlbWVudGF0aW9ucyBzaG91bGQgZG8gd2hlbiBhIERh
dGEgU2VxdWVuY2UgTWFwcGluZyBkb2VzbiYjMzk7dCBjb3ZlciB0aGUgVENQIHNlZ21lbnQgdGhh
dCBjYXJyaWVzIHRoaXMgb3B0aW9uPzwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvYmxv
Y2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZXJlIGFyZSBhIG51bWJlciBvZiBjYXNlcyB3
aGVyZSB0aGUgTVVTVCBkb2VzIG5vdCBoYXZlIGEgY29uc2VxdWVuY2U7IGl0IHNob3VsZCBiZSBv
YnZpb3VzIGZyb20gdGhlIHRleHQgZm9yIHNpbWlsYXIgZmFpbHVyZXMgdGhhdCBpdCBjYW4gY2xv
c2UgaXQgd2l0aCBhIFJTVC48L2Rpdj48YnI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+PGRpdj48
ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRp
dj5CVFcsIFRoaXMgaXMgbm90IGEgc3Ryb25nIG9waW5pb24sIGJ1dCBJIG1heSBwcmVmZXIgYSB0
ZXh0IGxpa2U6ICZxdW90O0EgRGF0YSBTZXF1ZW5jZSBNYXBwaW5nIE1VU1QgcHJvdmlkZSB0aGUg
bWFwcGluZyBmb3IgdGhlIHNlZ21lbnQgdGhhdCBjYXJyaWVzIHRoaXMgb3B0aW9uLuKAncKgPGJy
PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48YnI+PC9kaXY+PGRp
dj5PSyBob3cgYWJvdXQ6ICZxdW90O0EgRGF0YSBTZXF1ZW5jZSBNYXBwaW5nIE1VU1QgcHJvdmlk
ZSB0aGUgbWFwcGluZyB3aGljaCBpbmNsdWRlcyB0aGUgc2VnbWVudCB0aGF0IGNhcnJpZXMgdGhp
cyBvcHRpb24u4oCdwqA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRp
dj5BbGFuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGJyPjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48
L2Rpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj48
L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyIGNsZWFyPSJhbGwiPjxicj4tLSA8YnI+PGRpdiBk
aXI9Imx0ciIgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2
IGRpcj0ibHRyIj48ZGl2PjxkaXYgZGlyPSJsdHIiPjxkaXY+PGRpdiBkaXI9Imx0ciI+PGRpdj48
ZGl2IGRpcj0ibHRyIj48ZGl2PjxkaXYgZGlyPSJsdHIiPjx0YWJsZSBzdHlsZT0iZm9udC1mYW1p
bHk6JnF1b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7O2xldHRlci1zcGFjaW5nOm5vcm1hbDt0ZXh0
LWluZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3b3JkLXNwYWNpbmc6MHB4IiB3aWR0aD0i
NjAwIiBoZWlnaHQ9IjExMCIgYm9yZGVyPSIwIj48dGJvZHk+PHRyPjx0ZCByb3dzcGFuPSIzIiBz
dHlsZT0icGFkZGluZy1sZWZ0OjVweDtwYWRkaW5nLXJpZ2h0OjVweCIgd2lkdGg9IjEwIiB2YWxp
Z249InRvcCIgYWxpZ249ImxlZnQiPjxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiB0
YXJnZXQ9Il9ibGFuayI+PGltZyBzcmM9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0L3NpZ2xvZ28u
cG5nIiBhbHQ9IlRlc3NhcmVzIFNBIiB3aWR0aD0iODAiIGhlaWdodD0iODAiIGJvcmRlcj0iMCI+
PC9hPjwvdGQ+PHRkIHN0eWxlPSJwYWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJp
YWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTBweCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxz
cGFuIHN0eWxlPSJmb250LXdlaWdodDpib2xkO2NvbG9yOnJnYigzNyw4MywxNTUpO2Rpc3BsYXk6
aW5saW5lIj5NYXR0aGlldSBCYWVydHMgfCBSJmFtcDtEIEVuZ2luZWVyPC9zcGFuPjwvdGQ+PC90
cj48dHI+PHRkIHN0eWxlPSJwYWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWws
c2Fucy1zZXJpZjtmb250LXNpemU6MTBweCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxhIGhy
ZWY9Im1haWx0bzptYXR0aGlldS5iYWVydHMlNDB0ZXNzYXJlcy5uZXQiIHN0eWxlPSJjb2xvcjpy
Z2IoMCwwLDApO3RleHQtZGVjb3JhdGlvbjpub25lO2Rpc3BsYXk6aW5saW5lIiB0YXJnZXQ9Il9i
bGFuayI+bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldDxicj48L2E+PC90ZD48L3RyPjx0cj48
dGQgc3R5bGU9InBhZGRpbmc6MHB4O2ZvbnQtZmFtaWx5OkhlbHZldGljYSxBcmlhbCxzYW5zLXNl
cmlmO2ZvbnQtc2l6ZToxMHB4IiBhbGlnbj0ibGVmdCI+PHNwYW4gc3R5bGU9ImZvbnQtd2VpZ2h0
OmJvbGQ7Y29sb3I6cmdiKDM3LDgzLDE1NSk7ZGlzcGxheTppbmxpbmUiPlRlc3NhcmVzIFNBIHwg
SHlicmlkIEFjY2VzcyBTb2x1dGlvbnM8YnI+PC9zcGFuPjxhIGhyZWY9Imh0dHA6Ly93d3cudGVz
c2FyZXMubmV0IiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9uZTtk
aXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPnd3dy50ZXNzYXJlcy5uZXQ8L2E+PHNwYW4+
wqA8L3NwYW4+PGJyPjEgQXZlbnVlIEplYW4gTW9ubmV0LCAxMzQ4IExvdXZhaW4tbGEtTmV1dmUs
IEJlbGdpdW08YnI+PGJyPkRpc2NsYWltZXI6IDxhIGhyZWY9Imh0dHBzOi8vd3d3LnRlc3NhcmVz
Lm5ldC9tYWlsLWRpc2NsYWltZXIvIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cudGVzc2Fy
ZXMubmV0L21haWwtZGlzY2xhaW1lci88L2E+PGJyPjwvdGQ+PC90cj48L3Rib2R5PjwvdGFibGU+
PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9k
aXY+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============4382413381361788998==--
