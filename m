Content-Type: multipart/mixed; boundary="===============4267179114430180208=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [mptcp-dev] mptcp code in kernel 5.8
Date: Wed, 14 Oct 2020 11:13:35 +0200
Message-ID: <5f11e7f7-2100-8b51-36bb-d0f084ab6477@tessares.net>
In-Reply-To: CAO=PVE-KKsfQufb1N8xjqqFKrqQ09vc03yPP_zv01FnScdDXkA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6300

--===============4267179114430180208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yoshi,

On 14/10/2020 11:02, yoshi nishida wrote:
> Hi Christoph,
> =

> Sorry for the late reply. Yes, I meant the repo of multipath-tcp.org kern=
el.
> As far as I tested, it seems that they are quite different and they
> cannot interact with each other.

The upstream version only supports the latest MPTCP protocol: v1. All =

stable versions of the multipath-tcp.org kernel only support the now =

deprecated MPTCPv0 protocol. The development version starts supporting =

MPTCPv1.

I guess you likely tested two implementations only supporting 2 =

different versions of the protocols that are incompatible with each others.

Please see this for more details:

 =

https://github.com/multipath-tcp/mptcp_net-next/wiki#upstream-vs-out-of-tre=
e-implementations

> But, at least, I understand the situation. Thanks for the explanation!
> So, if I find a bug in the upstream code, it is ok to send it to the
> upstreaming list?

Yes please, this version is in development so any feedback is welcome!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4267179114430180208==--
