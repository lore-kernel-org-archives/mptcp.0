Content-Type: multipart/mixed; boundary="===============7197097282059291049=="
MIME-Version: 1.0
From: Yoshifumi Nishida <nsd.ietf at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] RFC6824bis edits based on implementation
 feedback
Date: Tue, 07 Jan 2020 00:41:38 -0800
Message-ID: <CAAK044SJERk4n0+9CsD46UHjC874tO9z-EtFVFyLsNtXVPpuFw@mail.gmail.com>
In-Reply-To: 20200102182655.GB44237@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 3257

--===============7197097282059291049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
The texts look good to me. (as an individual contributor, just in case.)
Thanks for the efforts!
--
Yoshi

On Thu, Jan 2, 2020 at 10:27 AM Christoph Paasch <cpaasch=3D
40apple.com(a)dmarc.ietf.org> wrote:

> + MPTCP upstreaming community
>
>
> Hello,
>
> On 01/01/20 - 22:51:32, Alan Ford wrote:
> > Hi all,
> >
> > We=E2=80=99d love to get this to a state of completion as soon as possi=
ble, and
> to this end I am starting a new thread on this topic. In discussion with
> the chairs, it is possible to make the desired changes in AUTH48 as long =
as
> there is WG consensus. The discussion so far has been fairly limited in
> terms of participation.
> >
> > I would ask the chairs please if it was possible to specify a time bound
> for this discussion and a default conclusion.
> >
> > Regarding the changes, in summary, there are two areas where changes
> have been requested by the implementation community. As we are the IETF we
> obviously have strong focus on =E2=80=9Crunning code=E2=80=9D and so ease=
 of implementing
> standards-compliant code is strongly desirable. However, we do not wish to
> reduce functionality agreed by the IETF community if it is considered a
> required feature by the community.
> >
> >
> > Change 1
> >
> > Change the sentence reading:
> >
> >    If B has data to send first, then the reliable delivery of the ACK +
> MP_CAPABLE can be inferred by the receipt of this data with an MPTCP Data
> Sequence Signal (DSS) option (Section 3.3).
> >
> > To:
> >
> >    If B has data to send first, then the reliable delivery of the ACK +
> MP_CAPABLE is ensured by the receipt of this data with an MPTCP Data
> Sequence Signal (DSS) option (Section 3.3) containing a DATA_ACK for the
> MP_CAPABLE (which is the first octet of the data sequence space).
> >
> > What this means:
> >
> > The current text is concerned only with ensuring a path is MPTCP
> capable, and so only cares that DSS option occurs on a data packet.
> However, the MP_CAPABLE option is defined to occupy the first octet of da=
ta
> sequence space and thus, if analogous to TCP, must be acknowledged. From =
an
> implementation point of view it would make sense not to have this hanging
> around forever and instead define it is acknowledged at the connection
> level as soon as received. This change ensures the first data packet also
> DATA_ACKs this MP_CAPABLE octet.
> >
> >
> > Change 2
> >
> > Change the sentence reading:
> >
> >    A Data Sequence Mapping does not need to be included in every MPTCP
> packet, as long as the subflow sequence space in that packet is covered by
> a mapping known at the receiver.
> >
> > To:
> >
> >    The mapping provided by a Data Sequence Mapping MUST apply to some or
> all of the subflow sequence space in the TCP segment which carries the
> option. It does not need to be included in every MPTCP packet, as long as
> the subflow sequence space in that packet is covered by a mapping known at
> the receiver.
> >
> > What this means:
> >
> > The current text does not place any restrictions on where a mapping
> could appear. In theory a sender could define a thousand different mappin=
gs
> up front, send them all, and expect a receiver to store this and reassemb=
le
> data according to these mappings as it arrives. Indeed, this was never
> explicitly disallowed since it =E2=80=9Cmight have been useful=E2=80=9D. =
The implementation
> community, however, has expressed concerns over the difficulty of
> implementing this open-endedly. How many mappings is it reasonable to
> store? Is there a DoS risk here? Instead, it has been requested that thee
> specification restricts the placement of the DSS option to being within t=
he
> subflow sequence space to which it applies.
> >
> >
> > Please can members of the WG express whether they are happy with these
> changes, or concerned.
>
> As an implementor and having been the one kicking off this discussion, I
> fully
> support this change.
>
>
>
> Thanks,
> Christoph
>
> _______________________________________________
> multipathtcp mailing list
> multipathtcp(a)ietf.org
> https://www.ietf.org/mailman/listinfo/multipathtcp
>

