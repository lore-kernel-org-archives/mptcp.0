Content-Type: multipart/mixed; boundary="===============0264316524049579613=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 4th of March 2021
Date: Thu, 04 Mar 2021 15:26:49 -0800
Message-ID: <b331fa8c-89ed-4e42-08b-9bb08db3be3f@linux.intel.com>
In-Reply-To: 8a568102-5ff5-f7c1-e234-46f523d5cafc@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 8038

--===============0264316524049579613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Mar 2021, Matthieu Baerts wrote:

>    - CI (Matth):
>        - Is it OK to sync with net-next and push without compiling the tr=
ee =

> if there is no conflict?
>        - Goal: to decouple CI tasks:
>            - sync with upstream (or export in case of changes in the tree=
) =

> =E2=86=92 re-create "export"
>            - validate build (+ sparse) of each commit of the export branch
>            - validate build (+ sparse) of any branch ("PR")
>        - Reason: We can only have 2 cores per job but have multiple jobs =
in =

> parallel
>        - Seems OK: devs can use previous tags if the last version is brok=
en
>        - If really it is an issue: deal with a temporary task and publish=
 at =

> the end. (increasing a bit the total time if we need to re-clone a full r=
epo =

> again)
>        - GH Action in progress
>        - Next: KVM tests
>        - Next: patchew (or start that in parallel once we are really to =

> validate one commit/series with GH Action?)

Matthieu -

You mentioned in the meeting that one challenge was quickly cloning the =

kernel repo when a shallow clone would not work. I stumbled across the =

linux-bundle-clone script in =

https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/ =

today, though it might help.

(Konstantin/mricon leads the kernel.org admin team)

It uses git bundle files hosted by kernel.org to speed up cloning a full =

repo in CI environments.

--
Mat Martineau
Intel

--===============0264316524049579613==--
