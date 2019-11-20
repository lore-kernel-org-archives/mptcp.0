Content-Type: multipart/mixed; boundary="===============0544191778669424101=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Feedback to the IETF
Date: Wed, 20 Nov 2019 17:31:10 +0800
Message-ID: <9641CA6A-FB2D-4411-9B79-D0F41009E40B@apple.com>
In-Reply-To: d6709bbe368539bacf2edbc5d30a15f3866125ad.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2607

--===============0544191778669424101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On Nov 20, 2019, at 5:15 PM, Paolo Abeni <pabeni(a)redhat.com> wrote:
> =

> On Wed, 2019-11-20 at 15:52 +0800, Christoph Paasch wrote:
>> So, let me try to compile a list of things that came up. Please correct =
or add anything:
> =

> Thank you for doing this!
> =

>> Clarifying that the reception of a DATA_ACK means that the server
>> successfully received the MP_CAPABLE (Text "If B has data to send
>> first, then the reliable delivery of the ACK can be inferred by the
>> receipt of this data with an MPTCP DATA_ACK inside the DSS option
>> (Section 3.3).)
> =

> Ack! :) Plus perhaps stating explicitly that client CAN send DSS
> instead of MP_CAPABLE + data len after the above.
> =

>> Should we vouch to disallow early or late DSS mappings that are
>> covering a TCP-sequence space different than the packet they are
>> being sent on (cfr., our discussion on/around September 25th)
> =

> +1, this will simplify and clean-up the implementation, and I do not
> see benefit from supporting such mappings.
> =

>> ADD_ADDR-option size - last  week we discussed this briefly and I
>> replied by mail that the size-problem is actually for the non-Echo
>> option. In that one there is no way to get around it and all the bits
>> need to be presented. Do you agree on that?
> =

> Sorry for the lack of feedback. I originally misread the RFC the other
> way, but the text is actually very clear.
> =

> To be 110% honest, I don't see why HMAC is needed here, assuming
> ADD_ADDR comes after MP_JOIN/MP_CAPABLE, we already authenticated both
> peers, and if an attacker can inject malicious TCP packets inside the
> stream we are at loss no matter what.

