Content-Type: multipart/mixed; boundary="===============5958592101030678481=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] mptcp: let MPTCP create max size skbs
Date: Fri, 04 Dec 2020 19:00:24 +0100
Message-ID: <df005946-26c0-d80c-a3ac-38ed35de3c84@tessares.net>
In-Reply-To: d5c7935a21f20d37900cd51fc0f1f88327a0dfdd.1606406237.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7055

--===============5958592101030678481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 26/11/2020 16:58, Paolo Abeni wrote:
> Currently the xmit path of the MPTCP protocol creates smaller-
> than-max-size skbs, which is suboptimal for the performances.
> =

> There are a few things to improve:
> - when coalescing to an existing skb, must clear the PUSH flag
> - tcp_build_frag() expect the available space as an argument.
>    When coalescing is enable MPTCP already subtracted the
>    to-be-coalesced skb len. We must increment said argument
>    accordingly.
> =

> Before:
> ./use_mptcp.sh netperf -H 127.0.0.1 -t TCP_STREAM
> [...]
> 131072  16384  16384    30.00    24414.86
> =

> After:
> ./use_mptcp.sh netperf -H 127.0.0.1 -t TCP_STREAM
> [...]
> 131072  16384  16384    30.05    28357.69
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for your nice improvement and review!

- 31859991dc0f: mptcp: let MPTCP create max size skbs
- Results: f8649f5ba21e..54981c30b018

Tests + export have been scheduled!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5958592101030678481==--
