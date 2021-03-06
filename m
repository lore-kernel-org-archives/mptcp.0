Content-Type: multipart/mixed; boundary="===============4873199453487653571=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 4th of March 2021
Date: Sat, 06 Mar 2021 08:43:19 +0100
Message-ID: <d412b65b-93b1-3448-852b-fe00d574993c@tessares.net>
In-Reply-To: b331fa8c-89ed-4e42-08b-9bb08db3be3f@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8057

--===============4873199453487653571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 05/03/2021 00:26, Mat Martineau wrote:
> On Thu, 4 Mar 2021, Matthieu Baerts wrote:
> =

>> =C2=A0=C2=A0 - CI (Matth):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Is it OK to sync with net-next an=
d push without compiling the =

>> tree if there is no conflict?
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Goal: to decouple CI tasks:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - sync with=
 upstream (or export in case of changes in the =

>> tree) =E2=86=92 re-create "export"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - validate =
build (+ sparse) of each commit of the export =

>> branch
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - validate =
build (+ sparse) of any branch ("PR")
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Reason: We can only have 2 cores =
per job but have multiple =

>> jobs in parallel
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Seems OK: devs can use previous t=
ags if the last version is =

>> broken
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - If really it is an issue: deal wi=
th a temporary task and =

>> publish at the end. (increasing a bit the total time if we need to =

>> re-clone a full repo again)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - GH Action in progress
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Next: KVM tests
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Next: patchew (or start that in p=
arallel once we are really =

>> to validate one commit/series with GH Action?)
> =

> Matthieu -
> =

> You mentioned in the meeting that one challenge was quickly cloning the =

> kernel repo when a shallow clone would not work. I stumbled across the =

> linux-bundle-clone script in =

> https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/ =

> today, though it might help.
> =

> (Konstantin/mricon leads the kernel.org admin team)
> =

> It uses git bundle files hosted by kernel.org to speed up cloning a full =

> repo in CI environments.

Thank you for the pointer, that looks interesting, I never used 'git =

bundle'.

Unfortunately I don't see how to use that with our repo hosted on Github.

For some jobs, I can use a "shallow clone" with a history truncated to a =

specified number of commits. I don't need the full history to validate =

the build of our each commit of our export branch. But I need to fetch =

many branches to manage the TopGit tree. Which is probably fine because =

we don't often modify the tree while we could "often" validate new =

commits on top of the export branch.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4873199453487653571==--
