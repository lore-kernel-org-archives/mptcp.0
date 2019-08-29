Content-Type: multipart/mixed; boundary="===============3524670813429956287=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v2 03/10] mptcp: token: rename token_join_response
Date: Thu, 29 Aug 2019 12:19:23 +0200
Message-ID: <20190829101923.GJ20113@breakpoint.cc>
In-Reply-To: db56ea7a-4d43-2766-7017-36552e2c62a2@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1755

--===============3524670813429956287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> A small detail: should we also add "subflow:" (or "sf:")?
> =

>     "MPTCP:sf: "

I modeled it after what is done for builtin code in net/, e.g.:

net/ipv4/ip_fragment.c:#define pr_fmt(fmt) "IPv4: " fmt
net/ipv4/ip_input.c:#define pr_fmt(fmt) "IPv4: " fmt
net/ipv4/ip_options.c:#define pr_fmt(fmt) "IPv4: " fmt
net/ipv4/route.c:#define pr_fmt(fmt) "IPv4: " fmt
net/ipv4/tcp.c:#define pr_fmt(fmt) "TCP: " fmt
net/ipv4/tcp_cong.c:#define pr_fmt(fmt) "TCP: " fmt
net/ipv4/tcp_input.c:#define pr_fmt(fmt) "TCP: " fmt
net/ipv4/tcp_ipv4.c:#define pr_fmt(fmt) "TCP: " fmt
net/ipv4/tcp_output.c:#define pr_fmt(fmt) "TCP: " fmt
net/ipv4/udp.c:#define pr_fmt(fmt) "UDP: " fmt
net/ipv4/udplite.c:#define pr_fmt(fmt) "UDPLite: " fmt
net/ipv4/xfrm4_tunnel.c:#define pr_fmt(fmt) "IPsec: " fmt
net/ipv6/addrconf.c:#define pr_fmt(fmt) "IPv6: " fmt
net/ipv6/af_inet6.c:#define pr_fmt(fmt) "IPv6: " fmt
net/ipv6/ah6.c:#define pr_fmt(fmt) "IPv6: " fmt
net/ipv6/esp6.c:#define pr_fmt(fmt) "IPv6: " fmt
...

So single "MPTCP: " seems more consistent with rest of kernel.
I have no strong opinion though, if others want more detailed
prefix too I can change it of course.

--===============3524670813429956287==--
