Content-Type: multipart/mixed; boundary="===============2461874990895363293=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 1/4] MAINTAINERS: Add MPTCP maintainers
Date: Fri, 13 Dec 2019 15:30:29 +0100
Message-ID: <47f4034c-4625-7784-c364-fe8d79c23399@tessares.net>
In-Reply-To: 20191207001244.20339-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2935

--===============2461874990895363293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 07/12/2019 01:12, Mat Martineau wrote:
> Possible other lines include:
> =

> L:	mptcp(a)lists.01.org
> =

> The issue with including this ML is that it currently rejects messages
> from non-subscribers. I can reconfigure the ML, the tradeoff is in
> forwarding spam to subscribers.
> =

> Q:	https://patchwork.ozlabs.org/project/mptcp/list/
> =

> It might be confusing for patches to end up in two patchworks (netdev
> and mptcp).
> =

> T:	git git://github.com/multipath-tcp/mptcp_net-next.git
> =

> I've seen two main models for net subsystem management:
> =

> netdev-based (TCP, TLS): Patches are sent to netdev, approved by
> subsystem maintainers, and approved and applied by David Miller.
> =

> subtree (netfilter, BPF, bluetooth, wireless): Messages are sent to
> netdev (netfilter/BPF) or a separate ML (bluetooth, wireless) and are
> approved and merged to separate git repositories by subsystem
> maintainers. Those maintainers then send pull requests for batches of
> commits to netdev for David Miller to merge directly in git.
> =

> The scope of MPTCP seems more like the other netdev-based projects, so
> for changes going directly upstream I've proposed MAINTAINERS entries
> that match that development model. If we opt to use our own git repo to
> merge upstream changes and then send pull requests, then we would
> include the "T:" entry for our github repo.
> =

> squashto: mptcp: Add MPTCP to skb extensions
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Thank you for the patches!

- 85cadeef7913: "squashed" patch 1/4 in "mptcp: Add MPTCP to skb extensions"
- 174e3a78b692: MAINTAINERS: add mptcp mailing list
- d02679c02f0f: "squashed" patch 2/4 in "mptcp: Add MPTCP socket stubs"
- 924ae04a4a8d: "squashed" patch 3/4 in "mptcp: add basic kselftest for =

mptcp"
- 2b43fcb3011c: "squashed" patch 4/4 in "mptcp: allow dumping subflow =

context to userspace"
- 3c324d81df61..3c65e8cb3ba6: results

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2461874990895363293==--
