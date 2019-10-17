Content-Type: multipart/mixed; boundary="===============1304682657915455663=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/4] mptcp: fix compilation errors without IPV6
Date: Thu, 17 Oct 2019 16:58:13 +0200
Message-ID: <0c6a8992-ecfa-3d2c-9902-bdc36682c112@tessares.net>
In-Reply-To: 20191017145047.8900-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2224

--===============1304682657915455663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 17/10/2019 16:50, Matthieu Baerts wrote:
> I just checked the compilation without CONFIG_IPV6 and fixed what GCC was
> complaining about. Nothing fancy.
> =

> v2:
>    - fix coding style as suggested by Paolo
>    - drop "mptcp:basic: check for v6 family" (Peter)
> =

> Matthieu Baerts (4):
>    mptcp: fix compilation warning without IPV6
>    mptcp: fix compilation error without IPV6
>    mptcp:ipv6: fix code style
>    mptcp:ipv6: fix code style
> =

>   net/mptcp/basic.c   |  6 ++++--
>   net/mptcp/options.c | 10 +++++++---
>   net/mptcp/pm.c      |  4 +++-
>   3 files changed, 14 insertions(+), 6 deletions(-)

I already applied the two first ones:

- 023e3e279137: "squashed" patch 1/4 in "mptcp: Add path manager interface"
- 93c165a10b9b: "squashed" patch 2/4 in "mptcp: Add ADD_ADDR handling"
- f3397e47be58..4f62a71b1a5c: results

Tests are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1304682657915455663==--
