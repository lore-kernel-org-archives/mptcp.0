Content-Type: multipart/mixed; boundary="===============2657505057274274173=="
MIME-Version: 1.0
From: Marios Choudary <marios.choudary at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Android phones with MPTCP
Date: Mon, 16 Nov 2020 19:54:18 +0200
Message-ID: <CAOenT2P2BxoSu63mczEBPeiWNLbaOi3Vq9W1awbj16qy6tCQuQ@mail.gmail.com>
In-Reply-To: CADHp1Nz_OThAPVQiQcvFE+JEVCRdhVEDk55+w5zB1SNhhcA6fA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6756

--===============2657505057274274173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks. How can I check the MPTCP lib on this phone? I looked through the
code here:
http://repo.pureos.net/pureos/pool/main/

but could not find the mptcp packages.

On the other hand, I did find MPTCP in the recent Samsung phones, as you
suggested, e.g. here:
https://opensource.samsung.com/uploadSearch?searchValue=3Dkernel

and several models such as Galaxy S20 Ultra 5G, Galaxy S10 show up with
mptcp in the kernel (search for "kernel" in the link above).

Best wishes,
  Marios


On Mon, Nov 16, 2020 at 3:20 PM Matt <mattator(a)gmail.com> wrote:

> It's not an android but still a smartphone I believe
> https://puri.sm/products/librem-5/ could do it.
>
> Le lun. 16 nov. 2020 =C3=A0 11:25, Marios Choudary
> <marios.choudary(a)gmail.com> a =C3=A9crit :
> >
> > Thanks a lot for the information Matt.
> >
> > Best wishes,
> >   Marios
> >
> > On Fri, Nov 13, 2020 at 6:47 PM Matthieu Baerts <
> matthieu.baerts(a)tessares.net> wrote:
> >>
> >> Hi Marios,
> >>
> >> On 12/11/2020 18:15, Marios Choudary wrote:
> >> > Could you please help me with a list of Android smartphones that
> support
> >> > MPTCP ?
> >>
> >> This project is about MPTCP in the upstream Linux kernel. The work is =
in
> >> progress and the inclusion started in Linux 5.6. It is a rework of a
> >> fork that was started a few years ago. More details in our wiki:
> >>
> >> https://github.com/multipath-tcp/mptcp_net-next/wiki
> >>
> >> You then need to find a phone using a kernel >=3D5.6
> >>
> >> > I would prefer to know about recent models, either Samsung or Google
> >> > Pixel, but if there is some comprehensive list that would be great as
> well.
> >>
> >> To my knowledge, most recent phones are using a kernel 4.19 or older. =
In
> >> Android, they are usually using the LTS version. The next ones are v5.4
> >> and v5.10.
> >>
> >> Also I heard that at Linaro, they have a project to use the mainstream
> >> kernel:
> >>
> >>
> https://www.linaro.org/blog/aosp-on-pixel3-pocof1-running-aosp-with-mainl=
ine-kernel-on-form-factor-devices/
> >>
> >>
> >> If you are interested by the out-of-tree kernel (mptcp.org), another
> >> company should release a kernel with MPTCP (fork) for the PocoF1. No
> >> idea when.
> >> One last thing, some phones have MPTCP support (Apple, some Samsung,
> >> Huawei, LG, etc.). For the Android ones, you certainly need extra
> >> permissions to be able to use MPTCP and configure it. I don't have a
> >> list for that, you need to check the source code of their kernel to see
> >> if the folder "net/mptcp" exists.
> >>
> >> If you have questions about that, the best is to ask them on the ML
> >> linked to this other project:
> >>
> >> mptcp-dev(a)listes.uclouvain.be
> >> http://multipath-tcp.org/
> >>
> >> Cheers,
> >> Matt
> >> --
> >> Tessares | Belgium | Hybrid Access Solutions
> >> www.tessares.net
> >
> > _______________________________________________
> > mptcp mailing list -- mptcp(a)lists.01.org
> > To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--===============2657505057274274173==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+VGhhbmtzLiBIb3cgY2FuIEkgY2hlY2sgdGhlIE1QVENQIGxpYiBvbiB0
aGlzIHBob25lPyBJIGxvb2tlZCB0aHJvdWdoIHRoZSBjb2RlIGhlcmU6PGRpdj48YSBocmVmPSJo
dHRwOi8vcmVwby5wdXJlb3MubmV0L3B1cmVvcy9wb29sL21haW4vIj5odHRwOi8vcmVwby5wdXJl
b3MubmV0L3B1cmVvcy9wb29sL21haW4vPC9hPjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PmJ1dCBjb3VsZCBub3QgZmluZCB0aGUgbXB0Y3AgcGFja2FnZXMuPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5PbiB0aGUgb3RoZXIgaGFuZCwgSSBkaWQgZmluZCBNUFRDUCBpbiB0aGUgcmVjZW50
IFNhbXN1bmcgcGhvbmVzLCBhcyB5b3Ugc3VnZ2VzdGVkLCBlLmcuIGhlcmU6PC9kaXY+PGRpdj48
YSBocmVmPSJodHRwczovL29wZW5zb3VyY2Uuc2Ftc3VuZy5jb20vdXBsb2FkU2VhcmNoP3NlYXJj
aFZhbHVlPWtlcm5lbCI+aHR0cHM6Ly9vcGVuc291cmNlLnNhbXN1bmcuY29tL3VwbG9hZFNlYXJj
aD9zZWFyY2hWYWx1ZT1rZXJuZWw8L2E+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5hbmQgc2V2
ZXJhbCBtb2RlbHMgc3VjaCBhcyBHYWxheHnCoFMyMCBVbHRyYSA1RywgR2FsYXh5IFMxMCBzaG93
IHVwIHdpdGggbXB0Y3AgaW4gdGhlIGtlcm5lbCAoc2VhcmNoIGZvciAmcXVvdDtrZXJuZWwmcXVv
dDsgaW4gdGhlIGxpbmsgYWJvdmUpLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QmVzdCB3aXNo
ZXMsPC9kaXY+PGRpdj7CoCBNYXJpb3M8L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48YnI+PGRp
diBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5P
biBNb24sIE5vdiAxNiwgMjAyMCBhdCAzOjIwIFBNIE1hdHQgJmx0OzxhIGhyZWY9Im1haWx0bzpt
YXR0YXRvckBnbWFpbC5jb20iPm1hdHRhdG9yQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+SXQmIzM5O3Mgbm90IGFuIGFuZHJvaWQgYnV0IHN0aWxsIGEgc21hcnRwaG9u
ZSBJIGJlbGlldmU8YnI+CjxhIGhyZWY9Imh0dHBzOi8vcHVyaS5zbS9wcm9kdWN0cy9saWJyZW0t
NS8iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vcHVyaS5zbS9wcm9k
dWN0cy9saWJyZW0tNS88L2E+IGNvdWxkIGRvIGl0Ljxicj4KPGJyPgpMZSBsdW4uIDE2IG5vdi4g
MjAyMCDDoCAxMToyNSwgTWFyaW9zIENob3VkYXJ5PGJyPgombHQ7PGEgaHJlZj0ibWFpbHRvOm1h
cmlvcy5jaG91ZGFyeUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5tYXJpb3MuY2hvdWRhcnlA
Z21haWwuY29tPC9hPiZndDsgYSDDqWNyaXQgOjxicj4KJmd0Ozxicj4KJmd0OyBUaGFua3MgYSBs
b3QgZm9yIHRoZSBpbmZvcm1hdGlvbiBNYXR0Ljxicj4KJmd0Ozxicj4KJmd0OyBCZXN0IHdpc2hl
cyw8YnI+CiZndDvCoCDCoE1hcmlvczxicj4KJmd0Ozxicj4KJmd0OyBPbiBGcmksIE5vdiAxMywg
MjAyMCBhdCA2OjQ3IFBNIE1hdHRoaWV1IEJhZXJ0cyAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1hdHRo
aWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQiIHRhcmdldD0iX2JsYW5rIj5tYXR0aGlldS5iYWVydHNA
dGVzc2FyZXMubmV0PC9hPiZndDsgd3JvdGU6PGJyPgomZ3Q7Jmd0Ozxicj4KJmd0OyZndDsgSGkg
TWFyaW9zLDxicj4KJmd0OyZndDs8YnI+CiZndDsmZ3Q7IE9uIDEyLzExLzIwMjAgMTg6MTUsIE1h
cmlvcyBDaG91ZGFyeSB3cm90ZTo8YnI+CiZndDsmZ3Q7ICZndDsgQ291bGQgeW91IHBsZWFzZSBo
ZWxwIG1lIHdpdGggYSBsaXN0IG9mIEFuZHJvaWQgc21hcnRwaG9uZXMgdGhhdCBzdXBwb3J0PGJy
PgomZ3Q7Jmd0OyAmZ3Q7IE1QVENQID88YnI+CiZndDsmZ3Q7PGJyPgomZ3Q7Jmd0OyBUaGlzIHBy
b2plY3QgaXMgYWJvdXQgTVBUQ1AgaW4gdGhlIHVwc3RyZWFtIExpbnV4IGtlcm5lbC4gVGhlIHdv
cmsgaXMgaW48YnI+CiZndDsmZ3Q7IHByb2dyZXNzIGFuZCB0aGUgaW5jbHVzaW9uIHN0YXJ0ZWQg
aW4gTGludXggNS42LiBJdCBpcyBhIHJld29yayBvZiBhPGJyPgomZ3Q7Jmd0OyBmb3JrIHRoYXQg
d2FzIHN0YXJ0ZWQgYSBmZXcgeWVhcnMgYWdvLiBNb3JlIGRldGFpbHMgaW4gb3VyIHdpa2k6PGJy
PgomZ3Q7Jmd0Ozxicj4KJmd0OyZndDsgPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL211bHRp
cGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvd2lraSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9i
bGFuayI+aHR0cHM6Ly9naXRodWIuY29tL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvd2lr
aTwvYT48YnI+CiZndDsmZ3Q7PGJyPgomZ3Q7Jmd0OyBZb3UgdGhlbiBuZWVkIHRvIGZpbmQgYSBw
aG9uZSB1c2luZyBhIGtlcm5lbCAmZ3Q7PTUuNjxicj4KJmd0OyZndDs8YnI+CiZndDsmZ3Q7ICZn
dDsgSSB3b3VsZCBwcmVmZXIgdG8ga25vdyBhYm91dCByZWNlbnQgbW9kZWxzLCBlaXRoZXIgU2Ft
c3VuZyBvciBHb29nbGU8YnI+CiZndDsmZ3Q7ICZndDsgUGl4ZWwsIGJ1dCBpZiB0aGVyZSBpcyBz
b21lIGNvbXByZWhlbnNpdmUgbGlzdCB0aGF0IHdvdWxkIGJlIGdyZWF0IGFzIHdlbGwuPGJyPgom
Z3Q7Jmd0Ozxicj4KJmd0OyZndDsgVG8gbXkga25vd2xlZGdlLCBtb3N0IHJlY2VudCBwaG9uZXMg
YXJlIHVzaW5nIGEga2VybmVsIDQuMTkgb3Igb2xkZXIuIEluPGJyPgomZ3Q7Jmd0OyBBbmRyb2lk
LCB0aGV5IGFyZSB1c3VhbGx5IHVzaW5nIHRoZSBMVFMgdmVyc2lvbi4gVGhlIG5leHQgb25lcyBh
cmUgdjUuNDxicj4KJmd0OyZndDsgYW5kIHY1LjEwLjxicj4KJmd0OyZndDs8YnI+CiZndDsmZ3Q7
IEFsc28gSSBoZWFyZCB0aGF0IGF0IExpbmFybywgdGhleSBoYXZlIGEgcHJvamVjdCB0byB1c2Ug
dGhlIG1haW5zdHJlYW08YnI+CiZndDsmZ3Q7IGtlcm5lbDo8YnI+CiZndDsmZ3Q7PGJyPgomZ3Q7
Jmd0OyA8YSBocmVmPSJodHRwczovL3d3dy5saW5hcm8ub3JnL2Jsb2cvYW9zcC1vbi1waXhlbDMt
cG9jb2YxLXJ1bm5pbmctYW9zcC13aXRoLW1haW5saW5lLWtlcm5lbC1vbi1mb3JtLWZhY3Rvci1k
ZXZpY2VzLyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cubGlu
YXJvLm9yZy9ibG9nL2Fvc3Atb24tcGl4ZWwzLXBvY29mMS1ydW5uaW5nLWFvc3Atd2l0aC1tYWlu
bGluZS1rZXJuZWwtb24tZm9ybS1mYWN0b3ItZGV2aWNlcy88L2E+PGJyPgomZ3Q7Jmd0Ozxicj4K
Jmd0OyZndDs8YnI+CiZndDsmZ3Q7IElmIHlvdSBhcmUgaW50ZXJlc3RlZCBieSB0aGUgb3V0LW9m
LXRyZWUga2VybmVsICg8YSBocmVmPSJodHRwOi8vbXB0Y3Aub3JnIiByZWw9Im5vcmVmZXJyZXIi
IHRhcmdldD0iX2JsYW5rIj5tcHRjcC5vcmc8L2E+KSwgYW5vdGhlcjxicj4KJmd0OyZndDsgY29t
cGFueSBzaG91bGQgcmVsZWFzZSBhIGtlcm5lbCB3aXRoIE1QVENQIChmb3JrKSBmb3IgdGhlIFBv
Y29GMS4gTm88YnI+CiZndDsmZ3Q7IGlkZWEgd2hlbi48YnI+CiZndDsmZ3Q7IE9uZSBsYXN0IHRo
aW5nLCBzb21lIHBob25lcyBoYXZlIE1QVENQIHN1cHBvcnQgKEFwcGxlLCBzb21lIFNhbXN1bmcs
PGJyPgomZ3Q7Jmd0OyBIdWF3ZWksIExHLCBldGMuKS4gRm9yIHRoZSBBbmRyb2lkIG9uZXMsIHlv
dSBjZXJ0YWlubHkgbmVlZCBleHRyYTxicj4KJmd0OyZndDsgcGVybWlzc2lvbnMgdG8gYmUgYWJs
ZSB0byB1c2UgTVBUQ1AgYW5kIGNvbmZpZ3VyZSBpdC4gSSBkb24mIzM5O3QgaGF2ZSBhPGJyPgom
Z3Q7Jmd0OyBsaXN0IGZvciB0aGF0LCB5b3UgbmVlZCB0byBjaGVjayB0aGUgc291cmNlIGNvZGUg
b2YgdGhlaXIga2VybmVsIHRvIHNlZTxicj4KJmd0OyZndDsgaWYgdGhlIGZvbGRlciAmcXVvdDtu
ZXQvbXB0Y3AmcXVvdDsgZXhpc3RzLjxicj4KJmd0OyZndDs8YnI+CiZndDsmZ3Q7IElmIHlvdSBo
YXZlIHF1ZXN0aW9ucyBhYm91dCB0aGF0LCB0aGUgYmVzdCBpcyB0byBhc2sgdGhlbSBvbiB0aGUg
TUw8YnI+CiZndDsmZ3Q7IGxpbmtlZCB0byB0aGlzIG90aGVyIHByb2plY3Q6PGJyPgomZ3Q7Jmd0
Ozxicj4KJmd0OyZndDsgPGEgaHJlZj0ibWFpbHRvOm1wdGNwLWRldkBsaXN0ZXMudWNsb3V2YWlu
LmJlIiB0YXJnZXQ9Il9ibGFuayI+bXB0Y3AtZGV2QGxpc3Rlcy51Y2xvdXZhaW4uYmU8L2E+PGJy
PgomZ3Q7Jmd0OyA8YSBocmVmPSJodHRwOi8vbXVsdGlwYXRoLXRjcC5vcmcvIiByZWw9Im5vcmVm
ZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vbXVsdGlwYXRoLXRjcC5vcmcvPC9hPjxicj4K
Jmd0OyZndDs8YnI+CiZndDsmZ3Q7IENoZWVycyw8YnI+CiZndDsmZ3Q7IE1hdHQ8YnI+CiZndDsm
Z3Q7IC0tPGJyPgomZ3Q7Jmd0OyBUZXNzYXJlcyB8IEJlbGdpdW0gfCBIeWJyaWQgQWNjZXNzIFNv
bHV0aW9uczxicj4KJmd0OyZndDsgPGEgaHJlZj0iaHR0cDovL3d3dy50ZXNzYXJlcy5uZXQiIHJl
bD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPnd3dy50ZXNzYXJlcy5uZXQ8L2E+PGJyPgom
Z3Q7PGJyPgomZ3Q7IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fPGJyPgomZ3Q7IG1wdGNwIG1haWxpbmcgbGlzdCAtLSA8YSBocmVmPSJtYWlsdG86bXB0Y3BA
bGlzdHMuMDEub3JnIiB0YXJnZXQ9Il9ibGFuayI+bXB0Y3BAbGlzdHMuMDEub3JnPC9hPjxicj4K
Jmd0OyBUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIDxhIGhyZWY9Im1haWx0bzptcHRj
cC1sZWF2ZUBsaXN0cy4wMS5vcmciIHRhcmdldD0iX2JsYW5rIj5tcHRjcC1sZWF2ZUBsaXN0cy4w
MS5vcmc8L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============2657505057274274173==--
