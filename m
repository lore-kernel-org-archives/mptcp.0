Content-Type: multipart/mixed; boundary="===============5459592331966810472=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Gerrit: use cases
Date: Wed, 07 Nov 2018 17:25:55 +0000
Message-ID: <CAKuKrBn_Y3eegxqfZdYkm-2wfbn5gEO+F78ne=PyUPUv7ET6uA@mail.gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 834

--===============5459592331966810472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

At the last meeting we had 2 weeks ago, we were interested by using
Gerrit to help reviewing large patches sets.
We were also interested by using TopGit later to ease maintenance of
patches that are "ready to publish" without having to do any rebase on
published branches on this repo.

We would then like to combine the two tools but keep Github as repo
containing the code. We identify gerrithub.io as free Gerrit service
which mirrors the code on Github for us.
The Github repo will be used in a read-only mode, all push should go
via the Gerrit server.

To use both Gerrit and TopGit tools, it is easy: we propose Changes on
Gerrit like on any Gerrit server (e.g. by using 'git-review' tool) but
we don't accept any "Submit" (aka "Merge") it. Instead, someone (the
developer?) can integrate it in the Topgit tree.

In order to configure Gerrit properly, we first need to list the
different use cases we want to support. Here are the ones I see for
the moment:

- anybody can create new Changes (aka Pull Request) for the top branch
  - can anybody create Changes for others? (pusher !=3D commiter) or do
we want to restrict that for a group of people? Should be OK for me to
allow that for anybody
  - can anybody propose a new version of other's Changes?
  - anybody can read these new Changes
- anybody can create new Changes for any topic branches (Note: ideally
we should prefix these branches, e.g. "t/(...)")
- nobody can push force (except admins, just in case)
- only a group of people can modify the Topgit tree:
  - create new topics (refs/heads/t/* + refs/top-bases/t/*) =E2=86=92 Creat=
e Reference
  - modify topics (push) =E2=86=92 Push, Push Merge Commits, Forge Author
Identity and Committer Identity
  - delete topics (?)
- only a group of people can update the base of the Topgit tree (sync
with net-next).
- anybody can create a WIP branch (refs/heads/sandbox/${username}/*).
Or only a group of people? (IMO it is maybe better to restrict to a
group of people, anybody can create a fork on Github anyway)
- anybody can comment and give a "Code-Review +1" ("Looks good to me,
but someone else must approve)
- only a group of people can give a "Code-Review +2" ("Looks good to
me, approved)
- only another group of people (QA + CI?) can give a Verified +1
- only admin can manage the Gerrit config
- only a group of people can tag (also with push force permission?)

Please comment if you see other use-cases!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5459592331966810472==--
