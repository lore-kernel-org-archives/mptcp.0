Content-Type: multipart/mixed; boundary="===============3816933499089186239=="
MIME-Version: 1.0
From: Sandeep Irlanki <irlanki.sandeep at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [mptcp-dev] mptcp code in kernel 5.8
Date: Tue, 20 Oct 2020 19:49:47 +0530
Message-ID: <CABbBbOtCThc1VP-XMBy05AyuntypDRfxVWDdZzNHT1Xav=eo1Q@mail.gmail.com>
In-Reply-To: 380c19a3-1fe4-fa68-6b0c-0ef730eb9c3b@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6364

--===============3816933499089186239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

So, MPTCP flow doesn't work if client is installed with MPTCP V1 and server
with MPTCP V0? In this case, Client falls back to TCP in initial handshake
itself?


Thanks,
Sandeep.


On Thu, 15 Oct 2020, 2:00 pm Matthieu Baerts <matthieu.baerts(a)tessares.net
wrote:

> Hi Yoshi,
>
> On 15/10/2020 10:09, yoshi nishida wrote:
> > Hmm. I've tried v0.95 mptcp kernel and kernel5.8 on ubuntu20.10.
> > I tried both version 0 and 1 on v.95, but didn't work. But, I might
> > miss something.
>
> I guess you are referring to a sysctl parameter, right? If yes, on
> v0.95, there is a partial support of MPTCPv1 regarding the modifications
> around ADD_ADDR (with or without HMAC I think) but that's it.
>
> The v0.95 doesn't support the new way of initiating an MPTCP connection
> making v0 and v1 incompatible. Of course, except if a fallback from v1
> to v0 is implemented, which is not the case in the upstream version.
>
> But in other words, v0.95 is not compatible with MPTCPv1. Only
> mptcp_trunk is:
>
> https://github.com/multipath-tcp/mptcp/tree/mptcp_trunk
>
> > I will dig into this a bit more as well as some minor issues I noticed
> > during the weekend.
>
> Thanks!
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--===============3816933499089186239==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9ImF1dG8iPjxkaXY+SGkgTWF0dGhpZXUsPGRpdiBkaXI9ImF1dG8iPjxicj48L2Rp
dj48ZGl2IGRpcj0iYXV0byI+U28sIE1QVENQIGZsb3cgZG9lc24mIzM5O3Qgd29yayBpZiBjbGll
bnQgaXMgaW5zdGFsbGVkIHdpdGggTVBUQ1AgVjEgYW5kIHNlcnZlciB3aXRoIE1QVENQIFYwPyBJ
biB0aGlzIGNhc2UsIENsaWVudCBmYWxscyBiYWNrIHRvIFRDUCBpbiBpbml0aWFsIGhhbmRzaGFr
ZSBpdHNlbGY/PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+
PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5UaGFua3MsPC9kaXY+PGRpdiBkaXI9ImF1dG8iPlNh
bmRlZXAuPC9kaXY+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0
ciI+T24gVGh1LCAxNSBPY3QgMjAyMCwgMjowMCBwbSBNYXR0aGlldSBCYWVydHMgJmx0OzxhIGhy
ZWY9Im1haWx0bzptYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Ij5tYXR0aGlldS5iYWVydHNA
dGVzc2FyZXMubmV0PC9hPiB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29s
aWQ7cGFkZGluZy1sZWZ0OjFleCI+SGkgWW9zaGksPGJyPgo8YnI+Ck9uIDE1LzEwLzIwMjAgMTA6
MDksIHlvc2hpIG5pc2hpZGEgd3JvdGU6PGJyPgomZ3Q7IEhtbS4gSSYjMzk7dmUgdHJpZWQgdjAu
OTUgbXB0Y3Aga2VybmVsIGFuZCBrZXJuZWw1Ljggb24gdWJ1bnR1MjAuMTAuPGJyPgomZ3Q7IEkg
dHJpZWQgYm90aCB2ZXJzaW9uIDAgYW5kIDEgb24gdi45NSwgYnV0IGRpZG4mIzM5O3Qgd29yay4g
QnV0LCBJIG1pZ2h0PGJyPgomZ3Q7IG1pc3Mgc29tZXRoaW5nLjxicj4KPGJyPgpJIGd1ZXNzIHlv
dSBhcmUgcmVmZXJyaW5nIHRvIGEgc3lzY3RsIHBhcmFtZXRlciwgcmlnaHQ/IElmIHllcywgb24g
PGJyPgp2MC45NSwgdGhlcmUgaXMgYSBwYXJ0aWFsIHN1cHBvcnQgb2YgTVBUQ1B2MSByZWdhcmRp
bmcgdGhlIG1vZGlmaWNhdGlvbnMgPGJyPgphcm91bmQgQUREX0FERFIgKHdpdGggb3Igd2l0aG91
dCBITUFDIEkgdGhpbmspIGJ1dCB0aGF0JiMzOTtzIGl0Ljxicj4KPGJyPgpUaGUgdjAuOTUgZG9l
c24mIzM5O3Qgc3VwcG9ydCB0aGUgbmV3IHdheSBvZiBpbml0aWF0aW5nIGFuIE1QVENQIGNvbm5l
Y3Rpb24gPGJyPgptYWtpbmcgdjAgYW5kIHYxIGluY29tcGF0aWJsZS4gT2YgY291cnNlLCBleGNl
cHQgaWYgYSBmYWxsYmFjayBmcm9tIHYxIDxicj4KdG8gdjAgaXMgaW1wbGVtZW50ZWQsIHdoaWNo
IGlzIG5vdCB0aGUgY2FzZSBpbiB0aGUgdXBzdHJlYW0gdmVyc2lvbi48YnI+Cjxicj4KQnV0IGlu
IG90aGVyIHdvcmRzLCB2MC45NSBpcyBub3QgY29tcGF0aWJsZSB3aXRoIE1QVENQdjEuIE9ubHkg
PGJyPgptcHRjcF90cnVuayBpczo8YnI+Cjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29t
L211bHRpcGF0aC10Y3AvbXB0Y3AvdHJlZS9tcHRjcF90cnVuayIgcmVsPSJub3JlZmVycmVyIG5v
cmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpdGh1Yi5jb20vbXVsdGlwYXRoLXRj
cC9tcHRjcC90cmVlL21wdGNwX3RydW5rPC9hPjxicj4KPGJyPgomZ3Q7IEkgd2lsbCBkaWcgaW50
byB0aGlzIGEgYml0IG1vcmUgYXMgd2VsbCBhcyBzb21lIG1pbm9yIGlzc3VlcyBJIG5vdGljZWQ8
YnI+CiZndDsgZHVyaW5nIHRoZSB3ZWVrZW5kLjxicj4KPGJyPgpUaGFua3MhPGJyPgo8YnI+CkNo
ZWVycyw8YnI+Ck1hdHQ8YnI+Ci0tIDxicj4KVGVzc2FyZXMgfCBCZWxnaXVtIHwgSHlicmlkIEFj
Y2VzcyBTb2x1dGlvbnM8YnI+CjxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiByZWw9
Im5vcmVmZXJyZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPnd3dy50ZXNzYXJlcy5uZXQ8
L2E+PGJyPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxi
cj4KbXB0Y3AgbWFpbGluZyBsaXN0IC0tIDxhIGhyZWY9Im1haWx0bzptcHRjcEBsaXN0cy4wMS5v
cmciIHRhcmdldD0iX2JsYW5rIiByZWw9Im5vcmVmZXJyZXIiPm1wdGNwQGxpc3RzLjAxLm9yZzwv
YT48YnI+ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gPGEgaHJlZj0ibWFpbHRvOm1w
dGNwLWxlYXZlQGxpc3RzLjAxLm9yZyIgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZlcnJlciI+
bXB0Y3AtbGVhdmVAbGlzdHMuMDEub3JnPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2
PjwvZGl2Pgo=

--===============3816933499089186239==--
