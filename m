Content-Type: multipart/mixed; boundary="===============0986083121941581307=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: question on MP_CAPABLE v1 handshake
Date: Thu, 07 Nov 2019 09:11:33 -0800
Message-ID: <AA4DA599-3C56-4A27-A550-1C8B917BC8D3@apple.com>
In-Reply-To: 22911f4932b5cfcfe75a4a3f93af2305c46434c9.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2441

--===============0986083121941581307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

> On Nov 5, 2019, at 4:18 AM, Paolo Abeni <pabeni(a)redhat.com> wrote:
> =

> hi,
> =

> while testing the v1 MP_CAPABLE handshake, I stumbled upon the
> following scenario:
> =

> syn + MP_CAPABLE ->
> =

> 	<- syn + ack + MP_CAPABLE(sndr key)
> =

> ack + MP_CAPABLE(sndr key, rcvr key)
> =

> 	<- ack + DSS(map,data_ack)
> =

> At this point, is the client still supposed to send MP_CAPABLE(sndr
> key, rcvr key, data_len)? or should it send a plain DSS? Since it
> received a DSS from the peer, the client knows that the MP_CAPABLE
> options has been successfully received, but reading =

> =

> https://datatracker.ietf.org/doc/draft-ietf-mptcp-rfc6824bis/?include_tex=
t=3D1
> =

> from section 3.1.:
> =

> """
>   If A does not
>   immediately have data to send, it MUST include the MP_CAPABLE on the
>   third ACK, but without the additional data parameters.  When A does
>   have data to send, it must repeat the sending of the MP_CAPABLE
>   option from the third ACK, with additional data parameters.
> """
> =

> it looks like the client should always use MP_CAPABLE+data for the
> first data packet, is that right?

no, not always. Once the client receives a valid DATA_ACK from the server i=
t knows that the server did receive the keys. This is somehow mentioned at:

If B has data to send first, then the reliable delivery of the
ACK+MP_CAPABLE can be inferred by the receipt of this data with a
MPTCP Data Sequence Signal (DSS) option (Section 3.3 <https://tools.ietf.or=
g/html/draft-ietf-mptcp-rfc6824bis-18#section-3.3>).

The draft  says that the delivery can be inferred by the receipt of this da=
ta with a DSS-option, but it should actually read "by the receipt of a DATA=
_ACK". I actually mentioned that to Alan (https://mailarchive.ietf.org/arch=
/msg/multipathtcp/Mo-bvEcMEodPph8rTpylFMQ85IE <https://mailarchive.ietf.org=
/arch/msg/multipathtcp/Mo-bvEcMEodPph8rTpylFMQ85IE>) and suggested text to =
him in private, but that text never made it into the draft.

Do you want to send an e-mail to the IETF mailing-list to correct this?

The text I suggest would be:

"If B has data to send first, then the reliable delivery of the ACK
can be inferred by the receipt of this data with an MPTCP
DATA_ACK inside the DSS option (Section 3.3)."

Christoph


> =

> Thanks,
> =

> Paolo
> =



