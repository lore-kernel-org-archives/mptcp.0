Content-Type: multipart/mixed; boundary="===============7158419611260574627=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING: net/mptcp/protocol.c:719
 mptcp_reset_timer+0x40/0x50
Date: Thu, 19 Nov 2020 09:16:02 +0100
Message-ID: <67f05a8c-d582-1748-bf74-9fa9a761427b@tessares.net>
In-Reply-To: CA+G9fYvkRAKBzthvdurQ44q_f9HimG2ur9+M=bgyZ0c+XWucgg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6808

--===============7158419611260574627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

On 19/11/2020 08:04, Naresh Kamboju wrote:
> While running kselftest net/mptcp: mptcp_join.sh on x86_64 device running
> linux next 20201118 tag the following warning was noticed.

Thank you for testing MPTCP and having reported this bug!

It looks like it is similar to what syzbot reported yesterday:

https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/N4IWIL6CYR=
6VSOOOXF25N3EWDW4GTQ6A/

If it is the same, a patch has already been sent to netdev ML:

https://patchwork.kernel.org/project/netdevbpf/patch/1a72039f112cae048c44d3=
98ffa14e0a1432db3d.1605737083.git.pabeni(a)redhat.com/

If it is easy for you to reproduce the issue, please feel free to =

validate Paolo's patch :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7158419611260574627==--