The problem here is that an attacker that is off-path would be able to get =
himself on-path with an ADD_ADDR-attack (described at https://tools.ietf.or=
g/html/rfc7430#section-2 <https://tools.ietf.org/html/rfc7430#section-2>) a=
nd thus can observe all traffic. Sure, he still needs to guess sequence-num=
bers and port-numbers, but with a TCP-window of 2MB it is not all that hard.

That's why the IETF considered that attack serious enough to fix it.

I plan to send this list to the working-group by the end of the week. I kee=
p you in CC. @all - please add anything else you can think of.


Cheers,
Christoph

> =

> Thanks,
> =

> Paolo
> =

> =



--===============0544191778669424101==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBi
cmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdo
aXRlLXNwYWNlOyIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxkaXY+PGJyIGNsYXNzPSIiPjxibG9j
a3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+T24gTm92IDIwLCAyMDE5
LCBhdCA1OjE1IFBNLCBQYW9sbyBBYmVuaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOnBhYmVuaUByZWRo
YXQuY29tIiBjbGFzcz0iIj5wYWJlbmlAcmVkaGF0LmNvbTwvYT4mZ3Q7IHdyb3RlOjwvZGl2Pjxi
ciBjbGFzcz0iQXBwbGUtaW50ZXJjaGFuZ2UtbmV3bGluZSI+PGRpdiBjbGFzcz0iIj48ZGl2IGNs
YXNzPSIiPk9uIFdlZCwgMjAxOS0xMS0yMCBhdCAxNTo1MiArMDgwMCwgQ2hyaXN0b3BoIFBhYXNj
aCB3cm90ZTo8YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+U28s
IGxldCBtZSB0cnkgdG8gY29tcGlsZSBhIGxpc3Qgb2YgdGhpbmdzIHRoYXQgY2FtZSB1cC4gUGxl
YXNlIGNvcnJlY3Qgb3IgYWRkIGFueXRoaW5nOjxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+PGJy
IGNsYXNzPSIiPlRoYW5rIHlvdSBmb3IgZG9pbmcgdGhpcyE8YnIgY2xhc3M9IiI+PGJyIGNsYXNz
PSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPkNsYXJpZnlpbmcgdGhhdCB0aGUg
cmVjZXB0aW9uIG9mIGEgREFUQV9BQ0sgbWVhbnMgdGhhdCB0aGUgc2VydmVyPGJyIGNsYXNzPSIi
PnN1Y2Nlc3NmdWxseSByZWNlaXZlZCB0aGUgTVBfQ0FQQUJMRSAoVGV4dCAiSWYgQiBoYXMgZGF0
YSB0byBzZW5kPGJyIGNsYXNzPSIiPmZpcnN0LCB0aGVuIHRoZSByZWxpYWJsZSBkZWxpdmVyeSBv
ZiB0aGUgQUNLIGNhbiBiZSBpbmZlcnJlZCBieSB0aGU8YnIgY2xhc3M9IiI+cmVjZWlwdCBvZiB0
aGlzIGRhdGEgd2l0aCBhbiBNUFRDUCBEQVRBX0FDSyBpbnNpZGUgdGhlIERTUyBvcHRpb248YnIg
Y2xhc3M9IiI+KFNlY3Rpb24gMy4zKS4pPGJyIGNsYXNzPSIiPjwvYmxvY2txdW90ZT48YnIgY2xh
c3M9IiI+QWNrISA6KSBQbHVzIHBlcmhhcHMgc3RhdGluZyBleHBsaWNpdGx5IHRoYXQgY2xpZW50
IENBTiBzZW5kIERTUzxiciBjbGFzcz0iIj5pbnN0ZWFkIG9mIE1QX0NBUEFCTEUgKyBkYXRhIGxl
biBhZnRlciB0aGUgYWJvdmUuPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0
eXBlPSJjaXRlIiBjbGFzcz0iIj5TaG91bGQgd2Ugdm91Y2ggdG8gZGlzYWxsb3cgZWFybHkgb3Ig
bGF0ZSBEU1MgbWFwcGluZ3MgdGhhdCBhcmU8YnIgY2xhc3M9IiI+Y292ZXJpbmcgYSBUQ1Atc2Vx
dWVuY2Ugc3BhY2UgZGlmZmVyZW50IHRoYW4gdGhlIHBhY2tldCB0aGV5IGFyZTxiciBjbGFzcz0i
Ij5iZWluZyBzZW50IG9uIChjZnIuLCBvdXIgZGlzY3Vzc2lvbiBvbi9hcm91bmQgU2VwdGVtYmVy
IDI1dGgpPGJyIGNsYXNzPSIiPjwvYmxvY2txdW90ZT48YnIgY2xhc3M9IiI+KzEsIHRoaXMgd2ls
bCBzaW1wbGlmeSBhbmQgY2xlYW4tdXAgdGhlIGltcGxlbWVudGF0aW9uLCBhbmQgSSBkbyBub3Q8
YnIgY2xhc3M9IiI+c2VlIGJlbmVmaXQgZnJvbSBzdXBwb3J0aW5nIHN1Y2ggbWFwcGluZ3MuPGJy
IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj5B
RERfQUREUi1vcHRpb24gc2l6ZSAtIGxhc3QgJm5ic3A7d2VlayB3ZSBkaXNjdXNzZWQgdGhpcyBi
cmllZmx5IGFuZCBJPGJyIGNsYXNzPSIiPnJlcGxpZWQgYnkgbWFpbCB0aGF0IHRoZSBzaXplLXBy
b2JsZW0gaXMgYWN0dWFsbHkgZm9yIHRoZSBub24tRWNobzxiciBjbGFzcz0iIj5vcHRpb24uIElu
IHRoYXQgb25lIHRoZXJlIGlzIG5vIHdheSB0byBnZXQgYXJvdW5kIGl0IGFuZCBhbGwgdGhlIGJp
dHM8YnIgY2xhc3M9IiI+bmVlZCB0byBiZSBwcmVzZW50ZWQuIERvIHlvdSBhZ3JlZSBvbiB0aGF0
PzxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+PGJyIGNsYXNzPSIiPlNvcnJ5IGZvciB0aGUgbGFj
ayBvZiBmZWVkYmFjay4gSSBvcmlnaW5hbGx5IG1pc3JlYWQgdGhlIFJGQyB0aGUgb3RoZXI8YnIg
Y2xhc3M9IiI+d2F5LCBidXQgdGhlIHRleHQgaXMgYWN0dWFsbHkgdmVyeSBjbGVhci48YnIgY2xh
c3M9IiI+PGJyIGNsYXNzPSIiPlRvIGJlIDExMCUgaG9uZXN0LCBJIGRvbid0IHNlZSB3aHkgSE1B
QyBpcyBuZWVkZWQgaGVyZSwgYXNzdW1pbmc8YnIgY2xhc3M9IiI+QUREX0FERFIgY29tZXMgYWZ0
ZXIgTVBfSk9JTi9NUF9DQVBBQkxFLCB3ZSBhbHJlYWR5IGF1dGhlbnRpY2F0ZWQgYm90aDxiciBj
bGFzcz0iIj5wZWVycywgYW5kIGlmIGFuIGF0dGFja2VyIGNhbiBpbmplY3QgbWFsaWNpb3VzIFRD
UCBwYWNrZXRzIGluc2lkZSB0aGU8YnIgY2xhc3M9IiI+c3RyZWFtIHdlIGFyZSBhdCBsb3NzIG5v
IG1hdHRlciB3aGF0LjxiciBjbGFzcz0iIj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48
YnIgY2xhc3M9IiI+PC9kaXY+PGRpdj5UaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgYW4gYXR0YWNr
ZXIgdGhhdCBpcyBvZmYtcGF0aCB3b3VsZCBiZSBhYmxlIHRvIGdldCBoaW1zZWxmIG9uLXBhdGgg
d2l0aCBhbiBBRERfQUREUi1hdHRhY2sgKGRlc2NyaWJlZCBhdCZuYnNwOzxhIGhyZWY9Imh0dHBz
Oi8vdG9vbHMuaWV0Zi5vcmcvaHRtbC9yZmM3NDMwI3NlY3Rpb24tMiIgY2xhc3M9IiI+aHR0cHM6
Ly90b29scy5pZXRmLm9yZy9odG1sL3JmYzc0MzAjc2VjdGlvbi0yPC9hPikgYW5kIHRodXMgY2Fu
IG9ic2VydmUgYWxsIHRyYWZmaWMuIFN1cmUsIGhlIHN0aWxsIG5lZWRzIHRvIGd1ZXNzIHNlcXVl
bmNlLW51bWJlcnMgYW5kIHBvcnQtbnVtYmVycywgYnV0IHdpdGggYSBUQ1Atd2luZG93IG9mIDJN
QiBpdCBpcyBub3QgYWxsIHRoYXQgaGFyZC48L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48
ZGl2PlRoYXQncyB3aHkgdGhlIElFVEYgY29uc2lkZXJlZCB0aGF0IGF0dGFjayBzZXJpb3VzIGVu
b3VnaCB0byBmaXggaXQuPC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdj5JIHBsYW4g
dG8gc2VuZCB0aGlzIGxpc3QgdG8gdGhlIHdvcmtpbmctZ3JvdXAgYnkgdGhlIGVuZCBvZiB0aGUg
d2Vlay4gSSBrZWVwIHlvdSBpbiBDQy4gQGFsbCAtIHBsZWFzZSBhZGQgYW55dGhpbmcgZWxzZSB5
b3UgY2FuIHRoaW5rIG9mLjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+PGJyIGNs
YXNzPSIiPjwvZGl2PjxkaXY+Q2hlZXJzLDwvZGl2PjxkaXY+Q2hyaXN0b3BoPC9kaXY+PGJyIGNs
YXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGRp
diBjbGFzcz0iIj48YnIgY2xhc3M9IiI+VGhhbmtzLDxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+
UGFvbG88YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48L2Rpdj48
L2Jsb2NrcXVvdGU+PC9kaXY+PGJyIGNsYXNzPSIiPjwvYm9keT48L2h0bWw+
--===============0544191778669424101==--
