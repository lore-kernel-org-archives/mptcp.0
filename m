Content-Type: multipart/mixed; boundary="===============5978198867921736322=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/3] mptcp: add add_addr_echo
 sysctl
Date: Fri, 25 Sep 2020 13:25:11 +0800
Message-ID: <CA+WQbwtFDBAQEuYU9dQMrc0UWiq+DoAe2uaHTemOsdR_dqc1uw@mail.gmail.com>
In-Reply-To: d6f2c576a003194210726ff820df728640340bb8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6043

--===============5978198867921736322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 2020-09-22 at 16:12 +0800, Geliang Tang wrote:
> > This patch added a new sysctl, named add_addr_echo, to control the
> > ADD_ADDR
> > echo ability.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>
> If I read the series correctly, this sysctl is only needed for self-
> test's sake, right? can you instead drop the add_addr packet with some
> netfilter rules ? possibly matching on TCP PROTO, TCP len =3D=3D 0 and the
> appropriate packet len should be sufficient.

I still have not found the rules that can drop ADD_ADDR packets. But I found
something useful like this:

# iptables -A OUTPUT -p tcp --tcp-option 30 -m length --length 0:100 -j DROP

"tcp-option 30" can match MPTCP packets, and "length" can match the IP
packet's total length. But they are not sufficient.

Could you please give me some suggestions about this? Can I write a new
netfiler module to do this? Is this acceptable?

Thanks.

-Geliang

>
> Disabling the echo would likely violate the RFC, I think that exposing
> this ability to user-space would be too much even for unix
> philosophy[1] ;)
>
> Cheers,
>
> Paolo
>
> [1] http://www.anvari.org/fortune/Miscellaneous_Collections/412232_the-un=
ix-philosophy-basically-involves-giving-you-enough-rope-to-hang-yourself.ht=
ml
>
--===============5978198867921736322==--
