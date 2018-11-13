Content-Type: multipart/mixed; boundary="===============2286626544585175485=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Gerrit: use cases
Date: Tue, 13 Nov 2018 15:20:14 -0800
Message-ID: <20181113232014.GK23972@MacBook-Pro-19.local>
In-Reply-To: alpine.OSX.2.21.1811131443360.10092@lpbeverl-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 838

--===============2286626544585175485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 13/11/18 - 15:17:11, Mat Martineau wrote:
> =

> On Wed, 7 Nov 2018, Matthieu Baerts wrote:
> =

> > Hello,
> > =

> > At the last meeting we had 2 weeks ago, we were interested by using
> > Gerrit to help reviewing large patches sets.
> > We were also interested by using TopGit later to ease maintenance of
> > patches that are "ready to publish" without having to do any rebase on
> > published branches on this repo.
> > =

> > We would then like to combine the two tools but keep Github as repo
> > containing the code. We identify gerrithub.io as free Gerrit service
> > which mirrors the code on Github for us.
> > The Github repo will be used in a read-only mode, all push should go
> > via the Gerrit server.
> > =

> > To use both Gerrit and TopGit tools, it is easy: we propose Changes on
> > Gerrit like on any Gerrit server (e.g. by using 'git-review' tool) but
> > we don't accept any "Submit" (aka "Merge") it. Instead, someone (the
> > developer?) can integrate it in the Topgit tree.
> > =

> > In order to configure Gerrit properly, we first need to list the
> > different use cases we want to support. Here are the ones I see for
> > the moment:
> > =

> > - anybody can create new Changes (aka Pull Request) for the top branch
> >  - can anybody create Changes for others? (pusher !=3D commiter) or do
> > we want to restrict that for a group of people? Should be OK for me to
> > allow that for anybody
> >  - can anybody propose a new version of other's Changes?
> >  - anybody can read these new Changes
> > - anybody can create new Changes for any topic branches (Note: ideally
> > we should prefix these branches, e.g. "t/(...)")
> > - nobody can push force (except admins, just in case)
> > - only a group of people can modify the Topgit tree:
> >  - create new topics (refs/heads/t/* + refs/top-bases/t/*) =E2=86=92 Cr=
eate Reference
> >  - modify topics (push) =E2=86=92 Push, Push Merge Commits, Forge Author
> > Identity and Committer Identity
> >  - delete topics (?)
> > - only a group of people can update the base of the Topgit tree (sync
> > with net-next).
> > - anybody can create a WIP branch (refs/heads/sandbox/${username}/*).
> > Or only a group of people? (IMO it is maybe better to restrict to a
> > group of people, anybody can create a fork on Github anyway)
> > - anybody can comment and give a "Code-Review +1" ("Looks good to me,
> > but someone else must approve)
> > - only a group of people can give a "Code-Review +2" ("Looks good to
> > me, approved)
> > - only another group of people (QA + CI?) can give a Verified +1
> > - only admin can manage the Gerrit config
> > - only a group of people can tag (also with push force permission?)
> > =

> > Please comment if you see other use-cases!
> =

> =

> Hi Matthieu -
> =

> We discussed gerrithub and github in our 08-November meeting, and from the
> meeting outline for tomorrow it appears that you'd like some more feedback
> on this thread.
> =

> =

> I think you outlined a good set of permissions. If we've overlooked
> anything, they can always be updated later on.
> =

> Regarding a possible topgit+gerrit workflow, I think the use case would be
> for patch series authors to make use of topgit in their own repositories
> (public or private). They could work on their patchsets, then "tg export"
> them and push the exported commits to gerrit for review. (I believe this =
is
> what Christoph was also advocating in our last meeting, please let me know
> if I misunderstood).

Yes, that's right. I was advocating for that.


Cheers,
Christoph

> The Commit-Id tags can be maintained in .topmsg files
> and edited out before upstreaming.
> =

> I think a shared topgit tree would be a challenge for a team that's not a=
ll
> in one organization. Maybe I'm just early in the topgit learning curve, b=
ut
> I've made a few minor mistakes sharing a topgit repo across multiple
> machines already (forgetting the --all in 'tg push --all', for example).
> =

> If we decide as a group that gerrithub is the tool we want to use, I can
> help with configuring gerrit permissions. I have some prior experience wi=
th
> that from another project.
> =

> =

> One question about gerrithub: Can it be configured to only control/mirror
> certain branches in a github repository? Or if there were non-gerrithub
> branches would those be better off in a separate github repository?
> =

> --
> Mat Martineau
> Intel OTC

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============2286626544585175485==--
