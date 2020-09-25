Content-Type: multipart/mixed; boundary="===============3468669747379052529=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/3] mptcp: add add_addr_echo
 sysctl
Date: Fri, 25 Sep 2020 10:55:44 +0200
Message-ID: <361f0e5cc4c03338ddb3867458a2a8a0f1131b7f.camel@redhat.com>
In-Reply-To: CA+WQbwtFDBAQEuYU9dQMrc0UWiq+DoAe2uaHTemOsdR_dqc1uw@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6044

--===============3468669747379052529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-09-25 at 13:25 +0800, Geliang Tang wrote:
> Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:26=E5=86=99=E9=81=93=EF=BC=9A
> > On Tue, 2020-09-22 at 16:12 +0800, Geliang Tang wrote:
> > > This patch added a new sysctl, named add_addr_echo, to control
> > > the
> > > ADD_ADDR
> > > echo ability.
> > > =

> > > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > =

> > If I read the series correctly, this sysctl is only needed for
> > self-
> > test's sake, right? can you instead drop the add_addr packet with
> > some
> > netfilter rules ? possibly matching on TCP PROTO, TCP len =3D=3D 0 and
> > the
> > appropriate packet len should be sufficient.
> =

> I still have not found the rules that can drop ADD_ADDR packets. But
> I found
> something useful like this:
> =

> # iptables -A OUTPUT -p tcp --tcp-option 30 -m length --length 0:100
> -j DROP
> =

> "tcp-option 30" can match MPTCP packets, and "length" can match the
> IP
> packet's total length. But they are not sufficient.

You can use u32 to check that the sub-option type is 3 (=3D=3D ADD_ADDR),
with something alike:

iptables -A OUTPUT -p tcp --tcp-option 30 -m length 80 -m u32 "37&0xFF=3D=
=3D0x1 && 38&0xFF=3D=3D0x1 && 39&0xFF=3D=3D0x8 && 49&0xFF=3D=3D0x1e && 51&0=
xFF=3D=3D0x3" -j DROP

The basic u32 match syntax is:

<offset> & <mask> =3D <value>

u32 will read the 4 bytes from the packet at starting from <offset>
intepreting them a little-endian integer, will mask (bitwise 'and')
with <mask> and will compare the result with the provided <value>. More
expression can be concatenated with '&&'.

The above u32 match assumes there are no IP options, so that the TCP
header starts at offset 20 and the first TCP option starts at offset
40. To read a byte a such offset we must actually load the 4bytes
integer starting 3 bytes earlier so that bytes with offset 40 will be
the least significant one in the loaded (little-endian) u32.

Overall the above checks that the TCP options are 2 nops  (37&0xFF=3D=3D0x1
&& 38&0xFF=3D=3D0x1), a timestamp (&& 39&0x8=3D0x8), an MPTCP (&&
49&0xFF=3D=3D0x1e) with suboption 3 (&& 51=3D0x3), which means ADD_ADDR. =


That is the layout I observe here with wireshark for an MPTCP ADD_ADDR
packet over ipv4. Generally speaking this kind of matches are fragile,
but in this case should be roboust enough.

I also refined the IP len to 80, which is the value I observe here.
Again I think should be stable enough in this case.

All the above is completely non tested, so it may include syntax errors
and could be inaccurate, please double check!

@Florian: do you think something alike the above could be enough to
drop ADD_ADDR only? any better option? (likely nft is the tool here ;)

Thanks!

Paolo

--===============3468669747379052529==--
