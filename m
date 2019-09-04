Content-Type: multipart/mixed; boundary="===============1639148864797227442=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH MPTCP 0/2] mptcp: token api refactoring/cleanup
Date: Wed, 04 Sep 2019 13:53:22 +0200
Message-ID: <8897dad2-c864-01cc-ee30-639ebbe956b9@tessares.net>
In-Reply-To: 20190904114337.GH13660@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1790

--===============1639148864797227442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Thank you for your quick answer!

On 04/09/2019 13:43, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> I only propose to squash commits to ease the work for later and still
>> have a patch-set that can be easy to read, not ending with a lot of "to
>> squash" patches. But here I understand that there are conflicts everywhe=
re.
> =

> I have no problem with squashing the 'obvious' patches.
> =

>> Another possibility is to do the "rebase" directly in the TopGit tree if
>> you prefer. I have no issue to give you the "push" permissions and you
>> have experience with TopGit. But I can also understand that you prefer
>> to postpone the rebase for later (or you don't like TopGit :) )
> =

> I would have to take a look at topgit again.  I used it for a short
> period but that was more than 6 years ago.

I guess the logic is still the same but they improved the workflow, more
tools and better speed: https://github.com/mackyle/topgit

>>> The export tree already has a few patches
>>> that need to be squashed anyway before sending a formal series.
>>
>> That's true. If we want to change that before, simply tell me which
>> patches have to be squashed and I can already do the work :)
>>
>>> Also, the export branch is currently not bisectable, I get build
>>> errors mid-series.
>>
>> That has to happen :/
> =

> Why?

I was suspecting that with the all the squashes and rebase we did and
continue to do. If we do not monitor this, we will have more issues :)
On my side, I don't compile each commit we export.

>> Is it something very important if we send the whole patch-set upstream?
> =

> Yes, each step on the way needs to result in a compileable tree.
> Otherwise, other developers doing 'git bisect' on the kernel later will
> may hit this.

It makes sense, thank you!

>> I guess it is better to have "consistent" patches and we will certainly
>> fix that but the goal is to merge the whole series.
> =

> Of course.  Note that its not a problem to add a function in patch n
> and then only add a user in patch n+1 later in the series.

Thank you for your answer!

>>> Once another patch series is to be submitted to netdev, the export
>>> branch can be renamed/archived and a reorganisation can be done at that
>>> point (and the result diff'd versus the old export branch to make sure
>>> there is no difference in resulting code).
>>
>> Sounds good to me!
>> We can even re-create another TopGit tree in parallel after the rebase
>> if we think that it will take some times before being accepted upstream.
> =

> Thats good to know.
> =

>> Another question linked to that: do you think it could be possible and a
>> good idea to push our code upstream ASAP with known limitations and
>> continue our work directly in a dedicated repo from git.kernel.org with
>> "regular" merge request for net-next?
> =

> I think its good to merge early, but it needs to be well
> understood/described where the limits are.
> =

> At the moment I don't think we're there yet.
> =

> Once mptcp_poll is a bit saner (I added a note to the pad and will be
> working on this), we've sorted out token refcounting (also working on
> this), Paolos retrans patches are in *and* we can deal with data
> arriving on multiple subflows I think we'd be good for a non-rfc
> patchset.
> =

> IPv6 would be nice but I don't think its a deal-breaker if we'd
> place it on the immediate post-merge todo list.

Excellent, thank you for sharing this with us! I also added this to the pad!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1639148864797227442==--
