Content-Type: multipart/mixed; boundary="===============5771244924009374430=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 00/15] Multipath TCP part 2: Single subflow
Date: Fri, 13 Dec 2019 23:38:11 -0800
Message-ID: <alpine.OSX.2.21.1912132330360.40703@amhui-mobl1.amr.corp.intel.com>
In-Reply-To: 20191213205106.2467313-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3065

--===============5771244924009374430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 13 Dec 2019, Matthieu Baerts wrote:

> These patches depend on the "Multipath TCP part 1: Prerequisites" patch
> set sent earlier.
>
> This set adds MPTCP connection establishment, writing & reading MPTCP
> options on data packets, a sysctl to allow MPTCP per-namespace, and self
> tests. This is sufficient to establish and maintain a connection with a
> MPTCP peer, but will not yet allow or initiate establishment of
> additional MPTCP subflows.
>
> Clone/fetch:
> https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-v1-part2)
>
> Browse:
> https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v1-part2
>
> Thank your for your review. You can find us at mptcp(a)lists.01.org and
> https://is.gd/mptcp_upstream
>

Matthieu -

Here are the three commits that we modified for the netdev-v1-part2 =

submission:


https://github.com/multipath-tcp/mptcp_net-next/commit/1d9cd488687c4fcb7255=
f2a6428980e6f0bfb68f

https://github.com/multipath-tcp/mptcp_net-next/commit/eb7be7fa655c8fd49106=
c2e83edc1d24b50d73be

https://github.com/multipath-tcp/mptcp_net-next/commit/519412484946e9eb807d=
6b486a72b0d26f49daec


I also recreated three tags:

netdev-v1-part2 21e30402537066e81732e00f06f58d3b1489d6a7

netdev-v1-part3 95f4f3cf36331a752562659a038a68cf8ce09108

netdev-v1-full 2afd1babd9ce15224792ee254407d79df5cd2241

--
Mat Martineau
Intel
--===============5771244924009374430==--
