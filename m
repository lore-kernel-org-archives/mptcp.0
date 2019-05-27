Content-Type: multipart/mixed; boundary="===============6959883519816540348=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] mptcp_connect.sh typo
Date: Mon, 27 May 2019 10:09:58 +0200
Message-ID: <5bf0813f-0207-1127-f6bf-08d0fc0a6205@tessares.net>
In-Reply-To: 20190526222837.cile7pt4xzcjcbwe@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1247

--===============6959883519816540348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 27/05/2019 00:28, Florian Westphal wrote:
> For some reason ethtool is spelt "ethtook".
> =

> Could someone squash/fix this?

Good catch!

- 35334df7c17d: "squash"
- f917b354b618..bae29fe21499: result
- d051405de3a7: in the "export" branch

Cheers,
Matt

> Thanks!
> =

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -74,7 +74,7 @@ ip -net ns3 addr add 10.0.3.2/24 dev ns3eth4
>  ip -net ns3 link set ns3eth4 up
>  ip -net ns3 route add default via 10.0.2.1
>  tc -net ns3 qdisc add dev ns3eth4 root netem delay 10ms reorder 25% 50% =
gap 5
> -ip netns exec ns3 ethtook -K ns3eth2 tso off
> +ip netns exec ns3 ethtool -K ns3eth2 tso off
>  ip netns exec ns3 sysctl -q net.ipv4.ip_forward=3D1
>  =

>  ip -net ns4 addr add 10.0.3.1/24 dev ns4eth3
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6959883519816540348==--