--===============7197097282059291049==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSw8L2Rpdj48ZGl2PlRoZSB0ZXh0cyBsb29rIGdvb2QgdG8g
bWUuIChhcyBhbiBpbmRpdmlkdWFsIGNvbnRyaWJ1dG9yLCBqdXN0IGluIGNhc2UuKTwvZGl2Pjxk
aXY+VGhhbmtzIGZvciB0aGUgZWZmb3J0cyE8L2Rpdj48ZGl2Pi0tPC9kaXY+PGRpdj5Zb3NoaTwv
ZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9Imdt
YWlsX2F0dHIiPk9uIFRodSwgSmFuIDIsIDIwMjAgYXQgMTA6MjcgQU0gQ2hyaXN0b3BoIFBhYXNj
aCAmbHQ7Y3BhYXNjaD08YSBocmVmPSJtYWlsdG86NDBhcHBsZS5jb21AZG1hcmMuaWV0Zi5vcmci
PjQwYXBwbGUuY29tQGRtYXJjLmlldGYub3JnPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij4rIE1QVENQIHVwc3RyZWFtaW5nIGNvbW11bml0eTxicj4KPGJyPgo8YnI+CkhlbGxvLDxicj4K
PGJyPgpPbiAwMS8wMS8yMCAtIDIyOjUxOjMyLCBBbGFuIEZvcmQgd3JvdGU6PGJyPgomZ3Q7IEhp
IGFsbCw8YnI+CiZndDsgPGJyPgomZ3Q7IFdl4oCZZCBsb3ZlIHRvIGdldCB0aGlzIHRvIGEgc3Rh
dGUgb2YgY29tcGxldGlvbiBhcyBzb29uIGFzIHBvc3NpYmxlLCBhbmQgdG8gdGhpcyBlbmQgSSBh
bSBzdGFydGluZyBhIG5ldyB0aHJlYWQgb24gdGhpcyB0b3BpYy4gSW4gZGlzY3Vzc2lvbiB3aXRo
IHRoZSBjaGFpcnMsIGl0IGlzIHBvc3NpYmxlIHRvIG1ha2UgdGhlIGRlc2lyZWQgY2hhbmdlcyBp
biBBVVRINDggYXMgbG9uZyBhcyB0aGVyZSBpcyBXRyBjb25zZW5zdXMuIFRoZSBkaXNjdXNzaW9u
IHNvIGZhciBoYXMgYmVlbiBmYWlybHkgbGltaXRlZCBpbiB0ZXJtcyBvZiBwYXJ0aWNpcGF0aW9u
Ljxicj4KJmd0OyA8YnI+CiZndDsgSSB3b3VsZCBhc2sgdGhlIGNoYWlycyBwbGVhc2UgaWYgaXQg
d2FzIHBvc3NpYmxlIHRvIHNwZWNpZnkgYSB0aW1lIGJvdW5kIGZvciB0aGlzIGRpc2N1c3Npb24g
YW5kIGEgZGVmYXVsdCBjb25jbHVzaW9uLjxicj4KJmd0OyA8YnI+CiZndDsgUmVnYXJkaW5nIHRo
ZSBjaGFuZ2VzLCBpbiBzdW1tYXJ5LCB0aGVyZSBhcmUgdHdvIGFyZWFzIHdoZXJlIGNoYW5nZXMg
aGF2ZSBiZWVuIHJlcXVlc3RlZCBieSB0aGUgaW1wbGVtZW50YXRpb24gY29tbXVuaXR5LiBBcyB3
ZSBhcmUgdGhlIElFVEYgd2Ugb2J2aW91c2x5IGhhdmUgc3Ryb25nIGZvY3VzIG9uIOKAnHJ1bm5p
bmcgY29kZeKAnSBhbmQgc28gZWFzZSBvZiBpbXBsZW1lbnRpbmcgc3RhbmRhcmRzLWNvbXBsaWFu
dCBjb2RlIGlzIHN0cm9uZ2x5IGRlc2lyYWJsZS4gSG93ZXZlciwgd2UgZG8gbm90IHdpc2ggdG8g
cmVkdWNlIGZ1bmN0aW9uYWxpdHkgYWdyZWVkIGJ5IHRoZSBJRVRGIGNvbW11bml0eSBpZiBpdCBp
cyBjb25zaWRlcmVkIGEgcmVxdWlyZWQgZmVhdHVyZSBieSB0aGUgY29tbXVuaXR5Ljxicj4KJmd0
OyA8YnI+CiZndDsgPGJyPgomZ3Q7IENoYW5nZSAxPGJyPgomZ3Q7IDxicj4KJmd0OyBDaGFuZ2Ug
dGhlIHNlbnRlbmNlIHJlYWRpbmc6PGJyPgomZ3Q7IDxicj4KJmd0O8KgIMKgIElmIEIgaGFzIGRh
dGEgdG8gc2VuZCBmaXJzdCwgdGhlbiB0aGUgcmVsaWFibGUgZGVsaXZlcnkgb2YgdGhlIEFDSyAr
IE1QX0NBUEFCTEUgY2FuIGJlIGluZmVycmVkIGJ5IHRoZSByZWNlaXB0IG9mIHRoaXMgZGF0YSB3
aXRoIGFuIE1QVENQIERhdGEgU2VxdWVuY2UgU2lnbmFsIChEU1MpIG9wdGlvbiAoU2VjdGlvbiAz
LjMpLiA8YnI+CiZndDsgPGJyPgomZ3Q7IFRvOjxicj4KJmd0OyA8YnI+CiZndDvCoCDCoCBJZiBC
IGhhcyBkYXRhIHRvIHNlbmQgZmlyc3QsIHRoZW4gdGhlIHJlbGlhYmxlIGRlbGl2ZXJ5IG9mIHRo
ZSBBQ0sgKyBNUF9DQVBBQkxFIGlzIGVuc3VyZWQgYnkgdGhlIHJlY2VpcHQgb2YgdGhpcyBkYXRh
IHdpdGggYW4gTVBUQ1AgRGF0YSBTZXF1ZW5jZSBTaWduYWwgKERTUykgb3B0aW9uIChTZWN0aW9u
IDMuMykgY29udGFpbmluZyBhIERBVEFfQUNLIGZvciB0aGUgTVBfQ0FQQUJMRSAod2hpY2ggaXMg
dGhlIGZpcnN0IG9jdGV0IG9mIHRoZSBkYXRhIHNlcXVlbmNlIHNwYWNlKS48YnI+CiZndDsgPGJy
PgomZ3Q7IFdoYXQgdGhpcyBtZWFuczo8YnI+CiZndDsgPGJyPgomZ3Q7IFRoZSBjdXJyZW50IHRl
eHQgaXMgY29uY2VybmVkIG9ubHkgd2l0aCBlbnN1cmluZyBhIHBhdGggaXMgTVBUQ1AgY2FwYWJs
ZSwgYW5kIHNvIG9ubHkgY2FyZXMgdGhhdCBEU1Mgb3B0aW9uIG9jY3VycyBvbiBhIGRhdGEgcGFj
a2V0LiBIb3dldmVyLCB0aGUgTVBfQ0FQQUJMRSBvcHRpb24gaXMgZGVmaW5lZCB0byBvY2N1cHkg
dGhlIGZpcnN0IG9jdGV0IG9mIGRhdGEgc2VxdWVuY2Ugc3BhY2UgYW5kIHRodXMsIGlmIGFuYWxv
Z291cyB0byBUQ1AsIG11c3QgYmUgYWNrbm93bGVkZ2VkLiBGcm9tIGFuIGltcGxlbWVudGF0aW9u
IHBvaW50IG9mIHZpZXcgaXQgd291bGQgbWFrZSBzZW5zZSBub3QgdG8gaGF2ZSB0aGlzIGhhbmdp
bmcgYXJvdW5kIGZvcmV2ZXIgYW5kIGluc3RlYWQgZGVmaW5lIGl0IGlzIGFja25vd2xlZGdlZCBh
dCB0aGUgY29ubmVjdGlvbiBsZXZlbCBhcyBzb29uIGFzIHJlY2VpdmVkLiBUaGlzIGNoYW5nZSBl
bnN1cmVzIHRoZSBmaXJzdCBkYXRhIHBhY2tldCBhbHNvIERBVEFfQUNLcyB0aGlzIE1QX0NBUEFC
TEUgb2N0ZXQuPGJyPgomZ3Q7IDxicj4KJmd0OyA8YnI+CiZndDsgQ2hhbmdlIDI8YnI+CiZndDsg
PGJyPgomZ3Q7IENoYW5nZSB0aGUgc2VudGVuY2UgcmVhZGluZzo8YnI+CiZndDsgPGJyPgomZ3Q7
wqAgwqAgQSBEYXRhIFNlcXVlbmNlIE1hcHBpbmcgZG9lcyBub3QgbmVlZCB0byBiZSBpbmNsdWRl
ZCBpbiBldmVyeSBNUFRDUCBwYWNrZXQsIGFzIGxvbmcgYXMgdGhlIHN1YmZsb3cgc2VxdWVuY2Ug
c3BhY2UgaW4gdGhhdCBwYWNrZXQgaXMgY292ZXJlZCBieSBhIG1hcHBpbmcga25vd24gYXQgdGhl
IHJlY2VpdmVyLjxicj4KJmd0OyA8YnI+CiZndDsgVG86PGJyPgomZ3Q7IDxicj4KJmd0O8KgIMKg
IFRoZSBtYXBwaW5nIHByb3ZpZGVkIGJ5IGEgRGF0YSBTZXF1ZW5jZSBNYXBwaW5nIE1VU1QgYXBw
bHkgdG8gc29tZSBvciBhbGwgb2YgdGhlIHN1YmZsb3cgc2VxdWVuY2Ugc3BhY2UgaW4gdGhlIFRD
UCBzZWdtZW50IHdoaWNoIGNhcnJpZXMgdGhlIG9wdGlvbi4gSXQgZG9lcyBub3QgbmVlZCB0byBi
ZSBpbmNsdWRlZCBpbiBldmVyeSBNUFRDUCBwYWNrZXQsIGFzIGxvbmcgYXMgdGhlIHN1YmZsb3cg
c2VxdWVuY2Ugc3BhY2UgaW4gdGhhdCBwYWNrZXQgaXMgY292ZXJlZCBieSBhIG1hcHBpbmcga25v
d24gYXQgdGhlIHJlY2VpdmVyLjxicj4KJmd0OyA8YnI+CiZndDsgV2hhdCB0aGlzIG1lYW5zOjxi
cj4KJmd0OyA8YnI+CiZndDsgVGhlIGN1cnJlbnQgdGV4dCBkb2VzIG5vdCBwbGFjZSBhbnkgcmVz
dHJpY3Rpb25zIG9uIHdoZXJlIGEgbWFwcGluZyBjb3VsZCBhcHBlYXIuIEluIHRoZW9yeSBhIHNl
bmRlciBjb3VsZCBkZWZpbmUgYSB0aG91c2FuZCBkaWZmZXJlbnQgbWFwcGluZ3MgdXAgZnJvbnQs
IHNlbmQgdGhlbSBhbGwsIGFuZCBleHBlY3QgYSByZWNlaXZlciB0byBzdG9yZSB0aGlzIGFuZCBy
ZWFzc2VtYmxlIGRhdGEgYWNjb3JkaW5nIHRvIHRoZXNlIG1hcHBpbmdzIGFzIGl0IGFycml2ZXMu
IEluZGVlZCwgdGhpcyB3YXMgbmV2ZXIgZXhwbGljaXRseSBkaXNhbGxvd2VkIHNpbmNlIGl0IOKA
nG1pZ2h0IGhhdmUgYmVlbiB1c2VmdWzigJ0uIFRoZSBpbXBsZW1lbnRhdGlvbiBjb21tdW5pdHks
IGhvd2V2ZXIsIGhhcyBleHByZXNzZWQgY29uY2VybnMgb3ZlciB0aGUgZGlmZmljdWx0eSBvZiBp
bXBsZW1lbnRpbmcgdGhpcyBvcGVuLWVuZGVkbHkuIEhvdyBtYW55IG1hcHBpbmdzIGlzIGl0IHJl
YXNvbmFibGUgdG8gc3RvcmU/IElzIHRoZXJlIGEgRG9TIHJpc2sgaGVyZT8gSW5zdGVhZCwgaXQg
aGFzIGJlZW4gcmVxdWVzdGVkIHRoYXQgdGhlZSBzcGVjaWZpY2F0aW9uIHJlc3RyaWN0cyB0aGUg
cGxhY2VtZW50IG9mIHRoZSBEU1Mgb3B0aW9uIHRvIGJlaW5nIHdpdGhpbiB0aGUgc3ViZmxvdyBz
ZXF1ZW5jZSBzcGFjZSB0byB3aGljaCBpdCBhcHBsaWVzLjxicj4KJmd0OyA8YnI+CiZndDsgPGJy
PgomZ3Q7IFBsZWFzZSBjYW4gbWVtYmVycyBvZiB0aGUgV0cgZXhwcmVzcyB3aGV0aGVyIHRoZXkg
YXJlIGhhcHB5IHdpdGggdGhlc2UgY2hhbmdlcywgb3IgY29uY2VybmVkLjxicj4KPGJyPgpBcyBh
biBpbXBsZW1lbnRvciBhbmQgaGF2aW5nIGJlZW4gdGhlIG9uZSBraWNraW5nIG9mZiB0aGlzIGRp
c2N1c3Npb24sIEkgZnVsbHk8YnI+CnN1cHBvcnQgdGhpcyBjaGFuZ2UuPGJyPgo8YnI+Cjxicj4K
PGJyPgpUaGFua3MsPGJyPgpDaHJpc3RvcGg8YnI+Cjxicj4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX188YnI+Cm11bHRpcGF0aHRjcCBtYWlsaW5nIGxpc3Q8
YnI+CjxhIGhyZWY9Im1haWx0bzptdWx0aXBhdGh0Y3BAaWV0Zi5vcmciIHRhcmdldD0iX2JsYW5r
Ij5tdWx0aXBhdGh0Y3BAaWV0Zi5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwczovL3d3dy5pZXRm
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL211bHRpcGF0aHRjcCIgcmVsPSJub3JlZmVycmVyIiB0YXJn
ZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9tdWx0aXBh
dGh0Y3A8L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+Cg==

--===============7197097282059291049==--
