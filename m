Content-Type: multipart/mixed; boundary="===============4109278983093195462=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [GIT] Sync with net-next on 20190131: a few conflicts
Date: Tue, 04 Feb 2020 07:40:12 -0800
Message-ID: <20200204154012.GF33105@MacBook-Pro-64.local>
In-Reply-To: 91c726c1-6425-8b63-2f6f-b4ff803c9b93@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3585

--===============4109278983093195462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 04/02/20 - 15:58:49, Matthieu Baerts wrote:
> Hello,
> =

> On 02/02/2020 09:38, Matthieu Baerts wrote:
> > On 31/01/2020 18:42, Matthieu Baerts wrote:
> > > Hello,
> > > =

> > > It seems that recently, 'net-next' has been synced with 'net' which
> > > contains some modifications in MPTCP code. We then had a few
> > > conflicts due to Florian's patch-set, see: 55c6ab4b368 (Merge branch
> > > 'mptcp-fix-sockopt-crash-and-lockdep-splats')
> > > =

> > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit=
/?id=3Dd55c6ab4b368633f39f8fe059f3b877f978cfb4c
> > =

> > =

> > FYI, I was not able to validate the new version after having resolved
> > conflicts because it crashed before starting MPTCP:
> =

> Again FYI, net-next has been updated a few minutes ago and it includes a =
fix
> for the crash I reported 2 days ago.
> After a rebase, the CI has just validated the new "export" branch and all
> tests are passing.

Great! I move syzkaller on top of the export-branch then.


Christoph

> =

> Cheers,
> Matt
> -- =

> Matthieu Baerts | R&D Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============4109278983093195462==--
