Content-Type: multipart/mixed; boundary="===============1227515066608619366=="
MIME-Version: 1.0
From: Lorenzo Colitti <lorenzo at google.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Using struct socket for subflows
Date: Tue, 27 Mar 2018 14:04:28 +0200
Message-ID: <CAKD1Yr2sBCdUO48cp=rZQ6s4v13ytpPd9oPT+U=iYrdXtba5HA@mail.gmail.com>
In-Reply-To: 20180327091847.GC39174@MacBook-Pro-6.lan
X-Status: 
X-Keywords:                  
X-UID: 430

--===============1227515066608619366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 11:18 AM, Christoph Paasch <cpaasch(a)apple.com>
wrote:

> It also would allow us to expose subflows as file-descriptors to the
> user-space. That way the user-space can do setsockopt, getsockopt,... on
> the
> subflows. An idea that came up in the past when we were thinking on how to
> expose an MPTCP API that allows apps to control certain things on the
> subflows.
>

+1 to this since it will allow client platforms to use setsockopt to, for
example, bind subflows to interfaces (e.g., with SO_BINDTODEVICE, or with
SO_MARK as used by Android).

--===============1227515066608619366==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiBUdWUsIE1hciAyNywgMjAxOCBhdCAxMToxOCBBTSwgQ2hyaXN0b3BoIFBhYXNj
aCA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpjcGFhc2NoQGFwcGxlLmNvbSIg
dGFyZ2V0PSJfYmxhbmsiPmNwYWFzY2hAYXBwbGUuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxi
cj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhl
eDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5JdCBhbHNvIHdv
dWxkIGFsbG93IHVzIHRvIGV4cG9zZSBzdWJmbG93cyBhcyBmaWxlLWRlc2NyaXB0b3JzIHRvIHRo
ZTxicj4KdXNlci1zcGFjZS4gVGhhdCB3YXkgdGhlIHVzZXItc3BhY2UgY2FuIGRvIHNldHNvY2tv
cHQsIGdldHNvY2tvcHQsLi4uIG9uIHRoZTxicj4Kc3ViZmxvd3MuIEFuIGlkZWEgdGhhdCBjYW1l
IHVwIGluIHRoZSBwYXN0IHdoZW4gd2Ugd2VyZSB0aGlua2luZyBvbiBob3cgdG88YnI+CmV4cG9z
ZSBhbiBNUFRDUCBBUEkgdGhhdCBhbGxvd3MgYXBwcyB0byBjb250cm9sIGNlcnRhaW4gdGhpbmdz
IG9uIHRoZTxicj4Kc3ViZmxvd3MuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2
PisxIHRvIHRoaXMgc2luY2UgaXQgd2lsbCBhbGxvdyBjbGllbnQgcGxhdGZvcm1zIHRvIHVzZSBz
ZXRzb2Nrb3B0IHRvLCBmb3IgZXhhbXBsZSwgYmluZCBzdWJmbG93cyB0byBpbnRlcmZhY2VzIChl
LmcuLCB3aXRoIFNPX0JJTkRUT0RFVklDRSwgb3Igd2l0aCBTT19NQVJLIGFzIHVzZWQgYnkgQW5k
cm9pZCkuPC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============1227515066608619366==--
