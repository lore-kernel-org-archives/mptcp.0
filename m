Content-Type: multipart/mixed; boundary="===============2066994068471767169=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH MPTCP 0/2] mptcp: token api refactoring/cleanup
Date: Wed, 04 Sep 2019 13:16:55 +0200
Message-ID: <9c4b2989-2944-b58d-7f47-29c9eab03700@tessares.net>
In-Reply-To: 20190902110909.3724-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1788

--===============2066994068471767169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 02/09/2019 13:09, Florian Westphal wrote:
> I tried to fold the earlier 'RFC v2' in a way so that it allows
> easy squashing.
> =

> Patch #1 is the only one where this is painless.
> For all others, things are not easy because conflicts exist all
> over the place.
> =

> So I see two ways forward:
> 1. I rebase this myself and offer a pull request for the resulting series
> 2. Only squash the first patch and keep the rest as extra patch.
> =

> I suggest we go with #2.

Sounds good to me. Is it OK for others if we do that?

I only propose to squash commits to ease the work for later and still
have a patch-set that can be easy to read, not ending with a lot of "to
squash" patches. But here I understand that there are conflicts everywhere.

Another possibility is to do the "rebase" directly in the TopGit tree if
you prefer. I have no issue to give you the "push" permissions and you
have experience with TopGit. But I can also understand that you prefer
to postpone the rebase for later (or you don't like TopGit :) )

> The export tree already has a few patches
> that need to be squashed anyway before sending a formal series.

That's true. If we want to change that before, simply tell me which
patches have to be squashed and I can already do the work :)

> Also, the export branch is currently not bisectable, I get build
> errors mid-series.

That has to happen :/

Is it something very important if we send the whole patch-set upstream?
I guess it is better to have "consistent" patches and we will certainly
fix that but the goal is to merge the whole series.

> I don't think this is a problem for now, I think it makes sense to
> not squash the larger patches for the time being.

I am fine with that.

> Once another patch series is to be submitted to netdev, the export
> branch can be renamed/archived and a reorganisation can be done at that
> point (and the result diff'd versus the old export branch to make sure
> there is no difference in resulting code).

Sounds good to me!
We can even re-create another TopGit tree in parallel after the rebase
if we think that it will take some times before being accepted upstream.

Another question linked to that: do you think it could be possible and a
good idea to push our code upstream ASAP with known limitations and
continue our work directly in a dedicated repo from git.kernel.org with
"regular" merge request for net-next?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============2066994068471767169==--