--===============0986083121941581307==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBi
cmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdo
aXRlLXNwYWNlOyIgY2xhc3M9IiI+SGVsbG8sPGJyIGNsYXNzPSIiPjxkaXY+PGJyIGNsYXNzPSIi
PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+T24gTm92IDUs
IDIwMTksIGF0IDQ6MTggQU0sIFBhb2xvIEFiZW5pICZsdDs8YSBocmVmPSJtYWlsdG86cGFiZW5p
QHJlZGhhdC5jb20iIGNsYXNzPSIiPnBhYmVuaUByZWRoYXQuY29tPC9hPiZndDsgd3JvdGU6PC9k
aXY+PGJyIGNsYXNzPSJBcHBsZS1pbnRlcmNoYW5nZS1uZXdsaW5lIj48ZGl2IGNsYXNzPSIiPjxk
aXYgY2xhc3M9IiI+aGksPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj53aGlsZSB0ZXN0aW5nIHRo
ZSB2MSBNUF9DQVBBQkxFIGhhbmRzaGFrZSwgSSBzdHVtYmxlZCB1cG9uIHRoZTxiciBjbGFzcz0i
Ij5mb2xsb3dpbmcgc2NlbmFyaW86PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5zeW4gKyBNUF9D
QVBBQkxFIC0mZ3Q7PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Jmx0Oy0gc3luICsgYWNr
ICsgTVBfQ0FQQUJMRShzbmRyIGtleSk8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPmFjayArIE1Q
X0NBUEFCTEUoc25kciBrZXksIHJjdnIga2V5KTxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PiZsdDstIGFjayArIERTUyhtYXAsZGF0YV9hY2spPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5B
dCB0aGlzIHBvaW50LCBpcyB0aGUgY2xpZW50IHN0aWxsIHN1cHBvc2VkIHRvIHNlbmQgTVBfQ0FQ
QUJMRShzbmRyPGJyIGNsYXNzPSIiPmtleSwgcmN2ciBrZXksIGRhdGFfbGVuKT8gb3Igc2hvdWxk
IGl0IHNlbmQgYSBwbGFpbiBEU1M/IFNpbmNlIGl0PGJyIGNsYXNzPSIiPnJlY2VpdmVkIGEgRFNT
IGZyb20gdGhlIHBlZXIsIHRoZSBjbGllbnQga25vd3MgdGhhdCB0aGUgTVBfQ0FQQUJMRTxiciBj
bGFzcz0iIj5vcHRpb25zIGhhcyBiZWVuIHN1Y2Nlc3NmdWxseSByZWNlaXZlZCwgYnV0IHJlYWRp
bmcgPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48YSBocmVmPSJodHRwczovL2RhdGF0cmFja2Vy
LmlldGYub3JnL2RvYy9kcmFmdC1pZXRmLW1wdGNwLXJmYzY4MjRiaXMvP2luY2x1ZGVfdGV4dD0x
IiBjbGFzcz0iIj5odHRwczovL2RhdGF0cmFja2VyLmlldGYub3JnL2RvYy9kcmFmdC1pZXRmLW1w
dGNwLXJmYzY4MjRiaXMvP2luY2x1ZGVfdGV4dD0xPC9hPjxiciBjbGFzcz0iIj48YnIgY2xhc3M9
IiI+ZnJvbSBzZWN0aW9uIDMuMS46PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4iIiI8YnIgY2xh
c3M9IiI+ICZuYnNwOyZuYnNwO0lmIEEgZG9lcyBub3Q8YnIgY2xhc3M9IiI+ICZuYnNwOyZuYnNw
O2ltbWVkaWF0ZWx5IGhhdmUgZGF0YSB0byBzZW5kLCBpdCBNVVNUIGluY2x1ZGUgdGhlIE1QX0NB
UEFCTEUgb24gdGhlPGJyIGNsYXNzPSIiPiAmbmJzcDsmbmJzcDt0aGlyZCBBQ0ssIGJ1dCB3aXRo
b3V0IHRoZSBhZGRpdGlvbmFsIGRhdGEgcGFyYW1ldGVycy4gJm5ic3A7V2hlbiBBIGRvZXM8YnIg
Y2xhc3M9IiI+ICZuYnNwOyZuYnNwO2hhdmUgZGF0YSB0byBzZW5kLCBpdCBtdXN0IHJlcGVhdCB0
aGUgc2VuZGluZyBvZiB0aGUgTVBfQ0FQQUJMRTxiciBjbGFzcz0iIj4gJm5ic3A7Jm5ic3A7b3B0
aW9uIGZyb20gdGhlIHRoaXJkIEFDSywgd2l0aCBhZGRpdGlvbmFsIGRhdGEgcGFyYW1ldGVycy48
YnIgY2xhc3M9IiI+IiIiPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5pdCBsb29rcyBsaWtlIHRo
ZSBjbGllbnQgc2hvdWxkIGFsd2F5cyB1c2UgTVBfQ0FQQUJMRStkYXRhIGZvciB0aGU8YnIgY2xh
c3M9IiI+Zmlyc3QgZGF0YSBwYWNrZXQsIGlzIHRoYXQgcmlnaHQ/PGJyIGNsYXNzPSIiPjwvZGl2
PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2Pm5vLCBub3Qg
YWx3YXlzLiBPbmNlIHRoZSBjbGllbnQgcmVjZWl2ZXMgYSB2YWxpZCBEQVRBX0FDSyBmcm9tIHRo
ZSBzZXJ2ZXIgaXQga25vd3MgdGhhdCB0aGUgc2VydmVyIGRpZCByZWNlaXZlIHRoZSBrZXlzLiBU
aGlzIGlzIHNvbWVob3cgbWVudGlvbmVkIGF0OjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2
PjxkaXY+PHByZSBjbGFzcz0ibmV3cGFnZSIgc3R5bGU9ImZvbnQtc2l6ZTogMTMuMzMzMzMzMDE1
NDQxODk1cHg7IG1hcmdpbi10b3A6IDBweDsgbWFyZ2luLWJvdHRvbTogMHB4OyBicmVhay1iZWZv
cmU6IHBhZ2U7Ij5JZiBCIGhhcyBkYXRhIHRvIHNlbmQgZmlyc3QsIHRoZW4gdGhlIHJlbGlhYmxl
IGRlbGl2ZXJ5IG9mIHRoZTwvcHJlPjxwcmUgY2xhc3M9Im5ld3BhZ2UiIHN0eWxlPSJmb250LXNp
emU6IDEzLjMzMzMzMzAxNTQ0MTg5NXB4OyBtYXJnaW4tdG9wOiAwcHg7IG1hcmdpbi1ib3R0b206
IDBweDsgYnJlYWstYmVmb3JlOiBwYWdlOyI+QUNLK01QX0NBUEFCTEUgY2FuIGJlIGluZmVycmVk
IGJ5IHRoZSByZWNlaXB0IG9mIHRoaXMgZGF0YSB3aXRoIGEKTVBUQ1AgRGF0YSBTZXF1ZW5jZSBT
aWduYWwgKERTUykgb3B0aW9uICg8YSBocmVmPSJodHRwczovL3Rvb2xzLmlldGYub3JnL2h0bWwv
ZHJhZnQtaWV0Zi1tcHRjcC1yZmM2ODI0YmlzLTE4I3NlY3Rpb24tMy4zIiBjbGFzcz0iIj5TZWN0
aW9uIDMuMzwvYT4pLjwvcHJlPjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjwvZGl2
PjxkaXY+VGhlIGRyYWZ0ICZuYnNwO3NheXMgdGhhdCB0aGUgZGVsaXZlcnkgY2FuIGJlIGluZmVy
cmVkIGJ5IHRoZSByZWNlaXB0IG9mIHRoaXMgZGF0YSB3aXRoIGEgRFNTLW9wdGlvbiwgYnV0IGl0
IHNob3VsZCBhY3R1YWxseSByZWFkICJieSB0aGUgcmVjZWlwdCBvZiBhIERBVEFfQUNLIi4gSSBh
Y3R1YWxseSBtZW50aW9uZWQgdGhhdCB0byBBbGFuICg8YSBocmVmPSJodHRwczovL21haWxhcmNo
aXZlLmlldGYub3JnL2FyY2gvbXNnL211bHRpcGF0aHRjcC9Nby1idkVjTUVvZFBwaDhyVHB5bEZN
UTg1SUUiIGNsYXNzPSIiPmh0dHBzOi8vbWFpbGFyY2hpdmUuaWV0Zi5vcmcvYXJjaC9tc2cvbXVs
dGlwYXRodGNwL01vLWJ2RWNNRW9kUHBoOHJUcHlsRk1RODVJRTwvYT4pIGFuZCBzdWdnZXN0ZWQg
dGV4dCB0byBoaW0gaW4gcHJpdmF0ZSwgYnV0IHRoYXQgdGV4dCBuZXZlciBtYWRlIGl0IGludG8g
dGhlIGRyYWZ0LjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+RG8geW91IHdhbnQg
dG8gc2VuZCBhbiBlLW1haWwgdG8gdGhlIElFVEYgbWFpbGluZy1saXN0IHRvIGNvcnJlY3QgdGhp
cz88L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2PlRoZSB0ZXh0IEkgc3VnZ2VzdCB3
b3VsZCBiZTo8L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJm
b250LWZhbWlseTogTWVubG8tUmVndWxhcjsiIGNsYXNzPSIiPiJJZiBCIGhhcyBkYXRhIHRvIHNl
bmQgZmlyc3QsIHRoZW4gdGhlIHJlbGlhYmxlIGRlbGl2ZXJ5IG9mIHRoZSBBQ0s8L3NwYW4+PGJy
IHN0eWxlPSJmb250LWZhbWlseTogTWVubG8tUmVndWxhcjsiIGNsYXNzPSIiPjxzcGFuIHN0eWxl
PSJmb250LWZhbWlseTogTWVubG8tUmVndWxhcjsiIGNsYXNzPSIiPmNhbiBiZSBpbmZlcnJlZCBi
eSB0aGUgcmVjZWlwdCBvZiB0aGlzIGRhdGEgd2l0aCBhbiBNUFRDUDwvc3Bhbj48YnIgc3R5bGU9
ImZvbnQtZmFtaWx5OiBNZW5sby1SZWd1bGFyOyIgY2xhc3M9IiI+PHNwYW4gc3R5bGU9ImZvbnQt
ZmFtaWx5OiBNZW5sby1SZWd1bGFyOyIgY2xhc3M9IiI+REFUQV9BQ0sgaW5zaWRlIHRoZSBEU1Mg
b3B0aW9uIChTZWN0aW9uIDMuMykuIjwvc3Bhbj48YnIgc3R5bGU9ImZvbnQtZmFtaWx5OiBNZW5s
by1SZWd1bGFyOyIgY2xhc3M9IiI+PC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+Q2hyaXN0
b3BoPC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PGJsb2Nr
cXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxi
ciBjbGFzcz0iIj5UaGFua3MsPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5QYW9sbzxiciBjbGFz
cz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjxiciBjbGFz
cz0iIj48L2JvZHk+PC9odG1sPg==
--===============0986083121941581307==--
