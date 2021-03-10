Content-Type: multipart/mixed; boundary="===============0367192504537086991=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 4th of March 2021
Date: Wed, 10 Mar 2021 23:46:07 +0100
Message-ID: <6ff8228f-1cfa-5b93-ed82-973a89115ac8@tessares.net>
In-Reply-To: 98755a17-6da7-5384-da8f-425531bd18@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8093

--===============0367192504537086991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 10/03/2021 02:42, Mat Martineau wrote:
> =

> On Sat, 6 Mar 2021, Matthieu Baerts wrote:
> =

>> Hi Mat,
>>
>> On 05/03/2021 00:26, Mat Martineau wrote:
>>> On Thu, 4 Mar 2021, Matthieu Baerts wrote:
>>>
>>>> =C2=A0=C2=A0 - CI (Matth):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Is it OK to sync with net-next =
and push without compiling =

>>>> the tree if there is no conflict?
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Goal: to decouple CI tasks:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - sync wi=
th upstream (or export in case of changes in the =

>>>> tree) =E2=86=92 re-create "export"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - validat=
e build (+ sparse) of each commit of the export =

>>>> branch
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - validat=
e build (+ sparse) of any branch ("PR")
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Reason: We can only have 2 core=
s per job but have multiple =

>>>> jobs in parallel
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Seems OK: devs can use previous=
 tags if the last version is =

>>>> broken
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - If really it is an issue: deal =
with a temporary task and =

>>>> publish at the end. (increasing a bit the total time if we need to =

>>>> re-clone a full repo again)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - GH Action in progress
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Next: KVM tests
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Next: patchew (or start that in=
 parallel once we are really =

>>>> to validate one commit/series with GH Action?)
>>>
>>> Matthieu -
>>>
>>> You mentioned in the meeting that one challenge was quickly cloning =

>>> the kernel repo when a shallow clone would not work. I stumbled =

>>> across the linux-bundle-clone script in =

>>> https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git=
/ =

>>> today, though it might help.
>>>
>>> (Konstantin/mricon leads the kernel.org admin team)
>>>
>>> It uses git bundle files hosted by kernel.org to speed up cloning a =

>>> full repo in CI environments.
>>
>> Thank you for the pointer, that looks interesting, I never used 'git =

>> bundle'.
>>
>> Unfortunately I don't see how to use that with our repo hosted on Github.
>>
>> For some jobs, I can use a "shallow clone" with a history truncated to =

>> a specified number of commits. I don't need the full history to =

>> validate the build of our each commit of our export branch. But I need =

>> to fetch many branches to manage the TopGit tree. Which is probably =

>> fine because we don't often modify the tree while we could "often" =

>> validate new commits on top of the export branch.
>>
> =

> Hi Matthieu -
> =

> I was mainly looking at the bundle script as an example of the commands =

> to use *if* an automated build needed a repo with the full git history. =

> I agree a shallow clone is going to be the best when the full history is =

> not required. I might have misunderstood the concern as being about the =

> full git history rather than being about the full set of topgit branches.
> =

> =

> Since I was curious about the bundle approach, I just tried an =

> experiment with:
> =

>  =C2=A0* curl -L =

> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/clon=
e.bundle" =

> -o next.bundle
>  =C2=A0* git clone next.bundle mptcptest
>  =C2=A0* git remote set-url origin =

> https://github.com/multipath-tcp/mptcp_net-next.git
>  =C2=A0* git fetch origin
> =

> and the last step was really fast. I was a little surprised that the =

> second step (clone from local bundle) wasn't faster on my system, but I =

> assume server-grade hardware would have better disk IO.

Yes, that could be great. If I notice it is too slow, I would go to this =

direction, thank you!

I also need to be able to push to the repo and this official "action" =

helps us for that: https://github.com/marketplace/actions/checkout

But maybe not too difficult to fork the project and modify the clone =

part to be able to use a Git bundle if needed!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0367192504537086991==--
