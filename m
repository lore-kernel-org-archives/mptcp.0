Content-Type: multipart/mixed; boundary="===============8694557961172652286=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Part 2 - Cover Letter
Date: Thu, 16 Jan 2020 17:33:24 -0800
Message-ID: <alpine.OSX.2.21.2001161729180.45790@ndoyal-mobl1.amr.corp.intel.com>
In-Reply-To: FDE750BB-804A-428B-B31A-9B5539276D3A@apple.com
X-Status: 
X-Keywords:                  
X-UID: 3387

--===============8694557961172652286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 16 Jan 2020, Christoph Paasch wrote:

> =

>
>       On Jan 16, 2020, at 10:07 AM, Christoph Paasch <cpaasch(a)apple.com=
> wrote:
> =

> Hello,
> here is the proposed cover-letter for Part 2. I assume that it will be "v=
3" as Mat already sent out the v2 before Christmas.
>

Yes, it should be v3.

Cover letter additions for RFC8684 look good, thanks Christoph.


Mat


> Please let me know what should be changed.
> =

> =3D=3D=3D=3D=3D=3D
> =

> Subject: [PATCH net-next v3 ...]=C2=A0Multipath TCP part 2: Single subflow
> =

> v2 -> v3: Added RFC8684-style handshake and some minor fixes
> v1 -> v2: Rebased on latest "Multipath TCP: Prerequisites" v3 series
> =

> This set adds MPTCP connection establishment, writing & reading MPTCP
> options on data packets, a sysctl to allow MPTCP per-namespace, and self
> tests. This is sufficient to establish and maintain a connection with a
> MPTCP peer, but will not yet allow or initiate establishment of
> additional MPTCP subflows.
> =

> We also add the necessary code for the RFC8684-style handshake.
> RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on to
> version 1.
> =

> The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
> deployments are currently based on RFC 6824, future deployments will be
> migrating to MPTCP version 1. 3GPP's 5G standardization also solely suppo=
rts
> RFC 8684. Also, we believe that this initial submission of MPTCP will be
> cleaner by solely supporting RFC 8684. If later on support for the old
> MPTCP-version is required it can always be added in the future.
> =

> The major difference between RFC 8684 and RFC 6824 is that it has a better
> support for servers using TCP SYN-cookies by reliably retransmitting the
> MP_CAPABLE option.
> =

> =

> I forgot the Twitter reference! Matth, any good ideas for a joke? :-)
> =

> =

> Christoph
> =

> =

>
>       Clone/fetch:
>       https://github.com/multipath-tcp/mptcp_net-next.git=C2=A0(tag: netd=
ev-v3-part2)
>
>       Browse:
>       https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v3-part2
>
>       Thank you for your review. You can find us at=C2=A0mptcp(a)lists.01=
.org=C2=A0and
>       https://is.gd/mptcp_upstream
> =

> =3D=3D=3D=3D=3D=3D
> =

> Cheers,
> Christoph
> =

> =

> =

>

--
Mat Martineau
Intel

--===============8694557961172652286==--
