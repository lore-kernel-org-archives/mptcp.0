Content-Type: multipart/mixed; boundary="===============0061546617637191233=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 4th of March 2021
Date: Tue, 09 Mar 2021 17:42:47 -0800
Message-ID: <98755a17-6da7-5384-da8f-425531bd18@linux.intel.com>
In-Reply-To: d412b65b-93b1-3448-852b-fe00d574993c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 8084

--===============0061546617637191233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Sat, 6 Mar 2021, Matthieu Baerts wrote:

> Hi Mat,
>
> On 05/03/2021 00:26, Mat Martineau wrote:
>> On Thu, 4 Mar 2021, Matthieu Baerts wrote:
>>
>>> =C2=A0=C2=A0 - CI (Matth):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Is it OK to sync with net-next a=
nd push without compiling the =

>>> tree if there is no conflict?
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Goal: to decouple CI tasks:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - sync wit=
h upstream (or export in case of changes in the tree) =

>>> =E2=86=92 re-create "export"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - validate=
 build (+ sparse) of each commit of the export branch
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - validate=
 build (+ sparse) of any branch ("PR")
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Reason: We can only have 2 cores=
 per job but have multiple jobs =

>>> in parallel
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Seems OK: devs can use previous =
tags if the last version is =

>>> broken
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - If really it is an issue: deal w=
ith a temporary task and publish =

>>> at the end. (increasing a bit the total time if we need to re-clone a f=
ull =

>>> repo again)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - GH Action in progress
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Next: KVM tests
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Next: patchew (or start that in =
parallel once we are really to =

>>> validate one commit/series with GH Action?)
>> =

>> Matthieu -
>> =

>> You mentioned in the meeting that one challenge was quickly cloning the =

>> kernel repo when a shallow clone would not work. I stumbled across the =

>> linux-bundle-clone script in =

>> https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/ =

>> today, though it might help.
>> =

>> (Konstantin/mricon leads the kernel.org admin team)
>> =

>> It uses git bundle files hosted by kernel.org to speed up cloning a full =

>> repo in CI environments.
>
> Thank you for the pointer, that looks interesting, I never used 'git bund=
le'.
>
> Unfortunately I don't see how to use that with our repo hosted on Github.
>
> For some jobs, I can use a "shallow clone" with a history truncated to a =

> specified number of commits. I don't need the full history to validate th=
e =

> build of our each commit of our export branch. But I need to fetch many =

> branches to manage the TopGit tree. Which is probably fine because we don=
't =

> often modify the tree while we could "often" validate new commits on top =
of =

> the export branch.
>

Hi Matthieu -

I was mainly looking at the bundle script as an example of the commands to =

use *if* an automated build needed a repo with the full git history. I =

agree a shallow clone is going to be the best when the full history is not =

required. I might have misunderstood the concern as being about the full =

git history rather than being about the full set of topgit branches.


Since I was curious about the bundle approach, I just tried an experiment =

with:

  * curl -L "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git/clone.bundle" -o next.bundle
  * git clone next.bundle mptcptest
  * git remote set-url origin https://github.com/multipath-tcp/mptcp_net-ne=
xt.git
  * git fetch origin

and the last step was really fast. I was a little surprised that the =

second step (clone from local bundle) wasn't faster on my system, but I =

assume server-grade hardware would have better disk IO.


--
Mat Martineau
Intel

--===============0061546617637191233==--
