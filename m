Content-Type: multipart/mixed; boundary="===============0843242539224334289=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: fix for most poll selftest timeouts
Date: Sat, 29 Aug 2020 22:39:44 +0200
Message-ID: <1369d912-6022-1702-fc70-a822b4c6dd75@tessares.net>
In-Reply-To: 20200829201037.GH7319@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 5668

--===============0843242539224334289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 29/08/2020 22:10, Florian Westphal wrote:
> Turns out that almost all of the 'poll timeout' test failures are related
> to subflow->writable getting stale.  Its false even though the subflow is
> writeable, i.e. userspace is not woken up after socket can accept new dat=
a.
> =

> Rather than fixing the race that leads to the information becoming stale
> Paolo suggested to just remove the 'writable' caching.
> I've done this by editing the commit that introduced it
> ("mptcp: rethink 'is writable' conditional").
> =

> While doing so I also squashed sk_stream_is_writeable() and removed
> "mptcp: fix stale subflow->writeable caching" as its obsolete by the
> removal of this struct member.
> =

> Only remaining occurence of poll timeouts seem to be related to
> mptcp-level fin not being delivered/processed, investigation is ongoing.
> =

> I've pushed the resulting branch here:
> https://git.breakpoint.cc/cgit/fw/mptcp_net-next.git/log/?h=3Dexport_reba=
se_5
> =

> which can also be pulled via
> git://git.breakpoint.cc/fw/mptcp_net-next.git export_rebase_5
> =

> Alternatively, edit "mptcp: rethink 'is writable' conditional" and remove
> "bool writable" from mptcp_subflow_ctx struct, then fix up the resulting
> merge conflicts.
> =

> After this mmap tests still pass and it takes about 50 normal poll
> self-test runs before the first timeout is seen, on average.
> (before change, its less than 10).

Thank you for the modifications and explanations!

The TopGit tree has been rewritten using your branch. Tests + export are =

in progress.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0843242539224334289==--
