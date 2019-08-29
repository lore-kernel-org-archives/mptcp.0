Content-Type: multipart/mixed; boundary="===============8465982271250675186=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v2 03/10] mptcp: token: rename token_join_response
Date: Thu, 29 Aug 2019 12:25:45 +0200
Message-ID: <11e84df4-bbf7-023b-c0c5-b71182720599@tessares.net>
In-Reply-To: 20190829101923.GJ20113@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1756

--===============8465982271250675186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 29/08/2019 12:19, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> A small detail: should we also add "subflow:" (or "sf:")?
>>
>>     "MPTCP:sf: "
> =

> I modeled it after what is done for builtin code in net/, e.g.:

Thank you for having looking at that!

> net/ipv4/ip_fragment.c:#define pr_fmt(fmt) "IPv4: " fmt
> net/ipv4/ip_input.c:#define pr_fmt(fmt) "IPv4: " fmt
> net/ipv4/ip_options.c:#define pr_fmt(fmt) "IPv4: " fmt
> net/ipv4/route.c:#define pr_fmt(fmt) "IPv4: " fmt
> net/ipv4/tcp.c:#define pr_fmt(fmt) "TCP: " fmt
> net/ipv4/tcp_cong.c:#define pr_fmt(fmt) "TCP: " fmt
> net/ipv4/tcp_input.c:#define pr_fmt(fmt) "TCP: " fmt
> net/ipv4/tcp_ipv4.c:#define pr_fmt(fmt) "TCP: " fmt
> net/ipv4/tcp_output.c:#define pr_fmt(fmt) "TCP: " fmt
> net/ipv4/udp.c:#define pr_fmt(fmt) "UDP: " fmt
> net/ipv4/udplite.c:#define pr_fmt(fmt) "UDPLite: " fmt
> net/ipv4/xfrm4_tunnel.c:#define pr_fmt(fmt) "IPsec: " fmt
> net/ipv6/addrconf.c:#define pr_fmt(fmt) "IPv6: " fmt
> net/ipv6/af_inet6.c:#define pr_fmt(fmt) "IPv6: " fmt
> net/ipv6/ah6.c:#define pr_fmt(fmt) "IPv6: " fmt
> net/ipv6/esp6.c:#define pr_fmt(fmt) "IPv6: " fmt
> ...
> =

> So single "MPTCP: " seems more consistent with rest of kernel.
> I have no strong opinion though, if others want more detailed
> prefix too I can change it of course.

I also don't have a strong opinion on that, I am fine to follow what
seems to be the standard :-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8465982271250675186==--
