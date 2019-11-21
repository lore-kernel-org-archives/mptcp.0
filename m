Content-Type: multipart/mixed; boundary="===============8750062437791486541=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: fix for ipv6-related oops
Date: Thu, 21 Nov 2019 15:15:10 +0100
Message-ID: <e26cfe95-f7e8-0d5d-8b8e-3642b4f765ca@tessares.net>
In-Reply-To: cover.1574338647.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2648

--===============8750062437791486541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 21/11/2019 13:25, Paolo Abeni wrote:
> We need to allocate a larger struct sock for mptcp v6 master sockets,
> otherwise inet6_sk() will access mptcp related data instead of
> struct ipv6_pinfo.
> =

> This should fix the crash reported by Matt.

Thank you for the quick fix!

> The protocol.c code changes are split in 2 patches to simplify the
> squashing.
> (yep, I know we somewhat agreed to big giant rebase, but this specific
> should be trivial).

That's a good idea because for the moment, the CI is notifying me each =

time that the kselftests are failing (when testing the commit =

introducing them)!

> Additionally adds some fixlet for the ipv6 tests

I have a few questions in the 2 first patches.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8750062437791486541==--
